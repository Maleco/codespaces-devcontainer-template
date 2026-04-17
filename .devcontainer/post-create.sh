#!/bin/bash
set -e

echo "🚀 Setting up Debiteurenbeheer development environment..."

# Update package lists
sudo apt-get update

# Install Ruby
echo "💎 Installing Ruby 3.4..."
sudo apt-get install -y ruby-full build-essential 2>&1 | grep -v "^Get:\|^Hit:\|^Ign:\|^Reading\|^Building\|^Setting up\|^Processing triggers" | tail -20 || true

# Install PostgreSQL and Redis
echo "🗄️  Installing PostgreSQL and Redis..."
sudo apt-get install -y postgresql postgresql-contrib redis-server 2>&1 | grep -v "^Get:\|^Hit:\|^Ign:\|^Reading\|^Building\|^Setting up\|^Processing triggers" | tail -20 || true

# Start services
echo "▶️  Starting PostgreSQL and Redis..."
sudo service postgresql start || true
sudo service redis-server start || true
sleep 2

# Setup Rails
echo "💎 Installing bundler..."
sudo gem install bundler

# Clone frontend repo if not already present
if [ ! -d "../debiteurenbeheer-frontend" ]; then
  echo "📦 Cloning frontend repository..."
  cd ..
  git clone https://github.com/payt/debiteurenbeheer-frontend.git
  cd debiteurenbeheer
fi

# Install frontend dependencies
echo "📦 Installing frontend dependencies..."
cd ../debiteurenbeheer-frontend
npm install
cd ../debiteurenbeheer

# Install backend dependencies
echo "📦 Installing backend dependencies..."
bundle install

# Setup PostgreSQL user and database
echo "🗄️  Setting up PostgreSQL database..."
sudo -u postgres psql -c "CREATE USER payt WITH PASSWORD 'payt_password' CREATEDB;" 2>/dev/null || echo "  (user already exists)"
sudo -u postgres psql -c "CREATE DATABASE debiteurenbeheer_development OWNER payt;" 2>/dev/null || echo "  (database already exists)"

# Run migrations if applicable
echo "🗄️  Running database migrations..."
bundle exec rails db:migrate 2>/dev/null || echo "  (skipped - may need manual setup)"

# Install Claude Code CLI
echo "🤖 Installing Claude Code CLI..."
npm install -g @anthropic-ai/claude-code 2>/dev/null || echo "  (already installed)"

echo ""
echo "✅ Setup complete!"
echo ""
echo "📋 Services running:"
echo "   ✓ PostgreSQL (localhost:5432)"
echo "   ✓ Redis (localhost:6379)"
echo ""
echo "📋 Next steps:"
echo ""
echo "1️⃣  Start the Rails server (in a new terminal):"
echo "    bundle exec rails s -b 0.0.0.0"
echo ""
echo "2️⃣  Start the frontend dev server (in another terminal):"
echo "    cd ../debiteurenbeheer-frontend"
echo "    npm start"
echo ""
echo "3️⃣  Use Claude Code:"
echo "    claude <your-command>"
echo ""
echo "📚 Quick commands:"
echo "   bundle exec rails console"
echo "   npm test"
echo ""
