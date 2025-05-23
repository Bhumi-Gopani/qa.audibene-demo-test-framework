#!/bin/bash

set -e

echo "🧹 Cleaning previous test results..."
rm -rf target/cucumber-reports/ui
rm -rf target/karate-reports/ui

echo "🐳 Building Docker image (karate-tests)..."
docker build -t karate-tests .

echo "🚀 Running Karate UI tests in Docker (headless)..."
docker run --rm \
    -e TEST_TYPE=ui \
    -v "$(pwd)/target:/app/target" \
    karate-tests

echo ""
echo "✅ Done. Report available at:"
echo "  → target/cucumber-reports/ui/cucumber-html-reports/feature-overview.html"
