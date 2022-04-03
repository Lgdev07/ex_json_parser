FROM hexpm/elixir:1.13.0-erlang-23.3.4.10-alpine-3.14.3 AS base

RUN mkdir /ex_json_parser
WORKDIR /ex_json_parser

# Cache elixir deps
ADD mix.exs ./
RUN mix do local.hex --force, local.rebar --force, deps.get, deps.compile, tailwind.install

RUN apk add npm inotify-tools