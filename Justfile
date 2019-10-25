# Local Variables:
# mode: makefile
# End:
# vim: set ft=make :

build extra="":
  #!/usr/bin/env bash

  export EXTRA
  if [[ "{{ extra }}" == "test" ]]; then
    EXTRA="-f docker-compose.tests.yml"
  fi

  docker-compose -f docker-compose.yml $EXTRA build

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

up:
  #!/usr/bin/env bash

  docker-compose \
    -f docker-compose.yml \
    up

test type="":
  #!/usr/bin/env bash

  if [[ "{{type }}" == "down" ]]; then
    docker-compose \
      -f docker-compose.yml \
      -f docker-compose.tests.yml \
      down
    exit 0
  fi

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

repl service="shariasource":
  #!/usr/bin/env bash

  docker-compose \
    -f docker-compose.yml \
    -f docker-compose.tests.yml \
    exec \
    {{ service }} \
    /{{ service }}/bin/app_ctl --repl

shell service="shariasource":
  #!/usr/bin/env bash

  docker-compose \
    -f docker-compose.yml \
    -f docker-compose.tests.yml \
    exec \
    {{ service }} \
    /bin/bash
