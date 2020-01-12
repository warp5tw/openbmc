echo "set power state $1"

if [ $1 = "1" ];
then ori_pgood=0
else ori_pgood=1
fi

while [ $(cat /sys/class/gpio/gpio$2/value) =  $ori_pgood ];
do
  while [ $(cat /sys/class/gpio/gpio$3/value) =  "1" ];
  do
      echo 0 > /sys/class/gpio/gpio$3/value
  done

  echo "gpio$3 output low"
  sleep 1
done

while [ $(cat /sys/class/gpio/gpio$3/value) = "0" ];
do
  echo 1 > /sys/class/gpio/gpio$3/value
done

echo "gpio$3 output hi"
