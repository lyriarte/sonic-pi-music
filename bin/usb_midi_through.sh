#!/bin/bash


info()
{
	logger "$@"
}

while [ "$USBKB" == "" ] || [ "$THROU" == "" ]
do
	sleep 2
	[ "$USBKB" ] || USBKB=$(aconnect -i | grep client | grep 'USB MIDI' | sed -e "s/client \([0-9]*\):.*/\1/")
	[ "$THROU" ] || THROU=$(aconnect -o | grep client | grep 'Midi Through' | sed -e "s/client \([0-9]*\):.*/\1/")
done

info "USB Keyboard $USBKB:0, MIDI Through $THROU:0"
aconnect $USBKB:0 $THROU:0
