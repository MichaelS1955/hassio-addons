#!/bin/bash

# Extract config data
jq -s '.[1].SmartFriends = .[0].options.SmartFriends
    | .[1].Mqtt = .[0].options.Mqtt
    | .[1]' /data/config.json /opt/appsettings.json | sponge /opt/appsettings.json

# armhf needs this linked to run dotnet
[ ! -f "/lib/ld-linux-armhf.so.3" ] && [ -f "/lib/arm-linux-gnueabi/ld-2.28.so" ] && ln -s /lib/arm-linux-gnueabi/ld-2.28.so /lib/ld-linux-armhf.so.3

# Run dotnet service in foreground
dotnet /opt/SmartFriends.Mqtt.dll