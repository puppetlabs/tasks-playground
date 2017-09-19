FROM alpine:3.5

MAINTAINER Gareth Rushgrove "gareth@puppet.com"

LABEL org.label-schema.vendor="Puppet" \
      org.label-schema.url="https://github.com/puppetlabs/bolt" \
      org.label-schema.name="Bolt" \
      org.label-schema.license="Apache-2.0" \
      org.label-schema.schema-version="1.0" \
      com.puppet.dockerfile="/Dockerfile"

RUN addgroup -S bolt && adduser -S -g bolt bolt

RUN apk add --update --no-cache \
      build-base \
      libffi-dev \
      ca-certificates \
      ruby \
      ruby-irb \
      ruby-rdoc \
      ruby-dev \
      git && \
      gem install bundler

USER bolt

# Note that this requires https://github.com/moby/moby/pull/34263 which is
# only available since the 17.09 edge release of Moby
COPY --chown=bolt:bolt . /usr/src/bolt
WORKDIR /usr/src/bolt

# Work-around for BOLT-80
RUN echo "gem 'io-console'" > Gemfile.local
RUN bundle install --path .bundle

ENTRYPOINT ["bundle", "exec", "bolt"]
CMD ["--help" ]

COPY Dockerfile /
