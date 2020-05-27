#!/bin/bash

set -euox pipefail

rm -rf .docusaurus package-lock.json build || true
npm i
rm -rf node_modules || true

# get github api client
wget https://github.com/cli/cli/releases/download/v0.9.0/gh_0.9.0_linux_amd64.tar.gz
tar -xf gh_0.9.0_linux_amd64.tar.gz
mv gh_0.9.0_linux_amd64/bin/gh gh

# get git-town
wget -O git-town https://github.com/git-town/git-town/releases/download/v7.3.0/git-town-linux-amd64
chmod +x ./git-town

function update {
    dir="$(mktemp -d -t ci-XXXXXXXXXX)/$1"
    branch="docusaurus-$(date +\"%m-%d-%y-%H-%M-%S\")"
    git clone git@github.com:ory/"$1".git "$dir" || true

    (cd "$dir"; \
      ./git-town main-branch master; \
      git checkout master; \
      git reset --hard HEAD; \
      ./git-town hack $branch

    cp -Rf ../docusaurus-template/. "$dir/docs"
    mv -f "$dir/docs/README_TEMPLATE.md" "$dir/docs/README.md"

    (cd "$dir"; \
      rm docs/update.sh; \
      git status; \
      (git add -A && \
      git commit -a -s -m "chore: update docusaurus template" && \
      git push --set-upstream origin $branch && \
      ./gh pr create --title "chore: update docusaurus template" --body "Updated docusaurus template to current https://github.com/ory/docusaurus-template.") || true
    )
}

update oathkeeper
update keto
update hydra
update kratos
update cloud
