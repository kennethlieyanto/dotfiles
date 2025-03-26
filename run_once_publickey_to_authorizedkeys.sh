#!/bin/bash

KEYS_URL="https://github.com/kennethlieyanto.keys"

# Fetch public keys from GitHub
NEW_KEYS=$(curl -s $KEYS_URL)

# Ensure the file exists
touch ~/.ssh/authorized_keys

# Loop through each key and add if not already present
while IFS= read -r key; do
  if ! grep -qxF "$key" ~/.ssh/authorized_keys; then
    echo "$key" >>~/.ssh/authorized_keys
  fi
done <<<"$NEW_KEYS"

# Ensure correct permissions
chmod 600 ~/.ssh/authorized_keys

echo "Public keys from $GITHUB_USER added to ~/.ssh/authorized_keys."
