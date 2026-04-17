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
  git clone https://github.com/payt/debiteurenbeheer.git
fi

echo "📦 Cloning frontend repo..."
if [ ! -d "debiteurenbeheer-frontend" ]; then
  git clone https://github.com/payt/debiteurenbeheer-frontend.git
fi

# Setup backend
echo "📍 Setting up backend..."
cd debiteurenbeheer

echo "💎 Installing bundler..."
gem install bundler

echo "📦 Installing gems..."
bundle install

# Setup frontend
echo "📍 Setting up frontend..."
cd ../debiteurenbeheer-frontend

echo "📦 Installing Node.js..."
apt-get install -y nodejs npm > /dev/null 2>&1 || true

echo "📦 Installing npm dependencies..."
npm install

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
