/**
 * Copyright 2017 Google Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <fcntl.h>
#include <getopt.h>
#include <systemd/sd-event.h>
#include <unistd.h>

#include <array>
#include <cstdint>
#include <exception>
#include <iostream>
#include <memory>
#include <sdeventplus/event.hpp>
#include <sdeventplus/source/event.hpp>
#include <sdeventplus/source/io.hpp>
#include <thread>
#include <cstring>

#include <sys/types.h>
#include <sys/time.h>
#include <poll.h>

static const char* vdmFilename = "/dev/npcm7xx-vdm";

enum class MCTP_CONTROL
{
  RESERVED = 0,
  SET_ENDPOINT_ID,
  GET_ENDPOINT_ID,
  GET_ENDPOINT_UUID,
  GET_MCTP_VERSION_SUPPORT,
  GET_MESSAGE_TYPE_SUPPORT,
  GET_VENDOR_DEFINED_MESSAGE_SUPPORT,
  RESOLVE_ENDPOINT_ID,
  ALLOCATE_ENDPOINT_IDS,
  ROUTEING_INFORMATION_UPDATE,
  GET_ROUTEING_TABLE,
  PREPARE_FOR_ENDPOINT_DISCOVERY,
  ENDPOINT_DISCOVERY,
  DISCOVERY_NOTIFY,
  GET_NETWORK_ID,
  QUERY_HOP,
  RESOLVE_UUID,
  QUERY_RATE_LIMIT,
  REQUEST_TX_RATE_LIMIT,
  UPDATE_RATE_LIMIT,
  QUERY_SUPPORTED_INTERFACES,
};

/* MCTP hdr definitions */
struct mctp_hdr {
	uint8_t	ver;
	uint8_t	dest;
	uint8_t	src;
    uint8_t som;
    uint8_t eom;
    uint8_t pktseq;
    uint8_t to;
	uint8_t	msgtag;
};

/* PCI vdm definitions */
struct pci_hdr {
	uint16_t rid;
	uint16_t tid;
	uint8_t pad;
	uint8_t len;
    uint8_t type;
};

/* MCTP package payload */
struct mctp_ctrl {
    uint8_t type;
    uint8_t ic;
    uint8_t id;
    uint8_t d;
    uint8_t rq;
    uint8_t command;
    uint8_t* op;
    uint8_t* data;
    uint8_t data_len;
};

int prepare_mctp_header(uint32_t* data, struct mctp_hdr *hdr)
{
    if (data && hdr) {
        data[3] = (hdr->ver << 0) | (hdr->dest  << 8) | (hdr->src  << 16) | 
            (((hdr->msgtag << 0) | (hdr->to << 3) | (hdr->pktseq << 4) |
            (hdr->eom << 6)| (hdr->som << 7)) << 24);

        return 0;
    }
    return -1;
}

int prepare_pci_header(uint32_t* data, struct pci_hdr *hdr)
{
    if (data && hdr) {
        uint32_t VDM_VENDOR_ID = 0x1ab4;
        uint32_t PCIE_HEADER0_FMT = (0x03 << 5);
        uint32_t PCIE_HEADER0_TYPE = (0x10 | hdr->type);
        uint32_t PCIE_HEADER0_ATTR = (0x00 << 4) << 16;
        uint32_t PCIE_HEADER0_LENGTH = hdr->len << 24;

        uint32_t PCIE_HEADER1_TAG = (hdr->pad << 4) << 16;
        uint32_t PCIE_HEADER1_VED = 0x7f << 24;

        uint32_t PCIE_HEADER2_VENDORID =  (((VDM_VENDOR_ID >> 8) & 0xff) << 16) | ((VDM_VENDOR_ID & 0xff) << 24 );

        data[0] = PCIE_HEADER0_FMT | PCIE_HEADER0_TYPE | PCIE_HEADER0_ATTR | PCIE_HEADER0_LENGTH;
        data[1] = ((hdr->rid >> 8) & 0xff) | ((hdr->rid & 0xff) << 8) | PCIE_HEADER1_TAG | PCIE_HEADER1_VED;
        data[2] = ((hdr->tid >> 8) & 0xff) | ((hdr->tid & 0xff) << 8) | PCIE_HEADER2_VENDORID;
        return 0;
    }
    return -1;
}

