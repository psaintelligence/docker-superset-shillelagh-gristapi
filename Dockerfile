
# https://github.com/apache/superset
# https://hub.docker.com/r/apache/superset/tags
ARG apache_superset_tag=6.0.0

# Apache Superset
FROM docker.io/apache/superset:${apache_superset_tag}

# https://github.com/betodealmeida/shillelagh
# https://pypi.org/project/shillelagh/#history
ARG shillelagh_tag=1.4.3

# https://github.com/qleroy/shillelagh-gristapi
# https://pypi.org/project/shillelagh-gristapi/#history
ARG shillelagh_gristapi_tag=0.1.7

# OCI Labels
LABEL org.opencontainers.image.title="Docker Superset Shillelagh GristAPI"
LABEL org.opencontainers.image.authors="Nicholas de Jong <ndejong@psaintelligence.ai>"
LABEL org.opencontainers.image.source="https://github.com/psaintelligence/docker-superset-shillelagh-gristapi"

USER root
RUN \
    apt-get update -y && \
    apt-get upgrade -y && \
    \
    uv pip install --no-cache-dir pip && \
    uv pip install --no-cache-dir 'shillelagh[all]'==${shillelagh_tag} && \
    uv pip install --no-cache-dir 'shillelagh-gristapi'==${shillelagh_gristapi_tag} && \
    \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

USER superset
RUN \
   shillelagh
