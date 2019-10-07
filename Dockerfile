FROM registry.access.redhat.com/ubi8/ubi-minimal

RUN rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm

RUN microdnf install \
      postgresql-devel \
      nodejs \
      npm \
      ruby \
      gcc \
      gcc-c++ \
      ruby-devel \
      zlib-devel \
      redhat-rpm-config \
      tar \
      patch \
      make \
      git \
      wget \
      GraphicsMagick \
      iproute

RUN npm install yarn -g

WORKDIR /shariasource

COPY Gemfile Gemfile.lock ./

COPY . .

RUN gem install bundler -v 1.17.2

CMD ["./bin/rails server --port 8000"]