int prepare_control_msg(uint32_t* data, struct mctp_ctrl *ctrl)
{   
    int len = ctrl->data_len;

    data[4] = ((ctrl->rq << 7) << 8)| (ctrl->command << 16);
    len += 3;

    if (ctrl->data)
        data[4] |= (ctrl->data[0] << 24);

    if (ctrl->data_len > 1)
        memcpy(&data[5], &ctrl->data[1], ctrl->data_len - 1);

    return len;
}


/*
 * TODO(venture): this only listens one of the possible snoop ports, but
 * doesn't share the namespace.
 *
 * This polls() the lpc snoop character device and it owns the dbus object
 * whose value is the latest port 80h value.
 */
int main(int argc, char* argv[])
{
    int rc = 0;
    struct pollfd fds;
    struct pci_hdr pci;
    struct mctp_hdr mctp;
    struct mctp_ctrl ctrl;

    fds.fd = open(vdmFilename, O_RDWR);
    if (fds.fd  < 0)
    {
        fprintf(stderr, "Unable to open: %s\n", vdmFilename);
        return -1;
    }

    fds.events = POLLIN;

   //std::array<uint32_t, BUFFER_SIZE> buffer;
    uint32_t vdm_array[10] = {0};

    memset(&ctrl, 0 ,sizeof(ctrl));
    ctrl.rq = 1;
    ctrl.command = static_cast<uint8_t>(MCTP_CONTROL::DISCOVERY_NOTIFY);
    //uint8_t rdata[1];
    //rdata[0] = 0xff;
   // rdata[1] = 0;
   // rdata[2] = 1;
    //ctrl.data = rdata;
    ctrl.data_len = 0;
    int len = prepare_control_msg(vdm_array, &ctrl);

    memset(&pci, 0 ,sizeof(pci));
    pci.rid = (0 << 8) | (0 << 3) | 0x00;
    pci.tid = (0 << 8) | (0 << 3) | 0x00;
    pci.type = 0;
    pci.pad = 4 - (len % 4);
    pci.len = (len >> 2);

    if (len < 4)
        pci.len = 1;
    else if (len % 4)
        pci.len += 1;
    prepare_pci_header(vdm_array, &pci);


    memset(&mctp, 0 ,sizeof(mctp));
    mctp.ver = 1;
    mctp.dest = 0;
    mctp.src = 0;
    mctp.som = 1;
    mctp.eom = 1;
    mctp.pktseq = 0;
    mctp.to = 1;
    mctp.msgtag = 0;
    prepare_mctp_header(vdm_array, &mctp);

    fprintf(stderr, "write to : %s\n", vdmFilename);
    ssize_t written = write(fds.fd , vdm_array, 16 + (pci.len * 4));
    if (written > 0)
        fprintf(stderr, "write %d\n", written);

    int timeout_msecs = -1;

    while(1) {
        uint32_t buf[20];
        int i;
        rc = poll(&fds, 1, timeout_msecs);
		if (rc < 0) {
			if (errno == EINTR) {
				continue;
			} else {
				fprintf(stderr, "poll error");
				break;
			}
		}

		/* process internal fd first */
		if (fds.revents) {
			rc = read(fds.fd, buf, sizeof(buf));
			if (rc <= 0) {
				fprintf(stderr, "Error reading from tty device");
				rc = -1;
				break;
			}
            int len = (rc >> 2) + (rc % 4);
            for (i = 0; i < len; i++)
                fprintf(stderr, "read 0x%x\n", buf[i]);
		}


    }

    close(fds.fd );

    return rc;
}
