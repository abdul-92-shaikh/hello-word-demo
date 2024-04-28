#!/bin/bash
git clone https://$USER_NAME:$GITHUB_PAT@github.com/$OWNER/$REPO_NAME.git &>/dev/null
cd $REPO_NAME
git reset --hard $CODEBUILD_RESOLVED_SOURCE_VERSION &>/dev/null
IMAGE_TAG=`git tag --points-at $CODEBUILD_RESOLVED_SOURCE_VERSION | sort -r | grep -m 1 $APP | sed -e "s/^$APP-//"`
[ -z $IMAGE_TAG  ] && exit 1
cd .. && rm -rf $REPO_NAME
echo $IMAGE_TAG
