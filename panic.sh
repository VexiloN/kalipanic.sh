# Network interface names to be checked
interface1="eth0"
interface2="wlan0"

# Unlimited cycles
while true
do
    # Checking the OpenVPN connection
    if [[ $(nmcli con show --active | grep tun) ]]; then
        echo "The OpenVPN connection is active. Network traffic continues."
        sudo ifconfig $interface1 up
        sudo ifconfig $interface2 up
    else
        echo "The OpenVPN connection is not active. Network traffic is being stopped."
        sudo ifconfig $interface1 down
        sudo ifconfig $interface2 down
    fi

    # OpenVPN connection check time
    sleep 1
done
