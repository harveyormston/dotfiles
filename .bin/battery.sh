#!/bin/bash

HEART='♥ '

if [[ `uname` == 'Linux' ]]; then
  current_charge=$(cat /proc/acpi/battery/BAT1/state | grep 'remaining capacity' | awk '{print $3}')
  total_charge=$(cat /proc/acpi/battery/BAT1/info | grep 'last full capacity' | awk '{print $4}')
else
  battery_info=`ioreg -rc AppleSmartBattery`
  current_charge=$(echo $battery_info | grep -o '"CurrentCapacity" = [0-9]\+' | awk '{print $3}')
  total_charge=$(echo $battery_info | grep -o '"MaxCapacity" = [0-9]\+' | awk '{print $3}')
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

echo -n '#[fg=colour9]'
if [[ $charged_slots -eq 10 ]]; then
  echo ' ᕦ(ò_óˇ)ᕤ'
elif [[ $charged_slots -gt 6 ]]; then
  echo ' ᕕ( ᐛ )ᕗ'
elif [[ $charged_slots -gt 4 ]]; then
  echo ' ヽ(´ー` )┌'
elif [[ $charged_slots -gt 2 ]]; then
  echo ' ｡ﾟ(°_o)'
else
  echo ' (҂◡_◡)'
fi

