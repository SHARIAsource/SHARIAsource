test-down:
	docker-compose \
    -f docker-compose.yml \
    -f docker-compose.tests.yml \
	  down

test-debug:
	docker-compose \
    -f docker-compose.yml \
    -f docker-compose.tests.yml \
    run \
    --use-aliases \
    shariasource \
    /bin/bash

test:
	docker-compose \
    -f docker-compose.yml \
    -f docker-compose.tests.yml \
    run \
    --use-aliases \
    --entrypoint=/shariasource/bin/app_ctl \
    shariasource \
    --test
