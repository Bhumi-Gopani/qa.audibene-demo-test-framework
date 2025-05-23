Feature: Google UI Test

    Background:
        #    * configure driver = { type: 'chrome', executable: '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome', headless: false }
        * configure driver = { type: 'chrome', executable: '/usr/bin/google-chrome', headless: true, addOptions: ['--no-sandbox', '--disable-dev-shm-usage'] }
        * configure afterScenario =
            """
            function(){
            if (karate.scenarioError) {
            karate.log('💥 Scenario failed, taking screenshot...');
            karate.takeScreenshot();
            }
            }
            """


    @ui
    Scenario: Launch Google and verify title
        Given driver 'https://www.google.com'
        Then match driver.title contains 'Google'
