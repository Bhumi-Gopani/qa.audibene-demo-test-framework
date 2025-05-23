
FROM maven:3.9.6-eclipse-temurin-17

WORKDIR /app

# Install required system dependencies for Chrome
RUN apt-get update && apt-get install -y \
    wget curl unzip gnupg2 \
    libnss3 libatk1.0-0 libatk-bridge2.0-0 libcups2 libxcomposite1 \
    libxrandr2 libgbm1 libxdamage1 libxfixes3 libxext6 libx11-xcb1 \
    libx11-6 libxss1 libasound2 libpangocairo-1.0-0 libpango-1.0-0 \
    libatk1.0-0 libgtk-3-0 fonts-liberation libappindicator3-1 \
    xdg-utils

# Install Chrome
RUN curl -LO https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/124.0.6367.208/linux64/chrome-linux64.zip && \
    unzip chrome-linux64.zip && \
    mv chrome-linux64 /opt/chrome && \
    ln -s /opt/chrome/chrome /usr/bin/google-chrome && \
    rm chrome-linux64.zip

# Install ChromeDriver (matching version)
RUN curl -LO https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/124.0.6367.207/linux64/chromedriver-linux64.zip && \
    unzip chromedriver-linux64.zip && \
    mv chromedriver-linux64/chromedriver /usr/local/bin/chromedriver && \
    chmod +x /usr/local/bin/chromedriver && \
    rm -rf chromedriver-linux64.zip chromedriver-linux64

# Set Karate expected chrome path
ENV KARATE_CHROME_EXECUTABLE=/usr/bin/google-chrome

COPY . .

ARG TEST_TYPE=api

CMD if [ "$TEST_TYPE" = "ui" ]; then \
    mvn -Dtest=KarateTest#runKarateUITests test ;\
    elif [ "$TEST_TYPE" = "perf" ]; then \
    mvn io.gatling:gatling-maven-plugin:test -Dgatling.simulationClass=simulations.UserApiSimulation ;\
    else \
    mvn -Dtest=KarateTest#runKarateTests test ;\
    fi
