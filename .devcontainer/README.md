# Development Container Configurations

This template includes two dev container setups for the Debiteurenbeheer project:

## Backend Container
**Path:** `.devcontainer/backend/`

- **Services**: Rails app, PostgreSQL, Redis, Elasticsearch, Sidekiq
- **Port**: 3000 (Rails)
- **Includes**: Claude Code extension, Ruby LSP
- **Setup**: Database auto-migration on creation

Use this for backend development and API work.

## Frontend Container
**Path:** `.devcontainer/frontend/`

- **Services**: React app with Node.js
- **Port**: 5000 (React dev server)
- **Includes**: Claude Code extension, ESLint, Prettier
- **Setup**: NPM dependencies installed on creation

Use this for frontend development and UI work.

## Creating a Codespace

When you create a Codespace:

1. Go to the repository Code menu
2. Select "Codespaces"
3. GitHub will ask which dev container config to use
4. Choose either `backend` or `frontend`
5. Wait for setup to complete

Both containers are pre-configured with:
- ✅ Claude Code extension
- ✅ Docker Compose services
- ✅ Auto dependency installation
- ✅ VS Code extensions for development

## Full Stack Development

To develop both frontend and backend simultaneously:

1. Create a backend Codespace
2. In a separate browser tab, create a frontend Codespace
3. Work in parallel with separate terminals

## Notes

- Both containers use the root-level `docker-compose.yml` plus their own overrides
- Services are shared when running in the same Codespace
- Environment configuration is automatic
