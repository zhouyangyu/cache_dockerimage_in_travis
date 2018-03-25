#!/bin/bash

docker build -q -t $TEST_IMAGE .
docker run --rm -it $TEST_IMAGE --version
