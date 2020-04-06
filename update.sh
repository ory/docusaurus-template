#!/bin/bash

set -euox pipefail

function update {
    dir="$(mktemp -d -t ci-XXXXXXXXXX)/$1"
    git clone git@github.com:ory/"$1".git "$dir" || true

    rm -rf node_modules .docusaurus package-lock.json build || true
    cp -R ../docusaurus-template/. "$dir/docs"

    (cd "$dir"; \
      git town main-branch master; \
      git checkout master; \
      git reset --hard HEAD; \
      git hack docusaurus-$(date +"%m-%d-%y-%H-%M-%S"); \
      (cd docs; npm install); \
      rm docs/update.sh;
      (git add -A && \
      git commit -a -s -m "chore: update docusaurus template" && \
      git npr) || true
    )
}

update oathkeeper
update keto
update hydra
update kratos
