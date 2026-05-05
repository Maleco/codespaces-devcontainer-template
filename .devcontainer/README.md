# Development Container Configurations

## Full Stack (RECOMMENDED)
**Path:** `.devcontainer/full-stack/`

Clones all three repos (`debiteurenbeheer`, `debiteurenbeheer-frontend`, `factuurinzien`) and starts the full stack automatically.

**Services:** Rails + Sidekiq + PostgreSQL + Elasticsearch + Redis + both React dev servers  
**Ports:** 3000 (Rails) · 5000 (frontend) · 5001 (debtor portal)  
**Extensions:** Claude Code, Ruby LSP, ESLint, Prettier

### Quick start

1. Go to **Code → Codespaces → New codespace**
2. Select **4-core** machine
3. _(Optional)_ Set `FEATURE_BRANCH=your-branch` to start on a feature branch across all 3 repos
4. Wait ~5 min for setup
5. Access URLs printed in terminal on ready

### Required Codespaces secret (set once)

| Secret | Where |
|--------|-------|
| `BUNDLE_ENTERPRISE__CONTRIBSYS__COM` | [github.com/settings/codespaces](https://github.com/settings/codespaces) |
| `NODE_AUTH_TOKEN` | same |

`SECRET_KEY_BASE` and `LOCKBOX_MASTER_KEY` are hardcoded to dev values in `docker-compose.yml` — same as `.env.development`.

### Pull test data

```bash
cd /workspaces/backend && bin/rails db:pull
```

### Multi-root workspace

Open `debiteurenbeheer.code-workspace` (at repo root) to see all 3 repos in the VS Code file explorer simultaneously.

---

## Backend only
**Path:** `.devcontainer/backend/`

Rails + PostgreSQL + Redis + Elasticsearch + Sidekiq. Use for backend-only work.

## Frontend only
**Path:** `.devcontainer/frontend/`

React dev server. Use for frontend-only work (points at a running backend).
