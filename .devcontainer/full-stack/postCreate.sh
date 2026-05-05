#!/bin/bash
set -e

echo "==> Setting vm.max_map_count for Elasticsearch..."
sudo sysctl -w vm.max_map_count=262144

echo "==> Installing backend gems..."
cd /workspaces/backend && bundle install

echo "==> Waiting for PostgreSQL..."
until bin/rails db:version &>/dev/null; do
  echo "   waiting for postgres..."
  sleep 2
done

echo "==> Setting up database..."
bin/rails db:create db:schema:load db:seed

echo ""
echo "Setup complete. Run 'bin/rails db:pull' to load test data."
