/*
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
*/
#include <systemd/sd-journal.h>
#include <boost/algorithm/string.hpp>
#include <boost/container/flat_map.hpp>
#include <boost/container/flat_set.hpp>
#include <filesystem>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <sdbusplus/asio/object_server.hpp>
#include <sstream>

#include <phosphor-logging/elog-errors.hpp>
#include <xyz/openbmc_project/Sensor/Threshold/error.hpp>
#include <xyz/openbmc_project/Logging/Entry/server.hpp>

static constexpr char const *ipmiSelObject = "xyz.openbmc_project.Logging.IPMI";

using namespace phosphor::logging;
using namespace sdbusplus::xyz::openbmc_project::Sensor::Threshold::Error;

static sdbusplus::bus::match::match startThresholdEventMonitor(
    std::shared_ptr<sdbusplus::asio::connection> conn)
{
    auto thresholdEventMatcherCallback = [conn](
                                             sdbusplus::message::message &msg) {

        // Get the event type and assertion details from the message
        std::string thresholdInterface;
        boost::container::flat_map<std::string, std::variant<bool>>
            propertiesChanged;
        msg.read(thresholdInterface, propertiesChanged);
        std::string event = propertiesChanged.begin()->first;
        bool *pval = std::get_if<bool>(&propertiesChanged.begin()->second);
        if (!pval)
        {
            std::cerr << "threshold event direction has invalid type\n";
            return;
        }
        bool assert = *pval;
        if (assert == false)
            return;

        // Get the sensor reading to put in the event data
        sdbusplus::message::message getSensorValue =
            conn->new_method_call(msg.get_sender(), msg.get_path(),
                    "org.freedesktop.DBus.Properties", "GetAll");
        getSensorValue.append("xyz.openbmc_project.Sensor.Value");
        boost::container::flat_map<std::string, std::variant<double, int64_t>>
            sensorValue;
        try
        {
            sdbusplus::message::message getSensorValueResp =
                conn->call(getSensorValue);
            getSensorValueResp.read(sensorValue);
        }
        catch (sdbusplus::exception_t &)
        {
            std::cerr << "error getting sensor value from " << msg.get_path()
                << "\n";
            return;
        }
        int64_t sensorVal = 0;
        auto findVal = sensorValue.find("Value");
        if (findVal != sensorValue.end())
        {
            sensorVal = std::get<int64_t>(findVal->second);
        }

        // Get the threshold parameter by removing the "Alarm" text from the
        // event string
        std::string alarm("Alarm");
        if (std::string::size_type pos = event.find(alarm);
                pos != std::string::npos)
        {
            event.erase(pos, alarm.length());
        }
        sdbusplus::message::message getThreshold =
            conn->new_method_call(msg.get_sender(), msg.get_path(),
                    "org.freedesktop.DBus.Properties", "Get");
        getThreshold.append(thresholdInterface, event);
        std::variant<double, int64_t> thresholdValue;
        try
        {
            sdbusplus::message::message getThresholdResp =
                conn->call(getThreshold);
            getThresholdResp.read(thresholdValue);
        }
        catch (sdbusplus::exception_t &)
        {
            std::cerr << "error getting sensor threshold from "
                << msg.get_path() << "\n";
            return;
        }
        int64_t thresholdVal = std::get<int64_t>(thresholdValue);

        std::string InvPath(msg.get_path());
        if (event == "CriticalLow")
        {
            InvPath.append("/critical_low");
        }
        else if (event == "WarningLow")
        {
            InvPath.append("/warning_low");
        }
        else if (event == "WarningHigh")
        {
            InvPath.append("/warning_high");
        }
        else if (event == "CriticalHigh")
        {
            InvPath.append("/critical_high");
        }

        std::string journalMsg = "Sensor Alarm";
        unsigned int transactionId = sdbusplus::server::transaction::get_id();
        sd_journal_send("MESSAGE=%s", journalMsg.c_str(),
                "TRANSACTION_ID=%u", transactionId,
                "CALLOUT_INVENTORY_PATH=%s", InvPath.c_str(),
                "SENSOR_DATA=%lld,%lld", sensorVal,thresholdVal, NULL);
        if (event == "CriticalLow")
            commit<CriticalLow>();
        else if (event == "WarningLow")
            commit<WarningLow>();
        else if (event == "CriticalHigh")
            commit<CriticalHigh>();
        else if (event == "WarningHigh")
            commit<WarningHigh>();
    };
    sdbusplus::bus::match::match thresholdEventMatcher(
        static_cast<sdbusplus::bus::bus &>(*conn),
        "type='signal',interface='org.freedesktop.DBus.Properties',member='"
        "PropertiesChanged',arg0namespace='xyz.openbmc_project.Sensor."
        "Threshold'",
        std::move(thresholdEventMatcherCallback));
    return thresholdEventMatcher;
}

int main(int argc, char *argv[])
{
    // setup connection to dbus
    boost::asio::io_service io;
    auto conn = std::make_shared<sdbusplus::asio::connection>(io);

    // IPMI SEL Object
    conn->request_name(ipmiSelObject);
    auto server = sdbusplus::asio::object_server(conn);

    sdbusplus::bus::match::match thresholdEventMonitor =
        startThresholdEventMonitor(conn);

    io.run();

    return 0;
}
