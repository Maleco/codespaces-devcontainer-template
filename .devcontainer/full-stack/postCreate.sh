#!/bin/bash
set -e

# --- Clone repos (gh is authenticated inside the devcontainer) ---
clone_or_fetch() {
  local repo=$1 dest=$2
  if [ -d "$dest/.git" ]; then
    git -C "$dest" fetch --quiet
  else
    gh repo clone "payt/$repo" "$dest"
  fi
}

echo "==> Cloning repos..."
clone_or_fetch debiteurenbeheer          /workspaces/backend
clone_or_fetch debiteurenbeheer-frontend /workspaces/frontend
clone_or_fetch factuurinzien             /workspaces/factuurinzien

# Checkout feature branch if specified
if [ -n "$FEATURE_BRANCH" ] && [ ! -f /workspaces/.branch-checked-out ]; then
  for dest in /workspaces/backend /workspaces/frontend /workspaces/factuurinzien; do
    cd "$dest"
    git checkout -B "$FEATURE_BRANCH" "origin/$FEATURE_BRANCH" 2>/dev/null \
      || git checkout -b "$FEATURE_BRANCH"
  done
  touch /workspaces/.branch-checked-out
fi

# --- Set vm.max_map_count for Elasticsearch ---
echo "==> Setting vm.max_map_count..."
sudo sysctl -w vm.max_map_count=262144

# --- Install dependencies ---
echo "==> Installing backend gems..."
cd /workspaces/backend && bundle install

echo "==> Installing frontend deps..."
cd /workspaces/frontend && npm ci

echo "==> Installing factuurinzien deps..."
cd /workspaces/factuurinzien && npm ci

# --- Database setup ---
echo "==> Waiting for PostgreSQL..."
cd /workspaces/backend
until bin/rails db:version &>/dev/null; do
  echo "   waiting for postgres..."
  sleep 2
done

echo "==> Setting up database..."
bin/rails db:create db:schema:load db:seed

echo ""
echo "Setup complete. Run 'bin/rails db:pull' to load test data."
