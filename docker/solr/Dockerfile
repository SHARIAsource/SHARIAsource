FROM solr:8.11

COPY --chown=solr:solr conf /opt/solr/server/solr/configsets/sunspot/conf

# Creates core "default" under /var/solr/data on first start, then runs Solr in the foreground
CMD ["solr-precreate", "default", "/opt/solr/server/solr/configsets/sunspot"]
