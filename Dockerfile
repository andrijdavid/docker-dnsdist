# If no build-arg "ALPINE_VERSION" is provided, use the default version "3.21"
ARG ALPINE_VERSION=3.21
FROM alpine:${ALPINE_VERSION}

LABEL maintainer="Andrij David <andrij.david@your-email.com>"

# If no build-arg "DNSDIST_VERSION" is provided, use the latest available version for Alpine 3.21
ARG DNSDIST_VERSION=1.9.10-r0

# Install dnsdist and ca-certificates for HTTPS connections
RUN apk add --no-cache \
    dnsdist=${DNSDIST_VERSION} \
    ca-certificates

# Create working directory
RUN mkdir -p /opt/dnsdist
WORKDIR /opt/dnsdist

# Add minimal example configuration
COPY dnsdist.conf.tmpl /opt/dnsdist/dnsdist.conf

# Add entrypoint script
COPY entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh

# Set correct permissions for dnsdist
RUN chown -R nobody:nobody /opt/dnsdist && \
    touch /opt/dnsdist/dnsdist.log && \
    chown nobody:nobody /opt/dnsdist/dnsdist.log

# Finalize image configuration
EXPOSE 53 53/udp 5380/tcp
ENTRYPOINT ["/opt/entrypoint.sh"]
CMD ["--local", "0.0.0.0:53", "-u", "nobody", "-g", "nobody", "-C", "/opt/dnsdist/dnsdist.conf", "--disable-syslog", "--supervised"]