#!/bin/bash

export SETTINGS='config.DevelopmentConfig'
export TITLE_API='http://localhost:8005'
export SEARCH_API='http://localhost:8003'

python run_dev.py
