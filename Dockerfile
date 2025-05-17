FROM hexpm/elixir:1.14.5-erlang-25.3.2.21-debian-buster-20240612-slim AS base

RUN mkdir /ex_json_parser
WORKDIR /ex_json_parser

# Cache elixir deps
ADD mix.exs ./
RUN mix do local.hex --force, local.rebar --force, deps.get, deps.compile, tailwind.install

# Install all required packages in a single layer
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    npm \
    inotify-tools \
    curl \
    bash \
    git && \
    rm -rf /var/lib/apt/lists/*

# -----------------
# BUILD
# -----------------
FROM base AS build

ARG MIX_ENV=prod
ENV MIX_ENV=$MIX_ENV
COPY . ./

# install application
RUN mix do deps.get, compile

# -----------------
# RELEASE
# -----------------
FROM build AS release

# digests and compresses static files
RUN mix assets.deploy

# generate release executable
RUN mix release

# -----------------
# PRODUCTION
# -----------------
FROM alpine:3.18.3

WORKDIR /ex_json_parser

ARG MIX_ENV=prod

# install dependencies
RUN apk add --no-cache \
    ncurses-libs \
    curl

COPY --from=release /ex_json_parser/_build/$MIX_ENV/rel/ex_json_parser ./

# start application
CMD ["bin/ex_json_parser", "start"]