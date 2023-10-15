FROM node as prismarine

RUN apt-get update && apt-get install -y \
  gnupg \
  git \
  pkg-config \
  build-essential \
  libpixman-1-dev \
  libcairo2-dev \
  libpango1.0-dev \
  libjpeg62-turbo-dev \
  libgif-dev \
  libxi-dev \
  libgl-dev && \
  ln -s $(which python3) /usr/bin/python

# Insall Prismarine
WORKDIR /prismarine
RUN git clone https://github.com/zardoy/prismarine-web-client.git . && \
  npm i -g pnpm && \
  pnpm install

FROM hashicraft/minecraft:v1.20.1-fabric

# Add nodejs
RUN apt-get update && apt-get install -y \
  gnupg

RUN mkdir -p /etc/apt/keyrings && \
  curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
  echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list && \
  apt-get update && \
  apt-get install nodejs -y

# Copy prismarine
COPY --from=prismarine /prismarine /prismarine

# Copy the mods into the mods folder
RUN mkdir -p /minecraft/mods

RUN wget https://github.com/HashiCraft/fabric-microservices-mod/releases/download/v1.0.1/fabric-microservices-mod-1.0.0.jar \
  -O /minecraft/mods/fabric-microservices-mod-1.0.0.jar

RUN wget https://github.com/HashiCraft/fabric-hashicraft-mod/releases/download/v1.4.0/fabric-hashicraft-mod-1.4.0.jar \
  -O /minecraft/mods/fabric-hashicraft-mod-1.4.0.jar

RUN wget https://github.com/HashiCraft/fabric-mod-minecraft-api/releases/download/v1.20.1/fabric-mod-minecraft-api-1.1.0.jar \
  -O /minecraft/mods/fabric-mod-minecraft-api-1.1.0.jar

RUN wget https://cdn.modrinth.com/data/P7dR8mSH/versions/lcnQpW9C/fabric-api-0.87.0%2B1.20.1.jar \
  -O /minecraft/mods/fabric-api-0.87.0+1.20.1.jar

# Add the world

# Add the config
COPY ./Entrypoint.sh /Entrypoint.sh
ENTRYPOINT ["/bin/bash", "/Entrypoint.sh"]