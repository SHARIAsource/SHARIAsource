docker_compose("./docker-compose.yml")

docker_build('ocr/shariasource', '.',
  live_update=[
    sync('.', '/shariasource'),
    run('yarn', trigger='package.json'),
    run('bundle', trigger='Gemfile'),
    restart_container()
  ])
docker_build('ocr/corpusbuilder', 'services/corpusbuilder',
  live_update=[
    sync('services/corpusbuilder', '/corpusbuilder'),
    run('yarn', trigger='package.json'),
    run('bundle', trigger='Gemfile'),
    restart_container()
  ])
