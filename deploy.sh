#!/bin/bash

set -e

DATE=`date '+%Y-%m-%d %H:%M:%S'`
COMMIT_MESSAGE="automatic update of jsontrips [$DATE]"
VERSION=patch
ALLOW_DIRTY=""

autodeploy () {
	if grep -q False .deploy.lock; then
		echo "update seems to have failed.  Exiting..."
	fi
	git add jsontrips/data
	echo False > .deploy.lock
}

while [[ $# -gt 0 ]]
do
	i="$1"
	case $i in
		-v|--version)
			VERSION=$2
			shift
			shift
			;;
		-m|--message)
			COMMIT_MESSAGE=$2
			shift
			shift
			;;
		-a|--auto)
			autodeploy
			ALLOW_DIRTY="--allow-dirty"
			shift
			;;
		*)
			shift
			;;
	esac
done


bumpversion $ALLOW_DIRTY $VERSION --message "'$COMMIT_MESSAGE'"
git push --tags origin master
