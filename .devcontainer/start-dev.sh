#!/bin/bash
# Convenience script to start both frontend and backend

set -e

BACKEND_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../debiteurenbeheer" && pwd)"
FRONTEND_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../debiteurenbeheer-frontend" && pwd)"

echo "🚀 Starting Debiteurenbeheer development..."
echo ""

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if running in codespace
if [ -n "$CODESPACES" ]; then
  echo "📍 Running in GitHub Codespaces"
fi

# Check if services are already running
if docker ps | grep -q "debiteurenbeheer"; then
  echo "${BLUE}✓${NC} Backend services already running"
else
  echo "${BLUE}→${NC} Starting backend services (PostgreSQL, Redis, Elasticsearch)..."
  cd "$BACKEND_DIR"
  docker compose up -d
  sleep 5
  echo "${GREEN}✓${NC} Backend services started"
fi

echo ""
echo "📝 Open new terminals for:"
echo ""
echo "${BLUE}Terminal 1 - Rails Server:${NC}"
echo "  cd $BACKEND_DIR"
echo "  bundle exec rails s -b 0.0.0.0"
echo ""
echo "${BLUE}Terminal 2 - React Dev Server:${NC}"
echo "  cd $FRONTEND_DIR"
echo "  npm start"
echo ""
echo "${BLUE}Terminal 3 - Sidekiq Worker (optional):${NC}"
echo "  cd $BACKEND_DIR"
echo "  docker compose exec backend bundle exec sidekiq"
echo ""
echo "${GREEN}✅ Ready to develop!${NC}"
echo ""
echo "🌐 Access points:"
echo "   Backend:  http://localhost:3000"
echo "   Frontend: http://localhost:5000"
echo ""
echo "🤖 Use Claude Code to help:"
echo "   claude <your-command>"
