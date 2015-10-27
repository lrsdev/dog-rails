#!/bin/bash
# This script can be used locally and in the CI platform.
# Depends on a docker daemon and docker-compose.
docker-compose up -d db
docker-compose run dograils-test
docker-compose stop
