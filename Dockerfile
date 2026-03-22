# trixie-20260316-slim
FROM docker.io/library/debian@sha256:26f98ccd92fd0a44d6928ce8ff8f4921b4d2f535bfa07555ee5d18f61429cf0c

RUN apt-get update && apt-get install -y --no-install-recommends \
  git \
  && rm -rf /var/lib/apt/lists/*

RUN useradd --system ascii
USER ascii

COPY entrypoint.sh /entrypoint.sh
CMD ["/entrypoint.sh"]
