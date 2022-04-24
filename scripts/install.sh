#!/usr/bin/env bash

# This script will install nr-dashboard-hcl-gen tool and convert NR dashboard output json to terraform format
#
# Dependencies:     curl, cut, tar, gzip
# Operating system: Linux or darwin

set -o errexit

echo "Starting installation."

# Determine release.
if [ "$(uname)" == "Linux" ]; then
    OS="Linux"
elif [ "$(uname)" == "Darwin" ]; then
    OS="Darwin"
else
    echo "This operating system is not supported. The supported operating systems are Linux and Darwin"
    exit 1
fi

if [ "$(uname -m)" == "x86_64" ]; then
    MACHINE="x86_64"
else
    echo "This machine architecture is not supported. Currently the supported architectures are x86_64"
    exit 1
fi

for x in curl cut tar gzip sudo; do
    which $x > /dev/null || (echo "Unable to continue.  Please install $x before proceeding."; exit 1)
done

read -e -p "Set new relic dashboard output json file full path: " OUTPUT
read -e -p "Set resource label for dashboard: " RESOURCE_LABEL

DESTDIR="${DESTDIR:-/usr/local/bin}"

echo "Installing nr-dashboard-hcl-gen"

# Run the script in a temporary directory.
SCRATCH=$(mktemp -d || mktemp -d -t 'tmp')

function error {
  echo "An error occurred installing the tool."
  echo "The contents of the directory $SCRATCH have been left in place to help to debug the issue."
}

trap error ERR

BINARY_PATH="../packages/nr-dashboard-hcl-gen_${OS}_${MACHINE}.tar.gz"

# Download & unpack the release tarball.
tar -xz "$BINARY_PATH" -d "$SCRATCH"

echo "Installing to $DESTDIR"
mv "$SCRATCH/nr-dashboard-hcl-gen" "$DESTDIR"
chmod +x "$DESTDIR/nr-dashboard-hcl-gen"

# Delete the working directory when the install was successful.
rm -rf "$SCRATCH"

cat $OUTPUT | nr-dashboard-hcl-gen -l $RESOURCE_LABEL > ../main.tf