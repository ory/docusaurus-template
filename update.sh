#!/bin/bash

set -euox pipefail

rm -rf .docusaurus package-lock.json build || true
npm i
rm -rf node_modules || true

function update {
    dir="$(mktemp -d -t ci-XXXXXXXXXX)/$1"
    git clone git@github.com:ory/"$1".git "$dir" || true

    (cd "$dir"; \
      git town main-branch master; \
      git checkout master; \
      git reset --hard HEAD; \
      git hack docusaurus-$(date +"%m-%d-%y-%H-%M-%S"))

    cp -Rf ../docusaurus-template/. "$dir/docs"
    mv -f "$dir/docs/README_TEMPLATE.md" "$dir/docs/README.md"

    (cd "$dir"; \
      rm docs/update.sh; \
      git status; \
      (git add -A && \
      git commit -a -s -m "chore: update docusaurus template" && \
      git npr) || true
    )
}

update oathkeeper
update keto
update hydra
update kratos

if [ "$1" = "--private" ]; then
  update cloud
fi
