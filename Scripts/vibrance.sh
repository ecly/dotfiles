#!/bin/bash
if [[ $(nvidia-settings -q "[gpu:0]/DigitalVibrance[DFP-0]" | grep "Attribute.*1023\.") ]]
then
	nvidia-settings -a "[gpu:0]/DigitalVibrance[DFP-0]=0" > /dev/null
	echo "Vibrance Disabled"
else 
	nvidia-settings -a "[gpu:0]/DigitalVibrance[DFP-0]=1023" > /dev/null
	echo "Vibrance Enabled"
fi
