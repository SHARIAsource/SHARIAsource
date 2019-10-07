# Local Variables:
# mode: makefile
# End:
# vim: set ft=make :

build:
  docker-compose \
    -f docker-compose.yml \
    -f docker-compose.tests.yml \
    build

test-down:
  docker-compose \
    -f docker-compose.yml \
    -f docker-compose.tests.yml \
    down

integration-test:
  docker-compose \
    -f docker-compose.yml \
    -f docker-compose.tests.yml \
    run \
    --use-aliases \
    --entrypoint=/shariasource/bin/app_ctl \
    shariasource \
    --integration-test

migrate-test:
  docker-compose \
    -f docker-compose.yml \
    -f docker-compose.tests.yml \
    run \
    --use-aliases \
    --entrypoint=/shariasource/bin/app_ctl \
    shariasource \
    --migrate-test

init:
  docker-compose \
    -f docker-compose.yml \
    -f docker-compose.tests.yml \
    run \
    --use-aliases \
    --entrypoint=/shariasource/bin/app_ctl \
    shariasource \
    --init

test type="":
  #!/usr/bin/env bash

  export PARAM
  if [[ "{{ type }}" == "" ]]; then
    PARAM="--test"
  else
    PARAM="--{{ type }}-test"
  fi

  docker-compose \
    -f docker-compose.yml \
    -f docker-compose.tests.yml \
    run \
    --use-aliases \
    --entrypoint=/shariasource/bin/app_ctl \
    shariasource \
    $PARAM

shell service="shariasource":
  docker-compose \
    -f docker-compose.yml \
    -f docker-compose.tests.yml \
  	exec \
    {{ service }} \
  	/bin/bash
