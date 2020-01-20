# Local Variables:
# mode: makefile
# End:
# vim: set ft=make :

# List the running containers
ps:
  #!/usr/bin/env bash

  docker-compose ps

# Build container images
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

# Migrate the testing database schema
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

# Initialize the ShariaSource container for the tests
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

# Start all the services
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

# Tear all the services down
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

# Copy built in Tesseract models to have the running container able to find them
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

# Run the testing suite
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

# Examine the logs
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

# Run the Rails console
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

# Load the database dump
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


# Run the psql
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

# Dump the database to stdout as SQL
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

# Run a Rails task
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

# Run the shell inside the container
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
