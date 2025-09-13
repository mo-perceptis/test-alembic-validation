# Test Alembic Validation

This is a test project for validating Alembic migrations using pre-commit hooks.

## Setup

1. Install dependencies:
```bash
pip install -r requirements.txt
```

2. Copy environment file:
```bash
cp .env.example .env
```

3. Set up the database (PostgreSQL):
```bash
# Make sure PostgreSQL is running and create the database
createdb test_alembic
```

4. Install pre-commit hooks:
```bash
pip install pre-commit
pre-commit install
```

## Usage

### Generate Initial Migration

```bash
cd server
poetry run alembic revision --autogenerate -m "Initial migration"
```

### Apply Migrations

```bash
cd server
poetry run alembic upgrade head
```

### Check Migration Status

```bash
cd server
poetry run alembic current
poetry run alembic history
```

### Check for Multiple Heads (What the CI Tests)

```bash
cd server
poetry run alembic heads
# Should show only one head for CI to pass
```

### Test Pre-commit Hooks

The pre-commit hooks will automatically run when you commit changes. You can also run them manually:

```bash
pre-commit run --all-files
```

## Pre-commit Hooks

This project includes several pre-commit hooks:

1. **alembic-check**: Validates that all migrations can be applied
2. **alembic-autogenerate-check**: Checks for pending migrations when models are changed
3. **black**: Code formatting
4. **isort**: Import sorting
5. **Standard hooks**: trailing whitespace, YAML validation, etc.

## Project Structure

```
├── server/
│   ├── alembic/           # Alembic configuration and migrations
│   ├── app/core/          # Application core (config)
│   └── core/              # Models and database setup
├── requirements.txt       # Python dependencies
├── .pre-commit-config.yaml # Pre-commit configuration
└── README.md             # This file
```

## Testing the Setup

1. Make a change to the models in `server/core/models.py`
2. Try to commit - the pre-commit hook should catch pending migrations
3. Generate the migration: `cd server && python -m alembic revision --autogenerate -m "Your change"`
4. Commit again - should pass all checks
