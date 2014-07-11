#!/bin/bash

export SETTINGS='config.DevConfig'
export TITLE_API_URL='http://localhost:8006'
export PORT='8005'

if [[ $1 == "dev" ]]; then
    python run_dev.py
else
    foreman start
fi
