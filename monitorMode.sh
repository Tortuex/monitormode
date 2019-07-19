#!/bin/bash

clear

sleep 1

read -p "On which interface would you like to enable / disable Monitor mode? " INT #gets the interface name

sleep 1

read -p "Would you like to turn it ON or OFF (N / F)? " OPT

sleep 1

if [ $OPT = "ON" ] || [ $OPT = "on" ] || [ $OPT = "n" ] || [ $OPT = "N" ]; then
        echo "You chose to turn monitor mode ON..."
        sleep 1
        echo "Please wait..."
        sleep 1
        ifconfig $INT down
        iwconfig $INT mode monitor
        ifconfig $INT up
        sleep 1

        read -p "Done! Do you want to kill NetworkManager services with airmon-ng (Y / N)? " KILL

        if [ $KILL = "YES" ] || [ $KILL = "yes" ] || [ $KILL = "Y" ] || [ $KILL = "y" ]; then
                airmon-ng check kill $INT
        else
                echo "You chose not to, enjoy!"
                exit 1
        fi

elif [ $OPT = "F" ] || [ $OPT = "f" ] || [ $OPT = "OFF" ] || [ $OPT = "off" ]; then

        echo "You chose to turn monitor mode OFF..."
        sleep 1
        echo "Please wait..."
        sleep 1
        ifconfig $INT down
        iwconfig $INT mode managed
        ifconfig $INT up

        read -p "Done! Would you like to restart NetworkManager services (Y / N)? " NMR

        if [ $NMR = "YES" ] || [ $NMR = "yes" ] || [ $NMR = "Y" ] || [ $NMR = "y" ]; then
                service NetworkManager restart
        else
                echo "You chose not to, enjoy!"
                exit 1
        fi

else
        echo "Invalid input... Exiting..."
        exit 1
fi
