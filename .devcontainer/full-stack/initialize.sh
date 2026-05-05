#!/bin/bash
set -e

clone_or_fetch() {
  local repo=$1 dest=$2
  if [ -d "$dest/.git" ]; then
    git -C "$dest" fetch --quiet
  else
    gh repo clone "payt/$repo" "$dest"
  fi
}

clone_or_fetch debiteurenbeheer          /workspaces/backend
clone_or_fetch debiteurenbeheer-frontend /workspaces/frontend
clone_or_fetch factuurinzien             /workspaces/factuurinzien

# Checkout feature branch on first launch only
if [ -n "$FEATURE_BRANCH" ] && [ ! -f /workspaces/.branch-checked-out ]; then
  for dest in /workspaces/backend /workspaces/frontend /workspaces/factuurinzien; do
    cd "$dest"
    git checkout -B "$FEATURE_BRANCH" "origin/$FEATURE_BRANCH" 2>/dev/null \
      || git checkout -b "$FEATURE_BRANCH"
  done
  touch /workspaces/.branch-checked-out
fi
