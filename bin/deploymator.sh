#!/bin/bash

export MIX_ENV=prod
export PORT=8888
export NODE_ENV=production

RELEASE_VERSION=$(cat mix.exs | grep version | awk '{print $2}' | awk '{gsub(/"/, ""); print}' | sed 's/.$//')

webpack -p --config ./webpack.config.prod.js
mix compile
mix phoenix.digest
mix release
mix ecto.migrate
cp ~/eliscore/rel/eliscore/releases/"$RELEASE_VERSION"/eliscore.tar.gz /home/eliscore/
cd /home/eliscore && tar xzf /home/eliscore/eliscore.tar.gz

PID=$(ps aux | grep [b]eam | awk '{print $2}')
kill -9 "$PID"
/bin/bash /home/eliscore/bin/eliscore start
