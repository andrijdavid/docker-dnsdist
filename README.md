# PowerDNS dnsdist
Dockerized version of dnsdist (https://dnsdist.org/). Modern, lightweight, and automatically updated Docker image with the latest dnsdist version.

Pre-built images are available on both:
- Quay.io: `quay.io/andrijdavid/dnsdist`
- Docker Hub: `docker.io/andrijdavid/dnsdist`

## Features
- Built on latest Alpine Linux (3.21) for minimal footprint
- Latest dnsdist version (1.9.10-r0 for Alpine 3.21, or 2.0.1-r0 for Alpine edge)
- Multi-architecture support (amd64, arm64, arm/v7)
- Automated builds every few days
- Security focused (runs as non-root user)

## Prerequisites
```bash
cp dnsdist.conf.tmpl dnsdist.conf
# Edit the configuration according to your needs
```

## Build the Image
```bash
docker build -t andrijdavid/dnsdist:latest .
```
or with specific version build args
```bash
ALPINE_VER="3.21"
DNSDIST_VER="1.9.10-r0"
docker build \
  --build-arg DNSDIST_VERSION=$DNSDIST_VER \
  --build-arg ALPINE_VERSION=$ALPINE_VER \
  -t andrijdavid/dnsdist:$DNSDIST_VER .
```

To build with the latest edge version of Alpine and dnsdist:
```bash
ALPINE_VER="edge"
DNSDIST_VER="2.0.1-r0"
docker build \
  --build-arg DNSDIST_VERSION=$DNSDIST_VER \
  --build-arg ALPINE_VERSION=$ALPINE_VER \
  -t andrijdavid/dnsdist:edge .
```

## Getting Started
```bash
docker run -d -p 53:53 -p 53:53/udp -v $(pwd)/dnsdist.conf:/opt/dnsdist/dnsdist.conf:ro andrijdavid/dnsdist:latest
```
or using docker-compose
```bash
docker-compose up -d
```

## Configuration
The example configuration in `dnsdist.conf.tmpl` allows connections from private IP ranges and forwards to Cloudflare and Google DNS. Modify as needed for your use case.

## Automatic Updates
This image is built automatically every few days to ensure you always have the latest dnsdist version. The GitHub Actions workflow handles multi-platform builds and pushes to both Quay.io and Docker Hub.

## Version update
The `VERSION` file contains the current build versions. The GitHub Actions workflow automatically builds and pushes new images when updates are available in the Alpine repositories.