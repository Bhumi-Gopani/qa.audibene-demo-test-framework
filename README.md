# 🥋 Karate + Gatling + Docker Test Automation Framework

This project contains a full-stack automated testing setup using:

- ✅ [Karate](https://github.com/karatelabs/karate) for API and UI testing
- ✅ [Gatling](https://gatling.io/) for performance testing
- ✅ Docker for isolated, reproducible execution
- ✅ GitHub Actions for CI automation
- ✅ Cucumber HTML reports with screenshots
- ✅ Pre-commit hooks for formatting and consistency

## 📁 Project Structure
```
├── src/
│ ├── test/
│ │ ├── java/KarateTest.java # Entry point for Karate tests
│ │ └── scala/simulations/... # Gatling performance test
│ └── resources/
│ ├── tests/sample.feature # Karate API test
│ └── ui/google.feature # Karate UI test
├── Dockerfile # Chrome-enabled Karate+Gatling image
├── run-api-in-docker.sh # Run API tests
├── run-ui-in-docker.sh # Run UI tests
├── run-performance-in-docker.sh # Run Gatling test
├── run-all-in-docker.sh # Run all tests (with report auto-open)
├── pom.xml # Maven build file
└── .pre-commit-config.yaml # Formatting, linting, hooks
```
## 🚀 Quick Start

### 🔧 Prerequisites

- Docker
- Maven
- Node.js (for optional `.feature` file formatting)
- ChromeDriver (if running UI tests locally)

---

### 🧪 Run All Tests Locally (Using Docker)

```bash
./run-all-in-docker.sh
```

This will:

- Clean previous reports
- Run API, UI, and performance tests in Docker
- Save reports under target/
- Open Cucumber and Gatling HTML reports (macOS only)

### 🧪 Run Individual Tests

```bash
./run-api-in-docker.sh
./run-ui-in-docker.sh
./run-performance-in-docker.sh
```

### 🧾 Reports

| Type        | Path                                                 |
| ----------- | ---------------------------------------------------- |
| API Tests   | `target/cucumber-reports/api/cucumber-html-reports/` |
| UI Tests    | `target/cucumber-reports/ui/cucumber-html-reports/`  |
| Performance | `target/gatling/<simulation>/index.html`             |
| Screenshots | `target/karate-reports/*.png` (on UI failures)       |

✅ Folder Structure of reporting
```
target/
├── cucumber-reports/
│ ├── api/
│ │ └── feature-overview.html
│ └── ui/
│ └── feature-overview.html
├── karate-reports/
│ ├── api/
│ │ └── results.json
│ └── ui/
│ └── results.json
├── gatling/
│ └── userapisimulation-20250520194503456/
│ └── index.html
```
### 🤖 CI: GitHub Actions

All tests run automatically on every push or pull_request to main.

✅ Includes:

- API, UI, and performance test runs in Docker
- Uploads test reports as downloadable artifacts
- Parallel-safe and self-cleaning

### 🐛 Debugging UI Tests

To run UI tests in visible Chrome for debugging:

```
mvn test -Dtest=KarateTest#runKarateUITests -Pdebug
```

- Adds headless: false automatically via Maven profile
- Shows Chrome browser during test execution
- Can be combined with pause() and screenshot() in .feature files

### Usefull Commands

| Task                    | Command                                                                                            |
| ----------------------- | -------------------------------------------------------------------------------------------------- |
| Install project         | `mvn clean install`                                                                                |
| Run all Karate tests    | `mvn test`                                                                                         |
| Run only API test       | `mvn test -Dtest=KarateTest#runKarateTests`                                                        |
| Run only UI test        | `mvn test -Dtest=KarateTest#runKarateUITests`                                                      |
| Run performance test    | `mvn test -Pperformance-tests`                                                                     |
| Run performance test    | `mvn io.gatling:gatling-maven-plugin:test -Dgatling.simulationClass=simulations.UserApiSimulation` |
| Open Karate HTML report | `target/cucumber-html-reports/index.html`                                                          |
| Open Gatling report     | `target/gatling/userapisimulation-*/index.html`                                                    |

### Usefull Docker Commands

| Task                  | Command                                                                       |
| --------------------- | ----------------------------------------------------------------------------- |
| Build Docker          | `docker build -t karate-gatling .`                                            |
| Run Docker            | `docker run --rm karate-gatling`                                              |
| Run Docker API Tests  | `docker run --rm -e TEST_TYPE=api -v $(pwd)/target:/app/target karate-tests`  |
| Run Docker UI Tests   | `docker run --rm -e TEST_TYPE=ui -v $(pwd)/target:/app/target karate-tests`   |
| Run Docker Perf Tests | `docker run --rm -e TEST_TYPE=perf -v $(pwd)/target:/app/target karate-tests` |

### 🤖 What Else ?

- Add Selenium Grid
- Add Other CI componeents
- Add Slack Reporting

✅ Includes:

- API, UI, and performance test runs in Docker
- Uploads test reports as downloadable artifacts
- Parallel-safe and self-cleaning

### 👤 Author

Maintained by Bhumi Gopani
Project powered by Karate, Gatling, and GitHub Actions 💥
