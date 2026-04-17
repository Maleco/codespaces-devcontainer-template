#!/bin/bash
set -e

echo "🚀 Setting up Debiteurenbeheer Backend..."

# Install SSH server
echo "🔐 Installing SSH server..."
apt-get update && apt-get install -y openssh-server > /dev/null 2>&1 || true

# Install bundler
echo "💎 Installing bundler..."
gem install bundler

# Install backend dependencies
echo "📦 Installing gems..."
bundle install

# Install Node for Claude Code
echo "📦 Installing Node.js..."
apt-get update && apt-get install -y nodejs npm > /dev/null 2>&1

# Install Claude Code CLI
echo "🤖 Installing Claude Code..."
npm install -g @anthropic-ai/claude-code 2>/dev/null || true

echo ""
echo "✅ Ready!"
echo ""
echo "📋 Start Rails:"
echo "   bundle exec rails s -b 0.0.0.0"
echo ""
echo "🤖 Use Claude:"
echo "   claude <command>"
echo ""
