#!/bin/bash
set -e

echo "🚀 Setting up Debiteurenbeheer development environment..."

# Clone frontend repo if not already present
if [ ! -d "../debiteurenbeheer-frontend" ]; then
  echo "📦 Cloning frontend repository..."
  cd ..
  git clone https://github.com/payt/debiteurenbeheer-frontend.git
  cd debiteurenbeheer
fi

# Frontend setup
echo "📦 Installing frontend dependencies..."
cd ../debiteurenbeheer-frontend
npm install

# Backend setup
echo "📦 Setting up backend..."
cd ../debiteurenbeheer

# Install bundler
echo "💎 Installing Ruby dependencies..."
gem install bundler

# Create .env if it doesn't exist
if [ ! -f ".env" ]; then
  echo "📝 Creating .env file..."
  cat > .env << 'EOF'
# Docker compose setup
DOCKER_CONTAINER_USER=vscode
DOCKER_CONTAINER_HOME=/home/vscode
DOCKER_BACKEND_PORT=3000
DOCKER_NETWORK_NAMESPACE=_codespace

# Sidekiq Enterprise (required for bundle install)
# Add this from Bitwarden
# export BUNDLE_ENTERPRISE__CONTRIBSYS__COM="your-secret-here"
EOF
  echo "⚠️  Please add BUNDLE_ENTERPRISE__CONTRIBSYS__COM to .env from Bitwarden"
fi

# Install Claude Code CLI
echo "🤖 Installing Claude Code CLI..."
npm install -g @anthropic-ai/claude-code || echo "Claude Code CLI already installed or installation skipped"

echo ""
echo "✅ Setup complete!"
echo ""
echo "📋 Next steps:"
echo ""
echo "1️⃣  Add the Sidekiq Enterprise secret:"
echo "    export BUNDLE_ENTERPRISE__CONTRIBSYS__COM=\"<secret-from-bitwarden>\""
echo ""
echo "2️⃣  Start the backend services (PostgreSQL, Redis, Elasticsearch):"
echo "    docker compose up -d"
echo ""
echo "3️⃣  In another terminal, start the Rails server:"
echo "    cd debiteurenbeheer && bundle exec rails s"
echo ""
echo "4️⃣  In another terminal, start the frontend dev server:"
echo "    cd debiteurenbeheer-frontend && npm start"
echo ""
echo "5️⃣  Use Claude Code to develop:"
echo "    claude <command>"
echo ""
echo "📚 Useful commands:"
echo "   docker compose up       - Start all backend services"
echo "   docker compose down     - Stop all backend services"
echo "   rails db:migrate        - Run migrations"
echo "   rails es:reset          - Reset Elasticsearch"
echo ""
