#!/bin/sh
bundle exec sidekiq -d -L log/sidekiq.log -C config/sidekiq.yml -e production

# solr
# rake sunspot:solr:start
sunspot-solr start --bind-address=127.0.0.1 --solr-home /space/webroots/shariasource/webroot/solr --log-file /space/webroots/shariasource/webroot/log/solr.log
