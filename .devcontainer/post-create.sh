#!/bin/bash
set -e

echo "🚀 Setting up Debiteurenbeheer..."

# Install SSH server
echo "🔐 Installing SSH server..."
apt-get update && apt-get install -y openssh-server > /dev/null 2>&1 || true

# Install GitHub CLI
echo "🐙 Installing GitHub CLI..."
apt-get install -y gh > /dev/null 2>&1 || true

# Clone repos into parent directory
cd /workspaces

echo "📦 Cloning backend repo..."
if [ ! -d "debiteurenbeheer" ]; then
  gh repo clone payt/debiteurenbeheer || echo "⚠️  Backend repo clone failed"
fi

echo "📦 Cloning frontend repo..."
if [ ! -d "debiteurenbeheer-frontend" ]; then
  gh repo clone payt/debiteurenbeheer-frontend || echo "⚠️  Frontend repo clone failed"
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

# Install Claude
echo "🤖 Installing Claude..."
curl -fsSL https://claude.ai/install.sh | bash 2>/dev/null || echo "⚠️  Claude installation skipped"

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
echo "🤖 Use Claude:"
echo "   claude <command>"
echo ""
