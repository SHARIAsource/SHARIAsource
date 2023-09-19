# SHARIAsource

## Local dev

### docker-compose
- `docker compose up --build` builds the `db` and `rails` services and starts them.
- Put a PSQL dump from production in `database_dumps`
- To load the data, `docker compose exec db bash` and then use pg_restore to load the data into the database: `pg_restore -U postgres -d shariasource_local /database_dumps/<EXPORTED_FILE>.dump`

### Solr
- Runs within the `rails` container `Dockerfile.dev` using `sunspot_solr` gem. `entrypoint` starts it.
- If you aren't seeing any search results, you probably need to reindex: `docker compose exec rails bash` and then `bundle exec rake sunspot:reindex`. This usually takes 15-20 minutes.

### Caching (Redis)
- Also currently runs within the `rails` container `Dockerfile.dev` using `redis` gem. Started in the `entrypoint`.

### Updating gems
- Change Ruby and gem versions in `Gemfile`
- `exec` into Rails
- `bundle update`; this will update the `Gemfile.lock` file. May need to adjust versions of gems to get them to work together.
- Commit the `Gemfile` and `Gemfile.lock` files

### other

- Use `rvm` to install the version of Ruby specified in the `Gemfile`.
- `bundle install` (or `bundle _1.16.1_ install`)
- Copy `config/database.example.yml` to `config/database.yml` and fill out the appropriate fields.
- Copy `config/secrets.example.yml` to `config/secrets.yml` and fill in your own secrets. To generate a random long secret, use `rake secret`.
- Add Google Analytics tags in `application.js` and `layouts/shared/_google_analytics`
- `spring binstub --all`.
- The first admin user must be set in the rails console. Create a user, `rails c`, and set the admin flag. Future roles can be set in-app by this admin.


## License

SHARIAsource is licensed under the GNU GPL 3.0 License.

## Copyright

2017-2023 President and Fellows of Harvard College.
