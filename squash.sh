#!/bin/bash

function COMMIT_COUNT() {
  BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
  COMMITS=$(git cherry -v develop $branch)
  echo "${COMMITS}" | grep -c '^'
}

function SQUASH() {
  echo "Input title"
  read TITLE
  echo "Input description"
  read DESCRIPTION
  git reset --soft HEAD~$(COMMIT_COUNT)
  git commit -m $TITLE -m $DESCRIPTION
  git push -f
}

SQUASH
