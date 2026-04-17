# GitHub Codespaces Development Environment

This `.devcontainer` configuration sets up a complete development environment for Debiteurenbeheer with both Rails backend and React frontend.

## Features

✅ **Ruby 3.4.4** with Rails 8.0  
✅ **Node 24.6.0** with React and rsbuild  
✅ **Docker-in-Docker** for running PostgreSQL, Redis, Elasticsearch  
✅ **Claude Code CLI** for AI-assisted development  
✅ **VS Code extensions** pre-configured  

## Quick Start

### 1. Create a Codespace

Click "Code" → "Codespaces" → "Create codespace on main" in the backend repository.

### 2. Wait for Setup

The container will automatically:
- Clone the frontend repository
- Install Node dependencies  
- Install Ruby dependencies
- Set up environment files

### 3. Add Sidekiq Enterprise Secret

Get the `BUNDLE_ENTERPRISE__CONTRIBSYS__COM` secret from Bitwarden and run:

```bash
export BUNDLE_ENTERPRISE__CONTRIBSYS__COM="your-secret-here"
```

### 4. Start Backend Services

```bash
docker compose up -d
```

This starts:
- PostgreSQL (port 5432)
- Redis (port 6379)
- Elasticsearch (port 9200)

### 5. Start Rails Server

In a new terminal:

```bash
bundle exec rails s -b 0.0.0.0
```

Backend runs on http://localhost:3000

### 6. Start React Frontend

In another new terminal:

```bash
cd ../debiteurenbeheer-frontend
npm start
```

Frontend runs on http://localhost:5000

## Using Claude Code

Claude Code CLI is pre-installed. Use it to get help with development:

```bash
# Get help with a specific file
claude code src/app/models/invoice.rb

# Ask Claude to implement a feature
claude "Add a method to generate payment reminders"

# Use interactive mode
claude -i
```

## Project Structure

```
.
├── debiteurenbeheer/              # Rails backend
│   ├── app/
│   ├── config/
│   ├── db/
│   ├── docker-compose.yml
│   └── Gemfile
│
└── debiteurenbeheer-frontend/     # React frontend
    ├── src/
    ├── public/
    ├── package.json
    └── .rsbuild.config.ts
```

## Common Commands

### Backend

```bash
cd debiteurenbeheer

# Database
bundle exec rails db:migrate
bundle exec rails db:seed

# Elasticsearch
bundle exec rails es:reset
bundle exec rails es:seed

# Tests
bundle exec rspec
bundle exec rubocop

# Console
bundle exec rails console
```

### Frontend

```bash
cd ../debiteurenbeheer-frontend

# Install dependencies
npm install

# Run dev server
npm start

# Build
npm run build

# Tests
npm test

# Lint
npm run eslint
```

### Docker Services

```bash
# View logs
docker compose logs -f backend

# Run Rails command in container
docker compose exec backend bundle exec rails db:migrate

# Stop all services
docker compose down

# Reset everything
docker compose down --volumes
docker compose up -d
```

## Troubleshooting

### Services won't start

```bash
# Check Docker
docker ps
docker compose ps

# View logs
docker compose logs

# Rebuild containers
docker compose down --volumes
docker compose up -d
```

### Bundle install fails

Make sure `BUNDLE_ENTERPRISE__CONTRIBSYS__COM` is set:

```bash
echo $BUNDLE_ENTERPRISE__CONTRIBSYS__COM
```

### Port conflicts

If ports are already in use, you can change them:

```bash
# Backend on different port
bundle exec rails s -b 0.0.0.0 -p 3001

# Frontend on different port
npm start -- --port 5001
```

## Tips

- **Keep services running**: Use separate terminal tabs for each service
- **Forward ports**: VS Code automatically exposes forwarded ports (click the Ports tab)
- **Share your Codespace**: Use the "Share" button to collaborate
- **Stop when done**: Run `docker compose down` to free resources
- **Use Claude Code**: It's available in every terminal for quick help

## Environment Variables

The `.env` file is created automatically. Common variables:

```bash
# Docker
DOCKER_CONTAINER_USER=vscode
DOCKER_CONTAINER_HOME=/home/vscode
DOCKER_BACKEND_PORT=3000

# Rails
RAILS_ENV=development
RAILS_MASTER_KEY=...

# Sidekiq Enterprise (from Bitwarden)
BUNDLE_ENTERPRISE__CONTRIBSYS__COM=...
```

## Resources

- [Rails Guide](https://guides.rubyonrails.org)
- [React Docs](https://react.dev)
- [Dev Containers Docs](https://containers.dev)
- [GitHub Codespaces Docs](https://docs.github.com/codespaces)
