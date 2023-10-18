ARG IMAGE_TAG=v0.12.1-full
FROM kestra/kestra:$IMAGE_TAG
# https://kestra.io/docs/administrator-guide/deployment/docker#create-a-new-image-with-more-binaries

USER root

RUN mkdir -p /app/plugins && \
  apt-get update -y && \
  apt-get install -y --no-install-recommends golang && \
  apt-get install -y pip && \
  pip install pandas==2.0.3 requests==2.31.0 && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /var/tmp/*

# https://kestra.io/docs/administrator-guide/deployment/docker#create-a-new-image-with-more-plugins

RUN /app/kestra plugins install \
  io.kestra.plugin:plugin-notifications:LATEST \
  io.kestra.storage:storage-gcs:LATEST \
  io.kestra.plugin:plugin-gcp:LATEST
