FROM elixir

COPY ./ .

RUN mix deps.get

RUN mix run --no-halt