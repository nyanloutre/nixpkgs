#!/usr/bin/env bash

set -euo pipefail

git config user.name "${GITHUB_ACTOR}"
git config user.email "${GITHUB_ACTOR}@users.noreply.github.com"
git tag backups/${NIXOS_CHANNEL}@$(date +%s)
git push --tags
git remote add upstream https://github.com/NixOS/nixpkgs.git
git fetch upstream
git rebase upstream/${NIXOS_CHANNEL}
git push --force
