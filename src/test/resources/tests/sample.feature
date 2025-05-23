Feature: Sample test

    @api
    Scenario: basic get
        * url 'https://jsonplaceholder.typicode.com/users'
        * method get
        * status 200
