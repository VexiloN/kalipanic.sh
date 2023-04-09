# panic.sh

### Disables the wlan0 and eth0 connection when the OpenVPN connection is interrupted.

### If you need to reconnect to the network, follow the commands.

sudo ifconfig wlan0 up

sudo ifconfig eth0 up
