#!/bin/sh
set -e

# Check if the configuration file exists
FILE=/opt/dnsdist/dnsdist.conf
if [ ! -f "$FILE" ]; then
    echo "===> FAILED: $FILE does not exist. Ensure your Docker volume is mounted properly."
    exit 1
fi

# Check if the config is valid
echo "Checking dnsdist configuration..."
dnsdist -C /opt/dnsdist/dnsdist.conf --check-config
if [ $? -ne 0 ]; then
  echo "===> FAILED: dnsdist config is not valid."
  exit 1
fi

echo "Starting dnsdist..."
exec dnsdist "$@"
