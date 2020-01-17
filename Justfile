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

  docker-compose \
    -f docker-compose.yml \
    $EXTRA \
    build

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

up mode="development":
  #!/usr/bin/env bash

  export CURRENT_UID=$(id -u):$(id -g)

  export EXTRA
  if [[ -f "docker-compose.local.yml" ]]; then
    EXTRA="-f docker-compose.local.yml"
    echo -e "\u001b[30;1mIncluding docker-compose.local.yml\u001b[0m"
  fi

  echo -e "\u001b[30;1mMode: \u001b[33m{{ mode }}\u001b[0m\n"

  docker-compose \
    -f docker-compose.yml \
    -f docker-compose.{{ mode }}.yml \
    $EXTRA \
    up

down mode="development":
  #!/usr/bin/env bash

  export CURRENT_UID=$(id -u):$(id -g)

  export EXTRA
  if [[ -f "docker-compose.local.yml" ]]; then
    EXTRA="-f docker-compose.local.yml"
    echo -e "\u001b[30;1mIncluding docker-compose.local.yml\u001b[0m"
  fi

  docker-compose \
    -f docker-compose.yml \
    -f docker-compose.{{ mode }}.yml \
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

  export EXTRA
  if [[ -f "docker-compose.local.yml" ]]; then
    EXTRA="-f docker-compose.local.yml"
    echo -e "\u001b[30;1mIncluding docker-compose.local.yml\u001b[0m"
  fi

  if [[ ! -f "{{ file }}" ]]; then
    echo "Given file: '{{ file }}' doesn't exist!"
    exit 1
  fi

  container_id=$(docker-compose ps -q postgres_shariasource | head -n1)
  docker cp {{ file }} $container_id:/load.sql

  docker-compose \
    -f docker-compose.yml \
    $EXTRA \
    exec \
    postgres_{{ service }} \
    /bin/bash -c 'PGPASSWORD="$POSTGRES_PASSWORD" cat /load.sql | psql -U $POSTGRES_USER -h 0.0.0.0 $POSTGRES_DB'


psql service="shariasource":
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
    /bin/bash -c 'PGPASSWORD="$POSTGRES_PASSWORD" psql -U $POSTGRES_USER -h 0.0.0.0 $POSTGRES_DB'

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

rails service="shariasource" mode="development" task="-T":
  #!/usr/bin/env bash

  export CURRENT_UID=$(id -u):$(id -g)

  export EXTRA
  if [[ -f "docker-compose.local.yml" ]]; then
    EXTRA="-f docker-compose.local.yml"
    echo -e "\u001b[30;1mIncluding docker-compose.local.yml\u001b[0m"
  fi

  docker-compose \
    -f docker-compose.yml \
    -f docker-compose.{{ mode }}.yml \
    -f docker-compose.local.yml \
    $EXTRA \
    run \
    --rm \
    {{ service }} \
    bundle exec rails {{ task }}

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
