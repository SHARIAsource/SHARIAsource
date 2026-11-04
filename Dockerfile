FROM --platform=linux/amd64 ruby:2.7.8-slim-bullseye AS base

ENV RAILS_ENV=production \
    RAILS_LOG_TO_STDOUT=1 \
    RAILS_SERVE_STATIC_FILES=1 \
    BUNDLE_WITHOUT=development:test \
    BUNDLE_FROZEN=1 \
    LANG=C.UTF-8

WORKDIR /app

# bullseye packages moved off deb.debian.org to archive.debian.org
# policy.xml ships with PDF reads disabled; Ghostscript needs them for page extraction
RUN sed -i 's|deb.debian.org/debian|archive.debian.org/debian|' /etc/apt/sources.list \
    && apt-get update && apt-get install -y --no-install-recommends \
      imagemagick ghostscript libpq5 libxml2 libxslt1.1 \
    && rm -rf /var/lib/apt/lists/* \
    && sed -i 's/rights="none" pattern="PDF"/rights="read|write" pattern="PDF"/' /etc/ImageMagick-6/policy.xml


FROM base AS build

RUN apt-get update && apt-get install -y --no-install-recommends \
      build-essential git pkg-config nodejs \
      libpq-dev libmagickwand-dev libxml2-dev libxslt1-dev zlib1g-dev libssl-dev libffi-dev \
    && rm -rf /var/lib/apt/lists/*

COPY Gemfile Gemfile.lock ./
RUN gem install bundler:2.4.15 \
    && bundle config set --local build.nokogiri --use-system-libraries \
    && bundle install \
    && rm -rf /usr/local/bundle/cache /usr/local/bundle/bundler/gems/*/.git

COPY . .
# database.yml and secrets.yml are gitignored; the example files read everything from ENV
RUN cp config/database.example.yml config/database.yml \
    && cp config/secrets.example.yml config/secrets.yml \
    && SECRET_KEY_BASE=dummy bundle exec rake assets:precompile \
    && rm -rf tmp/cache


FROM base

RUN useradd --create-home app

COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /app /app
# public/uploads is an EFS mount in production; it exists here only as the mount point
RUN mkdir -p tmp/pdf-pages log public/uploads \
    && chown -R app:app tmp log public/uploads

USER app

# No JS runtime at runtime: assets are precompiled, so ExecJS only needs to load
ENV EXECJS_RUNTIME=Disabled

EXPOSE 8080
CMD ["bundle", "exec", "unicorn", "-c", "config/unicorn.rb"]
