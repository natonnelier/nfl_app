#!/bin/bash


echo "--- NFL Stats"

DB_NAME="nfl_rushing_dev"

echo "--- Set up server"

cd nfl_rushing

mix deps.get

if psql ${DB_NAME} -c '\q' 2>&1; then
    echo "Databse already exists"
else
    echo "SetUp DB..."
    mix ecto.setup
fi

mix phx.server &

echo "--- Set up client"

cd ..; cd nfl_client

if ! vue --version &> /dev/null
then
    echo "Installing VueJs"
    npm install -g @vue/cli
fi

echo "Starting Client"

npm run serve
