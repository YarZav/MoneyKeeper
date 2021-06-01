#!/bin/bash

function COMMIT_COUNT() {
  BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
  COMMITS=$(git cherry -v master $branch)

  for COMMIT in ${COMMITS[@]}
  do
    echo Commit: $COMMIT.
  done

  echo "${COMMITS}" | grep -c '^'
}

function SQUASH() {
  read -p 'Input title: ' TITLE
  read -p 'Input description: ' DESCRIPTION
  git reset --soft HEAD~$(COMMIT_COUNT)
  git commit -m "$TITLE" -m "$DESCRIPTION"
  git push -f
}

SQUASH
