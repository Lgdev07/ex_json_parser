FROM hexpm/elixir:1.13.0-erlang-23.3.4.10-alpine-3.14.3 AS base

RUN mkdir /ex_json_parser
WORKDIR /ex_json_parser

# Cache elixir deps
ADD mix.exs ./
RUN mix do local.hex --force, local.rebar --force, deps.get, deps.compile, tailwind.install

RUN apk add npm inotify-tools

# -----------------
# BUILD
# -----------------
FROM base AS build

RUN apk add curl bash git

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
FROM alpine:3.13.3

WORKDIR /ex_json_parser

ARG MIX_ENV=prod

# install dependencies
RUN apk add ncurses-libs curl

COPY --from=release /ex_json_parser/_build/$MIX_ENV/rel/ex_json_parser ./

# start application
CMD ["bin/ex_json_parser", "start"]