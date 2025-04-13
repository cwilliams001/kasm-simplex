#!/bin/bash

# Get the latest release info from GitHub API
echo "Getting latest SimpleX Chat release information..."
LATEST_RELEASE=$(curl -s https://api.github.com/repos/simplex-chat/simplex-chat/releases/latest)
VERSION=$(echo $LATEST_RELEASE | grep -o '"tag_name": "v[^"]*"' | sed 's/"tag_name": "v//' | sed 's/"//')

echo "Latest SimpleX Chat version: $VERSION"

# Find the Ubuntu 22.04 desktop package URL specifically
DEB_URL=$(echo $LATEST_RELEASE | grep -o '"browser_download_url": "https://github.com/simplex-chat/simplex-chat/releases/download/v[^"]*simplex-desktop-ubuntu-22_04-x86_64.deb"' | sed 's/"browser_download_url": "//' | sed 's/"//')

if [ -z "$DEB_URL" ]; then
    echo "ERROR: Could not find Ubuntu 22.04 .deb package URL"
    exit 1
fi

echo "Downloading SimpleX Chat Ubuntu 22.04 .deb package from: $DEB_URL"
SIMPLEX_FILE="simplex-desktop-ubuntu-22_04-x86_64.deb"
curl -L -o "$SIMPLEX_FILE" "$DEB_URL"

# Verify download
if [ -f "$SIMPLEX_FILE" ]; then
    echo "Download completed: $SIMPLEX_FILE"
    # Output the version for GitHub Actions
    echo "version=$VERSION" >> $GITHUB_OUTPUT
    echo "file=$SIMPLEX_FILE" >> $GITHUB_OUTPUT
else
    echo "ERROR: Download failed"
    exit 1
fi