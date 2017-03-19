#!/bin/bash
set -e

export MIX_ENV=prod
export PORT=8888
export NODE_ENV=production

APP_ROOT=/home/eliscore
GIT_DIR=/home/git/projects/eliscore
RELEASE_VERSION=$(cat mix.exs | grep version | awk '{print $2}' | awk '{gsub(/"/, ""); print}' | sed 's/.$//')

cd $GIT_DIR && yes | mix local.hex
cd $GIT_DIR && yes | mix local.rebar --force
cd $GIT_DIR && mix deps.get
cd $GIT_DIR && npm install

cd $GIT_DIR && webpack -p --config ./webpack.config.prod.js
cd $GIT_DIR && mix compile
cd $GIT_DIR && mix phoenix.digest
cd $GIT_DIR && mix release
cd $GIT_DIR && mix ecto.migrate
cp $GIT_DIR/rel/eliscore/releases/"$RELEASE_VERSION"/eliscore.tar.gz $APP_ROOT
cd $APP_ROOT && tar xzf /home/eliscore/eliscore.tar.gz

PID=$(ps aux | grep [b]eam | awk '{print $2}')
sudo kill -9 "$PID"
/bin/bash $APP_ROOT/bin/eliscore start
