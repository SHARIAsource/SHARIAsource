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

integration-test:
	docker-compose \
    -f docker-compose.yml \
    -f docker-compose.tests.yml \
    run \
    --use-aliases \
    --entrypoint=/shariasource/bin/app_ctl \
    shariasource \
    --integration-test

test:
	docker-compose \
    -f docker-compose.yml \
    -f docker-compose.tests.yml \
    run \
    --use-aliases \
    --entrypoint=/shariasource/bin/app_ctl \
    shariasource \
    --test

shell-corpusbuilder:
	docker-compose \
    -f docker-compose.yml \
    -f docker-compose.tests.yml \
		exec \
	  corpusbuilder \
		/bin/bash

shell-shariasource:
	docker-compose \
    -f docker-compose.yml \
    -f docker-compose.tests.yml \
		exec \
	  shariasource \
		/bin/bash
