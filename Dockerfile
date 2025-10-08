
# https://github.com/apache/superset
# https://hub.docker.com/r/apache/superset/tags
ARG apache_superset_tag=6.0.0rc2


# Apache Superset
FROM docker.io/apache/superset:${apache_superset_tag}

# https://pypi.org/project/authlib/#history
ARG authlib_tag=1.6

# https://github.com/betodealmeida/shillelagh
# https://pypi.org/project/shillelagh/#history
ARG shillelagh_tag=1.4

# https://github.com/qleroy/shillelagh-gristapi
# https://pypi.org/project/shillelagh-gristapi/#history
ARG shillelagh_gristapi_tag=0.1


USER root
RUN \
    apt-get update -y && \
    apt-get upgrade -y && \
    \
    uv pip install --no-cache-dir pip && \
    uv pip install --no-cache-dir 'authlib'~=${authlib_tag} && \
    uv pip install --no-cache-dir 'shillelagh[all]'~=${shillelagh_tag} && \
    uv pip install --no-cache-dir 'shillelagh-gristapi'~=${shillelagh_gristapi_tag} && \
    \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

USER superset
RUN \
   shillelagh
