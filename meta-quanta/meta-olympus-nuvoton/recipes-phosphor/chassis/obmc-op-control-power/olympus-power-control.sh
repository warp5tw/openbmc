echo "set power state $1"

powerTimeOut=90
powerPluseTime=0.2
state=$1
pwrpin=$3
pgpin=$2

powerPluse() {
    echo "gpio${pgpin} is pgood pin"
    echo 0 > /sys/class/gpio/gpio${pwrpin}/value
    echo "gpio${pwrpin} output low"
    sleep ${powerPluseTime}

    echo 1 > /sys/class/gpio/gpio${pwrpin}/value
    echo "gpio${pwrpin} output hi"
}

PowerOffTimerStart() {
    i=0
    pgood=1
    until [ "$pgood" == "0" -o "$i" == "${powerTimeOut}" ]
    do
       i=$(($i+1))
       pgood=$(cat /sys/class/gpio/gpio${pgpin}/value)
       sleep 1
    done

    echo $pgood
}

PowerOnTimerStart() {
    i=0
    pgood=0
    until [ "$pgood" == "1" -o "$i" == "${powerTimeOut}" ]
    do
       i=$(($i+1))
       pgood=$(cat /sys/class/gpio/gpio${pgpin}/value)
       sleep 1
    done

    echo $pgood
}


if [ ${state} = "1" ]; then
  try=0
  PGOOD=0
  echo "Power On Start"
  until [ "$PGOOD" == "1" -o "$try" == "5" ]
  do
    try=$(($try+1))
    powerPluse
    PGOOD=$(PowerOnTimerStart)
  done
  echo "Power On done; pgood=${PGOOD}; Retry=${try}"
else
  try=0
  PGOOD=1
  echo "Power Off Start"
  until [ "$PGOOD" == "0" -o "$try" == "5" ]
  do
    try=$(($try+1))
    powerPluse
    PGOOD=$(PowerOffTimerStart)
  done
  echo "Power Off done; pgood=${PGOOD}; Retry=${try}"
fi

if [ $1 = "1" ]; then
    if [ -d "/sys/bus/platform/drivers/peci_npcm/f0100000.peci-bus" ]; then
        echo f0100000.peci-bus > /sys/bus/platform/drivers/peci_npcm/unbind; echo f0100000.peci-bus > /sys/bus/platform/drivers/peci_npcm/bind
    else
        echo f0100000.peci-bus > /sys/bus/platform/drivers/peci_npcm/bind
    fi
else
    if [ -d "/sys/bus/platform/drivers/peci_npcm/f0100000.peci-bus" ]; then
        echo f0100000.peci-bus > /sys/bus/platform/drivers/peci_npcm/unbind
    fi
fi
