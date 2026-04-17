#!/bin/bash
set -e

echo "🚀 Setting up Debiteurenbeheer..."

# Install SSH server
echo "🔐 Installing SSH server..."
apt-get update && apt-get install -y openssh-server > /dev/null 2>&1 || true

# Clone repos into parent directory
cd /workspaces

echo "📦 Cloning backend repo..."
if [ ! -d "debiteurenbeheer" ]; then
  git clone https://github.com/payt/debiteurenbeheer.git 2>/dev/null || echo "⚠️  Backend repo clone failed (may require authentication)"
fi

echo "📦 Cloning frontend repo..."
if [ ! -d "debiteurenbeheer-frontend" ]; then
  git clone https://github.com/payt/debiteurenbeheer-frontend.git 2>/dev/null || echo "⚠️  Frontend repo clone failed (may require authentication)"
fi

# Setup backend if it exists
if [ -d "debiteurenbeheer" ]; then
  echo "📍 Setting up backend..."
  cd debiteurenbeheer

  echo "💎 Installing bundler..."
  gem install bundler

  echo "📦 Installing gems..."
  bundle install 2>/dev/null || echo "⚠️  Bundle install skipped"

  cd ..
else
  echo "⚠️  Backend repo not found - skipping setup"
fi

# Setup frontend if it exists
if [ -d "debiteurenbeheer-frontend" ]; then
  echo "📍 Setting up frontend..."
  cd debiteurenbeheer-frontend

  echo "📦 Installing Node.js..."
  apt-get install -y nodejs npm > /dev/null 2>&1 || true

  echo "📦 Installing npm dependencies..."
  npm install 2>/dev/null || echo "⚠️  npm install skipped"

  cd ..
else
  echo "⚠️  Frontend repo not found - skipping setup"
fi

# Install Claude Code
echo "🤖 Installing Claude Code..."
npm install -g @anthropic-ai/claude-code 2>/dev/null || true

echo ""
echo "✅ Setup complete!"
echo ""
echo "📁 Repos cloned:"
echo "   /workspaces/debiteurenbeheer (backend)"
echo "   /workspaces/debiteurenbeheer-frontend (frontend)"
echo ""
echo "📋 Start Rails (from backend directory):"
echo "   cd /workspaces/debiteurenbeheer"
echo "   bundle exec rails s -b 0.0.0.0"
echo ""
echo "📋 Start React (from frontend directory):"
echo "   cd /workspaces/debiteurenbeheer-frontend"
echo "   npm start"
echo ""
echo "🤖 Use Claude Code:"
echo "   claude <command>"
echo ""
