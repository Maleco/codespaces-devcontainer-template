#!/bin/bash
# This runs after container starts

echo "🌟 Welcome to Debiteurenbeheer development!"
echo ""

# Check if both repos are present
if [ ! -d "../debiteurenbeheer-frontend" ]; then
  echo "⚠️  Frontend repo not found. Run: git clone https://github.com/payt/debiteurenbeheer-frontend.git .."
  exit 1
fi

# Check if services are running
if docker ps | grep -q "postgres"; then
  echo "✓ Database services are running"
else
  echo "→ Run 'docker compose up -d' to start database services"
fi

echo ""
echo "💡 Tip: Use 'claude' command for AI-assisted development"
echo ""
