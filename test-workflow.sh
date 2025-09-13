#!/bin/bash

# Test script to simulate the GitHub Actions workflow locally

echo "🧪 Testing Alembic PR Validation Workflow"
echo "=========================================="

cd server

echo "📦 Installing dependencies with Poetry..."
poetry install --no-interaction --no-root

echo ""
echo "🔍 Checking Alembic heads..."
echo "Command: poetry run alembic -c alembic.ini heads"
poetry run alembic -c alembic.ini heads

echo ""
echo "🧮 Counting heads..."
n="$(poetry run alembic -c alembic.ini heads | grep -c "(head)")"
echo "Number of heads found: $n"

echo ""
echo "✅ Running validation check..."
if [ "$n" -eq 1 ]; then
    echo "✅ PASS: Exactly 1 Alembic head found - workflow would succeed"
    exit 0
else
    echo "❌ FAIL: $n Alembic heads detected - workflow would fail"
    echo ""
    echo "📋 Detailed head information:"
    poetry run alembic -c alembic.ini heads
    exit 1
fi
