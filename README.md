# ESP8266 development

The ESP8266 is a low-cost microcontroller with inbuilt 802.11 WiFi. This container comes with development tools to help you communicate with your ESP8266 NodeMCU development board.

## Included tools

ESPlorer - Java Graphical IDE

# Running the container

The container needs to be run in privileged mode, to access the host TTY device. As the ESPlorer tool is graphical, a VNC server is started and listens on container port 5901. This must be presented as a host port.

	docker run -p 5901 --privileged -t -i nickandrew/esp8266 /bin/bash

Inside the container, start the VNC server like this:

	/root/bin/start-container.sh```

The start-container.sh script may ask you to set a password for the VNC server.

# Accessing ESPlorer from the host

Start the container as above, then do ```docker ps``` to find the host port corresponding to container port 5901.

	docker ps
	CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS                     NAMES
0b52e1de648f        esp8266             "/bin/bash"         25 minutes ago      Up 25 minutes       0.0.0.0:32775->5901/tcp   lonely_archimedes
 

From a regular user, do ```vncviewer 0.0.0.0:32775``` (or corresponding port number). Vncviewer will ask for a password, and use the same password you set above.

The vncviewer window should display an Xterm. Inside the xterm, do ```java -jar /opt/ESPlorer/ESPlorer.jar``` and ESPlorer will run and maximise itself within the vncviewer window.

# Connecting your ESP8266 NodeMCU dev board

I'm just learning this myself, so your experience may differ from mine. This is how I got ESPlorer talking to my ESP8266 NodeMCU dev board.

The ESP8266 is connected to the host USB, in this case /dev/ttyUSB2. This requires the cp210x module (autoloaded by my Ubuntu 14.04). Note that I have other devices /dev/ttyUSB0 and ttyUSB1 which are different device types and I do not want ESPlorer to interfere with those devices.

Docker privileged mode will expose all /dev/ttyUSB* devices to the docker container.

# Starting ESPlorer

On the right hand side, I set the device name /dev/ttyUSB2 before doing anything else. I set the following:

	Baud rate 115200

Clicking the big Open button opened the device and found the AT firmware. It wasn't necessary to set DTR or RTS to talk to the device.

```
PORT OPEN 115200

Communication with MCU...
Got answer! AutoDetect firmware...

AT-based firmware detected.
AT+GMR
AT version:0.25.0.0(Jun  5 2015 16:27:16)
SDK version:1.1.1
Ai-Thinker Technology Co. Ltd.
Jun 23 2015 23:23:50

OK
```

At this point the "AT v0.20" tab showed, and I could click on any of the command buttons to communicate with the device. For example, clicking on "CWMODE? - Get current m..."

```
AT+CWMODE?
+CWMODE:2

OK
```

Mode 2 is softAP and my phone shows an open AP named "AI-THINKER_F1F8F6". f1:f8:f6 are the last 3 octets of the WiFI MAC address.

At this point I have no idea why my device has the AT firmware; I thought it was supposed to ship with the NodeMCU firmware loaded. I was expecting to start writing Lua code already :-)
