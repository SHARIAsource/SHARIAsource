# Local Variables:
# mode: makefile
# End:
# vim: set ft=make :

ps:
  #!/usr/bin/env bash

  docker-compose ps

build extra="":
  #!/usr/bin/env bash

  export EXTRA
  if [[ "{{ extra }}" == "test" ]]; then
    EXTRA="-f docker-compose.tests.yml"
  fi

  docker-compose -f docker-compose.yml $EXTRA build

migrate-test:
  #!/usr/bin/env bash

  export CURRENT_UID=$(id -u):$(id -g)

  docker-compose \
    -f docker-compose.yml \
    -f docker-compose.tests.yml \
    run \
    --use-aliases \
    --entrypoint=/shariasource/bin/app_ctl \
    shariasource \
    --migrate-test

init:
  #!/usr/bin/env bash

  export CURRENT_UID=$(id -u):$(id -g)

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

  export CURRENT_UID=$(id -u):$(id -g)

  export EXTRA
  if [[ -f "docker-compose.local.yml" ]]; then
    EXTRA="-f docker-compose.local.yml"
    echo -e "\u001b[30;1mIncluding docker-compose.local.yml\u001b[0m"
  fi

  docker-compose \
    -f docker-compose.yml \
    $EXTRA \
    up

down:
  #!/usr/bin/env bash

  export CURRENT_UID=$(id -u):$(id -g)

  export EXTRA
  if [[ -f "docker-compose.local.yml" ]]; then
    EXTRA="-f docker-compose.local.yml"
    echo -e "\u001b[30;1mIncluding docker-compose.local.yml\u001b[0m"
  fi

  docker-compose \
    -f docker-compose.yml \
    $EXTRA \
    down

copy-tesseract-models:
  #!/usr/bin/env bash

  export EXTRA
  if [[ -f "docker-compose.local.yml" ]]; then
    EXTRA="-f docker-compose.local.yml"
    echo -e "\u001b[30;1mIncluding docker-compose.local.yml\u001b[0m"
  fi

  docker-compose \
    -f docker-compose.yml \
    $EXTRA \
    run \
    --user=0 \
    --use-aliases \
    --entrypoint=/corpusbuilder/bin/app_ctl \
    corpusbuilder \
    "--copy-tesseract-models"

test type="":
  #!/usr/bin/env bash

  export CURRENT_UID=$(id -u):$(id -g)

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
    --user=0 \
    --use-aliases \
    --entrypoint=/corpusbuilder/bin/app_ctl \
    corpusbuilder \
    "--copy-tesseract-models"

  docker-compose \
    -f docker-compose.yml \
    -f docker-compose.tests.yml \
    run \
    --use-aliases \
    --entrypoint=/shariasource/bin/app_ctl \
    shariasource \
    $PARAM

logs service="shariasource":
  #!/usr/bin/env bash

  export EXTRA
  if [[ -f "docker-compose.local.yml" ]]; then
    EXTRA="-f docker-compose.local.yml"
    echo -e "\u001b[30;1mIncluding docker-compose.local.yml\u001b[0m"
  fi

  docker-compose \
    -f docker-compose.yml \
    $EXTRA \
    logs {{ service }}

repl service="shariasource":
  #!/usr/bin/env bash

  export CURRENT_UID=$(id -u):$(id -g)

  export EXTRA
  if [[ -f "docker-compose.local.yml" ]]; then
    EXTRA="-f docker-compose.local.yml"
    echo -e "\u001b[30;1mIncluding docker-compose.local.yml\u001b[0m"
  fi

  docker-compose \
    -f docker-compose.yml \
    $EXTRA \
    exec \
    {{ service }} \
    /{{ service }}/bin/app_ctl --repl

db-load service="shariasource" file="":
  #!/usr/bin/env bash

  if [[ ! -f "{{ file }}" ]]; then
    echo "Given file: '{{ file }}' doesn't exist!"
    exit 1
  fi

  export EXTRA
  if [[ -f "docker-compose.local.yml" ]]; then
    EXTRA="-f docker-compose.local.yml"
    echo -e "\u001b[30;1mIncluding docker-compose.local.yml\u001b[0m"
  fi

  container_id=$(docker-compose ps -q postgres_shariasource | head -n1)
  docker cp {{ file }} $container_id:/load.sql

  docker-compose \
    -f docker-compose.yml \
    $EXTRA \
    exec \
    postgres_{{ service }} \
    /bin/bash -c 'PGPASSWORD="$POSTGRES_PASSWORD" cat /load.sql | psql -U $POSTGRES_USER -h 0.0.0.0 $POSTGRES_DB'

db-dump service="shariasource":
  #!/usr/bin/env bash

  export EXTRA
  if [[ -f "docker-compose.local.yml" ]]; then
    EXTRA="-f docker-compose.local.yml"
    echo -e "\u001b[30;1mIncluding docker-compose.local.yml\u001b[0m"
  fi

  docker-compose \
    -f docker-compose.yml \
    $EXTRA \
    exec \
    postgres_{{ service }} \
    /bin/bash -c 'PGPASSWORD="$POSTGRES_PASSWORD" pg_dump -U $POSTGRES_USER -h 0.0.0.0 $POSTGRES_DB'

shell service="shariasource":
  #!/usr/bin/env bash

  export CURRENT_UID=$(id -u):$(id -g)

  export EXTRA
  if [[ -f "docker-compose.local.yml" ]]; then
    EXTRA="-f docker-compose.local.yml"
    echo -e "\u001b[30;1mIncluding docker-compose.local.yml\u001b[0m"
  fi

  docker-compose \
    -f docker-compose.yml \
    $EXTRA \
    exec \
    {{ service }} \
    /bin/bash
