#!/bin/bash

set -e

echo "🧹 Cleaning all previous test results..."
rm -rf target/cucumber-reports
rm -rf target/karate-reports
rm -rf target/gatling

echo "🐳 Building Docker image (karate-tests)..."
docker build -t karate-tests .

OS=$(uname)

# ---------- API Tests ----------
echo ""
echo "🚀 Running Karate API tests..."
docker run --rm \
    -e TEST_TYPE=api \
    -v "$(pwd)/target:/app/target" \
    karate-tests

API_REPORT="target/cucumber-reports/api/cucumber-html-reports/feature-overview.html"
echo "✅ API Test Report:"
echo "  → $API_REPORT"
if [[ "$OS" == "Darwin" && -f "$API_REPORT" ]]; then
    open "$API_REPORT"
fi

# ---------- UI Tests ----------
echo ""
echo "🚀 Running Karate UI tests..."
docker run --rm \
    -e TEST_TYPE=ui \
    -v "$(pwd)/target:/app/target" \
    karate-tests

UI_REPORT="target/cucumber-reports/ui/cucumber-html-reports/feature-overview.html"
echo "✅ UI Test Report:"
echo "  → $UI_REPORT"
if [[ "$OS" == "Darwin" && -f "$UI_REPORT" ]]; then
    open "$UI_REPORT"
fi

# ---------- Performance Tests ----------
echo ""
echo "🚀 Running Gatling Performance tests..."
docker run --rm \
    -e TEST_TYPE=perf \
    -v "$(pwd)/target:/app/target" \
    karate-tests

LATEST_GATLING_REPORT=$(ls -td target/gatling/* | head -1)
PERF_REPORT="$LATEST_GATLING_REPORT/index.html"
echo "✅ Performance Test Report:"
echo "  → $PERF_REPORT"
if [[ "$OS" == "Darwin" && -f "$PERF_REPORT" ]]; then
    open "$PERF_REPORT"
fi

echo ""
echo "🎉 All tests completed successfully!"
