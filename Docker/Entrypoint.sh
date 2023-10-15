#!/bin/sh -e

# Add config items which are in the main minecraft folder from config so that 
# they can persist across launches
if [ ! -d "/minecraft/config" ]; then
  mkdir /minecraft/config
fi

if [ ! -f "/minecraft/config/banned-ips.json" ]; then
  echo "[]" >> /minecraft/config/banned-ips.json
fi

if [ ! -f "/minecraft/config/banned-players.json" ]; then
  echo "[]" >> /minecraft/config/banned-players.json
fi

if [ ! -f "/minecraft/config/usercache.json" ]; then
  echo "[]" >> /minecraft/config/usercache.json
fi

if [ ! -f "/minecraft/config/whitelist.json" ]; then
  echo "[]" >> /minecraft/config/whitelist.json
fi

ln -s /minecraft/config/banned-ips.json /minecraft/banned-ips.json
ln -s /minecraft/config/banned-players.json /minecraft/banned-players.json
ln -s /minecraft/config/usercache.json /minecraft/usercache.json
ln -s /minecraft/config/whitelist.json /minecraft/whitelist.json
ln -s /minecraft/config/ops.json /minecraft/ops.json

# Configure the properties
# Echo the file as it has embedded environment variables
eval "echo \"$(cat /server.properties)\"" > /minecraft/server.properties

# Start prismarine
cd /prismarine && npm run start &

# Start the server
cd /minecraft && java -Xmx${JAVA_MEMORY} -Xms${JAVA_MEMORY} -Dfml.queryResult=confirm -jar fabric-server-launch.jar nogui &

# Wait for any process to exit
wait -n

# Exit with status of process that exited first
exit $?