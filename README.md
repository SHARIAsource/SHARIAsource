# SHARIAsource

## Requirements

This project provides an easy setup as a set of containers. The work has been done using `Docker` and `Docker Compose` although one might try `Podman` along with `Podman Compose` too (likely with some minor changes to the YAML files).

There's a helper set of scripts for managing the containers using the `make` successor: [just](https://github.com/casey/just)

Hence, the minimal working setup requires the following:

- [Docker](https://www.docker.com)
- [Docker Compose](https://docs.docker.com/compose/install/)
- [Just](https://github.com/casey/just)

## Running the project locally

The helper `Justfile` includes the helper tasks / scripts to manage the containerized services. To list all the available tasks run the following:

```bash
$ just --list
```

To start up all the services run:

```bash
$ just up
```

That task supports an additional argument for setting the `RAILS_ENV` which defaults to `development`.

To stop all those services there's:

```bash
$ just down
```

## Local overrides

The "just tasks" will check for the availability of the `docker-compose.local.yml` file and if it exists, it will include it when operating with docker compose. You might use it to e.g. set the environment variables to fit your particular use case.

## Running the testing suite

The suite depends on a few customizations so that the whole set of services need to be brought up a bit differently. Because of this, if you want to run the suite, please make sure first to tear the running services down if you have any with `just down`. Then, running the suite is down with:

```bash
$ just test
```

The testing suite uses [Selenium](https://selenium.dev) and if you're in a need to troubleshoot anything within the browser itself, there's a VNC server being deployed too. You can connect to it on port `5900`.

## License

SHARIAsource is licensed under the GNU GPL 3.0 License.

## Copyright

2019 President and Fellows of Harvard College.
