FROM elixir:1.10.3-alpine as build

ENV MIX_ENV=prod

# Install requrired deps
RUN mix local.hex --force
RUN mix local.rebar --force

# Setup yarn repo
RUN apk add --no-cache nodejs yarn

# Prepare source codes
RUN mkdir /app
WORKDIR /app
COPY . /app
RUN mix deps.get --only prod, compile
# Prepare assets
RUN yarn --cwd assets install
RUN yarn --cwd assets deploy
RUN mix phx.digest
# Create release
RUN mix distillery.release

# Now copy it into our base image.
FROM alpine:3.11.6
RUN apk add --no-cache bash
RUN mkdir -p /app/_build/prod
WORKDIR /app
COPY --from=build /app/_build/prod /app/_build/prod

ENTRYPOINT ["/app/_build/prod/rel/chavez/bin/chavez", "foreground"]