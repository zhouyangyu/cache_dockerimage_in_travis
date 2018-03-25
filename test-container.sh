#!/bin/bash

TEST_IMAGE="test_image"
docker build -q -t $TEST_IMAGE .
docker run --rm -it $TEST_IMAGE --version
