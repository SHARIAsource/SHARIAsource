docker_compose("./docker-compose.yml")

docker_build('shariasource', '.',
  live_update=[
    sync('.', '/shariasource'),
    run('yarn', trigger='package.json'),
    run('bundle', trigger='Gemfile'),
    restart_container()
  ])
docker_build('corpusbuilder', 'services/corpusbuilder',
  live_update=[
    sync('services/corpusbuilder', '/corpusbuilder'),
    run('yarn', trigger='package.json'),
    run('bundle', trigger='Gemfile'),
    restart_container()
  ])
