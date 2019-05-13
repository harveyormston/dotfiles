#!/bin/bash

HEART='♥ '
POWER=' ϟ'

if [ "$(uname)" == "Darwin" ]; then
  battery_info=`ioreg -rc AppleSmartBattery`
  current_charge=$(echo $battery_info | grep -o '"CurrentCapacity" = [0-9]\+' | awk '{print $3}')
  total_charge=$(echo $battery_info | grep -o '"MaxCapacity" = [0-9]\+' | awk '{print $3}')
  state=$(echo $battery_info | grep -o '"ExternalConnected" = [Yes|No]' | awk '{print $3}')
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  current_charge=$(cat /sys/class/power_supply/battery/capacity)
  total_charge="100"
  state=$(cat /sys/class/power_supply/battery/status)
  if [[ "$state" == 'Not charging' ]]; then
      state="N"
  else
      state="Y"
  fi
elif [ "$(expr substr $(uname -s) 1 6)" == "CYGWIN" ]; then
  current_charge=$(WMIC PATH Win32_Battery Get EstimatedChargeRemaining | sed -e '2!d' -e 's/[ \r\n\t]*//g' | awk '{print $1;}')
  total_charge="100"
  state=$(WMIC Path Win32_Battery Get BatteryStatus | sed -e '2!d' -e 's/[ \r\n\t ]*//g' | awk '{print $1;}')
  if [[ "$state" == '2' ]]; then
      state="Y"
  else
      state="N"
  fi
fi

charged_slots=$(echo "(($current_charge/$total_charge)*10)+1" | bc -l | cut -d '.' -f 1)
if [[ $charged_slots -gt 10 ]]; then
  charged_slots=10
fi

echo -n '#[fg=colour9]'
for i in `seq 1 $charged_slots`; do echo -n "$HEART"; done

if [[ $charged_slots -lt 10 ]]; then
  echo -n '#[fg=colour59]'
  for i in `seq 1 $(echo "10-$charged_slots" | bc)`; do echo -n "$HEART"; done
fi

if [ $state == "Y" ]; then
    echo -n '#[fg=colour10]'
    echo -n "$POWER"
fi
