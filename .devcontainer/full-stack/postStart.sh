#!/bin/bash

echo "==> Waiting for Elasticsearch..."
until curl -sf "http://elasticsearch:9200/_cluster/health?wait_for_status=yellow&timeout=5s" &>/dev/null; do
  sleep 2
done
echo "   Elasticsearch ready."

echo "==> Starting Rails server..."
cd /workspaces/backend && bin/rails s -b 0.0.0.0 > /tmp/rails.log 2>&1 &

echo "==> Starting Sidekiq..."
cd /workspaces/backend && bundle exec sidekiq > /tmp/sidekiq.log 2>&1 &

echo "==> Starting frontend dev server..."
cd /workspaces/frontend && REACT_APP_BACKEND_URL="https://${CODESPACE_NAME}-3000.app.github.dev" npm run start > /tmp/frontend.log 2>&1 &

echo "==> Starting factuurinzien dev server..."
cd /workspaces/factuurinzien && REACT_APP_BACKEND_URL="https://${CODESPACE_NAME}-3000.app.github.dev" npm run start > /tmp/factuurinzien.log 2>&1 &

echo ""
echo "Stack starting up. Access URLs:"
echo "  Backend:  https://${CODESPACE_NAME}-3000.app.github.dev"
echo "  Frontend: https://${CODESPACE_NAME}-5000.app.github.dev"
echo "  Portal:   https://${CODESPACE_NAME}-5001.app.github.dev"
echo ""
echo "Logs: /tmp/rails.log  /tmp/sidekiq.log  /tmp/frontend.log  /tmp/factuurinzien.log"
