#!/bin/bash

if [[ $(sudo ifconfig wlan0 | grep "UP") != "" ]]; then
    echo "wlan0 the interface is already active."
else
    sudo ifconfig eth0 up
    echo "eth0 the interface has been activated."
fi

echo

echo "Please log in to the OpenVPN server. If you are not logged in within 10 seconds,"
echo "the current connection service will be stopped."

sleep 4

echo

echo "Counting down from 10..."

# Checking the OpenVPN connection
if nmcli con show --active | grep -q tun; then
    echo "OpenVPN connection is active. Countdown cancelled."
else
    # Countdown
    for (( i=10; i>=1; i-- ))
    do
        echo $i
        sleep 1

        # Checking the OpenVPN connection on each iteration
        if nmcli con show --active | grep -q tun; then
            echo "OpenVPN connection is active. Countdown cancelled."
            break
        fi
    done

    echo "Countdown finished."
fi

sleep 0

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
