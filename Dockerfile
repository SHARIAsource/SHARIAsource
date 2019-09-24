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
      GraphicsMagick

RUN npm install yarn -g

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./

COPY . .

ENV GEM_HOME=/usr/share/gems
ENV PATH "$PATH:/usr/share/gems/bin"

RUN echo "gem: --install-dir=/usr/share/gems --bindir /usr/share/gems/bin" > /root/.gemrc

RUN /usr/src/app/bin/app_ctl --init


CMD ["./bin/rails server --port 8000"]

