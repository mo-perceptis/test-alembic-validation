# Server - Alembic Test Project

This directory contains the server-side code for testing Alembic migrations with GitHub Actions.

## Setup with Poetry

```bash
cd server
poetry install
```

## Alembic Commands

```bash
# Check current migration status
poetry run alembic current

# Check for multiple heads (this is what the CI tests)
poetry run alembic heads

# Create new migration
poetry run alembic revision --autogenerate -m "Description"

# Apply migrations
poetry run alembic upgrade head
```

## Testing the GitHub Workflow

The GitHub workflow (`../.github/workflows/pr-validation.yml`) will:

1. Check that there's only one Alembic head
2. Validate migration files when changes are made to `server/alembic/versions/**`

To test multiple heads scenario:
1. Create two separate migration files with the same down_revision
2. Push to a PR branch
3. The workflow should fail and detect multiple heads
