FROM elixir:1.11.3-alpine as build

ENV MIX_ENV=prod

# =================== Setup pre-requisite tools =====================
# Install requrired deps
RUN mix local.hex --force
RUN mix local.rebar --force

# Setup yarn repo
RUN apk add --no-cache nodejs yarn

# =================== Setup rarely changed deps =====================
# Prepare elixir deps
RUN mkdir /app
WORKDIR /app
COPY mix.exs mix.exs
COPY mix.lock mix.lock
RUN mix deps.get --only prod, compile

# Prepare assets deps
COPY assets/yarn.lock assets/yarn.lock
COPY assets/package.json assets/package.json
RUN yarn --cwd assets install

# =================== Frequently changed part =====================
# Prepare source codes
COPY . /app
# Prepare assets
RUN yarn --cwd assets deploy
RUN mix phx.digest
# Create release
RUN mix distillery.release

# =================== Setup deployment image =====================
# Now copy it into our base image.
FROM alpine:3.12.0
RUN apk add --no-cache bash
RUN mkdir -p /app/_build/prod
WORKDIR /app
COPY --from=build /app/_build/prod /app/_build/prod

ENTRYPOINT ["/app/_build/prod/rel/chavez/bin/chavez", "foreground"]