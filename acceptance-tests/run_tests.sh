#!/bin/bash

set -e

rm -rf diff2*
rm -rf tmpimg*
rm -rf sshot*

bundle install

if [ -z "$1" ]
  then
    cucumber --tags ~@wip --tags ~@removed --tags ~@performance_test
else
    cucumber -r features $1
fi
