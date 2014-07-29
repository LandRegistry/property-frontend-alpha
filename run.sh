#!/bin/bash

export SETTINGS='config.DevelopmentConfig'
export SEARCH_API='http://localhost:8003'
export SERVICE_FRONTEND_URL='http://localhost:8007'

python run_dev.py
