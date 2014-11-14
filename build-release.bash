#!/bin/bash
set -u -e

# TODO Check parameter is not empty
if [ "$1" -eq "" ]; then
	echo "usage:"
	echo "build-release.bash new_version"
	echo ""
	echo "	new_version: new version to create (ex: 2.1)"
	exit 1
fi

new_version=$1

# TODO Check new tag does not already exist

# TODO Check everything if committed
# TODO Update README.txt

# Create tag for corresponding version
#git tag $new_version

# Push new tag
#git push