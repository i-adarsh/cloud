FROM alpine:3.19

# Install necessary packages
RUN apk add --no-cache bash curl python3 tar

# Create a symlink for python if it doesn’t already exist
RUN ln -sf /usr/bin/python3 /usr/bin/python

# Define ARGs
ARG GCLOUD_URL="https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-x86_64.tar.gz"
ARG GCLOUD_HOME="/usr/local/gcloud"

# Install Google Cloud SDK
RUN mkdir -p "$GCLOUD_HOME" \
    && curl -SL "$GCLOUD_URL" | tar -xzC "$GCLOUD_HOME" \
    && "$GCLOUD_HOME/google-cloud-sdk/install.sh" --quiet --path-update=true \
    && ln -s "$GCLOUD_HOME/google-cloud-sdk/bin/gcloud" /usr/bin/gcloud \
    && gcloud components update --quiet

# Verify installation
RUN gcloud --version

# Clean up
RUN rm -rf /var/cache/apk/* /tmp/*
