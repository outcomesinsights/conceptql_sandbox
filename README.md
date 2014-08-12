# ConceptQL Sandbox

The code behind [sandbox.cohortjigsaw.com](http://sandbox.cohortjigsaw.com)

Currently serves as both a sandbox, and as a web service with an API for converting [ConceptQL](http://github.com/outcomesinsights/conceptql) statements into OMOP-CDMv4 Compatible SQL queries.

## Installation
1. Clone this repository
2. `cd conceptql_sandbox`
3. `bundle`
4. Setup your [Sequelizer](http://github.com/outcomesinsights/sequelizer) configuration
5. `bundle exec sequelizer update_gemfile`
6. Point Apache/Nginx/etc at the directory

## Thanks

- [Outcomes Insights, Inc.](http://outins.com)
    - Many thanks for allowing me to release a portion of my work as Open Source Software!
- Daniella Meeker
    - For giving me the idea to create a ConceptQL web service.
