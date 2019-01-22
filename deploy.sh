#!/bin/bash

set -e

if grep -q False .deploy.lock; then
	echo "update seems to have failed.  Exiting..."
fi

DATE=`date '+%Y-%m-%d %H:%M:%S'`

git add jsontrips/data

echo False > .deploy.lock

git commit -m "automatic update of jsontrips [$DATE]"
bumpversion patch

git push
