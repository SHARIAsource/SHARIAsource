# SHARIAsource

## Setup steps

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

2019 President and Fellows of Harvard College.
