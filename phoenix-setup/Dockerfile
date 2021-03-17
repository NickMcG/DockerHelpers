ARG EXVERS="1.11"
ARG PHXVERS="1.5.4"

FROM elixir:${EXVERS}

RUN mix local.hex --force && mix local.rebar --force && mix archive.install --force hex phx_new ${PHX_VERS}

WORKDIR /var/output

ENV PHXNAME=set_env
ENV ADD_ARGS=

ENTRYPOINT ["/bin/sh", "-c", "mix phx.new $PHXNAME --no-install $ADD_ARGS"]
