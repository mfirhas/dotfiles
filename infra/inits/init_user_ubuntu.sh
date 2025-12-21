#!/bin/bash

# Initialize non-root user for ubuntu.
# Run as `root`

set -euo pipefail

USERNAME=mfirhas

USERNAME="${1:-$USERNAME}"

if id "${USERNAME}" &>/dev/null; then
  echo "User ${USERNAME} already exists."
else
  # create new non-root user
  adduser ${USERNAME}
fi

# add your newly created user to sudo group
usermod -aG sudo ${USERNAME}

# add into docker group
usermod -aG docker "${USERNAME}"
