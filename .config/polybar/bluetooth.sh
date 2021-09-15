#!/bin/bash
BT=($(bluetoothctl paired-devices|head -n 1))

echo ${BT[@]:1}
