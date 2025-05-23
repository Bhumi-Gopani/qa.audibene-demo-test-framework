#!/bin/bash

set -e

echo "🧹 Cleaning previous API test results..."
rm -rf target/cucumber-reports/api
rm -rf target/karate-reports/api

echo "🐳 Building Docker image (karate-tests)..."
docker build -t karate-tests .

echo "🚀 Running Karate API tests in Docker..."
docker run --rm \
    -e TEST_TYPE=api \
    -v "$(pwd)/target:/app/target" \
    karate-tests

echo ""
echo "✅ Done. Report available at:"
echo "  → target/cucumber-reports/api/cucumber-html-reports/feature-overview.html"
