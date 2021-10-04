#!/bin/bash
if [ -n "$1" ]; then set -x; fi
PA="pactl"

# pactl list sources short
# pactl list sinks short

#SINCS
MIC=alsa_input.usb-Logitech_Logitech_USB_Microphone-00.mono-fallback # ID of the microphone
LINE_IN=alsa_input.pci-0000_00_1f.3.analog-stereo                    # ID of Line-in (most linkely be the keyboard)

#Sorces
SPEAKER=alsa_output.pci-0000_00_1f.3.analog-stereo # ID of the Speakers
COMBINED=combined

S_INPUT=Input          # Name of the Input Sinc
S_MAIN=Output          # Name of the Output Sinc
S_COMMS=Communications # Name of Communications

function create_sink() {                                                               #($1:name)
	${PA} load-module module-null-sink sink_name=$1 sink_properties=device.description=$1 # Create a null module with the requested name
	echo "Created Sink $1"
}

function sink_to_source() { # ($1:sink)
	${PA} load-module module-remap-source source_name=$1_source master=$1.monitor
}

function route_audio() {                                            # ($1:start,$2:end)
	${PA} load-module module-loopback latency_msec=1 source=$1 sink=$2 # Create a loopback module with the requested source and sink
	echo "Routed Audio Module $1 => $2"
}

pulseaudio -k

while ! pgrep -f "pulseaudio" >/dev/null; do # Wait for pulse audio to start
	# Set optional delay
	sleep 0.1
done

# Create Sinks
create_sink ${S_INPUT} # Create a sink called "Input"
create_sink ${S_MAIN}  # Create a sink called "Output"
create_sink ${S_COMMS} # Create a sink called "Communications"

# Setup Defaults
pactl set-default-sink ${S_MAIN}
pactl set-default-source ${S_INPUT}.monitor

# Route Audio
#route_audio ${S_MAIN}.monitor ${SPEAKER}  # Route Audio: Main -> Speaker
#route_audio ${S_COMMS}.monitor ${SPEAKER} # Route Audio: Communications -> Speaker
route_audio ${S_MAIN}.monitor ${COMBINED}  # Route Audio: Main -> Combined
route_audio ${S_COMMS}.monitor ${COMBINED} # Route Audio: Communications -> Combined
route_audio ${S_COMMS}.monitor ${S_INPUT}  # Route Audio: Communications -> Input
route_audio ${MIC} ${S_INPUT}              # Route audio: Microphone ->  Input
#route_audio ${LINE_IN} ${S_INPUT}         # Route audio: Line-in ->  Input
route_audio ${LINE_IN} ${S_COMMS} # Route audio: Line-in ->  Communications
sink_to_source ${S_INPUT}         # Input as a source
