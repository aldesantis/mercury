# Mercury

[![CircleCI status](https://img.shields.io/circleci/token/76456c94f050ce9772c7d30d0791bc929071e1bb/project/github/batteries911/mercury/develop.svg?style=flat-square)](https://circleci.com/gh/batteries911/mercury)
[![Codacy grade](https://img.shields.io/codacy/grade/4a6a6ef185ae47ec8b7dcbfbf8d40a40/develop.svg?style=flat-square)](https://www.codacy.com/app/Batteries911/mercury/dashboard)
[![Codacy coverage](https://img.shields.io/codacy/coverage/4a6a6ef185ae47ec8b7dcbfbf8d40a40/develop.svg?style=flat-square)](https://www.codacy.com/app/Batteries911/mercury/dashboard)

Mercury is a generic notification broker.

## Requirements

- Ruby 2.4
- PostgreSQL 9.x
- Redis 3.x

## Installation

Clone this repo:

```console
$ git clone git://github.com/batteries911/mercury.git
$ cd my-project
```

Configure the application and the database:

```console
$ cp config/database.example.yml config/database.yml
$ cp config/application.example.yml config/application.yml
```

Once you're done with the configuration, you can setup the database:

```console
$ rake db:setup
```

Run the application with:

```console
$ foreman s -f Procfile.development
```

## Testing

RSpec is configured for testing. To run the tests:

```console
$ bin/rspec
```

## Deployment

The application is already configured for deployment on Heroku, including a release command that
runs DB migrations.

Provided that you have the [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli) installed,
deploying a new app should be as simple as:

```console
$ heroku create
$ figaro heroku
$ git push heroku master
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/batteries911/mercury.
