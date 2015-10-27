#!/bin/bash
# The purpose of this script is to execute tests on your local development machine.
# You will need a docker and docker-compose installed.

TEST_FILENAME="docker-compose.test.yml"
PROJECT_NAME="dogbeaches"

# Sleep briefly after creating the database container to allow it to finish initialising.
# Occasionally the dogbeaches image would attempt to connect to the db before it was ready.
# Not a problem on tutum autotest because the dogbeaches image has to be built each time.
docker-compose -f ${TEST_FILENAME} -p $PROJECT_NAME up -d db
sleep 5s

docker-compose -f ${TEST_FILENAME} -p $PROJECT_NAME up -d sut
docker logs -f ${PROJECT_NAME}_sut_1
RET=$(docker wait ${PROJECT_NAME}_sut_1)
docker-compose -f ${TEST_FILENAME} -p $PROJECT_NAME kill
docker-compose -f ${TEST_FILENAME} -p $PROJECT_NAME rm --force -v
if [ "$RET" != "0" ]; then
  echo "   Tests in $TEST_FILENAME FAILED: $RET"
  exit 1
else
  echo "   Tests in $TEST_FILENAME PASSED"
fi
