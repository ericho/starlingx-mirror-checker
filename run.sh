#!/bin/bash

# Clone the stx-tools repository.

if ! git clone https://git.openstack.org/openstack/stx-tools; then
    echo "Cannot clone the repository"
    exit 1
fi

# Create docker image for mirror check

pushd stx-tools

if ! docker build -t stx-mirror -f Dockerfile .; then
    echo "Cannot create docker image"
    exit 1
fi

# Run the image

docker run -v $(pwd):/localdisk stx-mirror ./mirror-check.sh
