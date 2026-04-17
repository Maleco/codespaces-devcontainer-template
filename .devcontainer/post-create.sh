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
cd ../debiteurenbeheer

# Backend setup
echo "💎 Installing bundler..."
gem install bundler

echo "📦 Installing Ruby dependencies..."
bundle install

# PostgreSQL setup
echo "🗄️  Setting up PostgreSQL database..."
sudo service postgresql start || true

# Wait for PostgreSQL to start
sleep 2

# Create database user and database
sudo -u postgres psql -c "CREATE USER payt WITH PASSWORD 'payt_password' CREATEDB;" 2>/dev/null || true
sudo -u postgres psql -c "CREATE DATABASE debiteurenbeheer_development OWNER payt;" 2>/dev/null || true

# Setup Rails database
echo "🗄️  Running database migrations..."
bundle exec rails db:migrate 2>/dev/null || echo "⚠️  Database migration skipped (database may not be initialized yet)"

# Redis setup
echo "📦 Installing Redis..."
sudo apt-get update && sudo apt-get install -y redis-server 2>/dev/null || echo "Redis installation skipped"
sudo service redis-server start || true

# Install Claude Code CLI
echo "🤖 Installing Claude Code CLI..."
npm install -g @anthropic-ai/claude-code 2>/dev/null || echo "Claude Code CLI already installed or installation skipped"

echo ""
echo "✅ Setup complete!"
echo ""
echo "📋 Next steps:"
echo ""
echo "1️⃣  Start the Rails server (in a new terminal):"
echo "    cd debiteurenbeheer"
echo "    bundle exec rails s -b 0.0.0.0"
echo ""
echo "2️⃣  Start the frontend dev server (in another terminal):"
echo "    cd ../debiteurenbeheer-frontend"
echo "    npm start"
echo ""
echo "3️⃣  Use Claude Code to develop:"
echo "    claude <command>"
echo ""
echo "📚 Quick commands:"
echo "   bundle exec rails console         - Rails console"
echo "   bundle exec rails db:migrate      - Run migrations"
echo "   npm test                          - Run frontend tests"
echo ""
