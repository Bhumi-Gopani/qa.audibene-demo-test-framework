#!/bin/bash

set -e

echo "🧹 Cleaning previous Gatling performance results..."
rm -rf target/gatling

echo "🐳 Building Docker image (karate-tests)..."
docker build -t karate-tests .

echo "🚀 Running Gatling performance test in Docker..."
docker run --rm \
    -e TEST_TYPE=perf \
    -v "$(pwd)/target:/app/target" \
    karate-tests

# Find latest Gatling report
LATEST_REPORT_DIR=$(ls -td target/gatling/* | head -1)

echo ""
echo "✅ Performance test complete."
echo "📈 Gatling HTML Report available at:"
echo "  → $LATEST_REPORT_DIR/index.html"
