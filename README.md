# Mercury

[![CircleCI status](https://img.shields.io/circleci/token/76456c94f050ce9772c7d30d0791bc929071e1bb/project/github/batteries911/mercury/develop.svg?style=flat-square)](https://circleci.com/gh/batteries911/mercury)
[![Codacy grade](https://img.shields.io/codacy/grade/4a6a6ef185ae47ec8b7dcbfbf8d40a40/develop.svg?style=flat-square)](https://www.codacy.com/app/Batteries911/mercury/dashboard)
[![Codacy coverage](https://img.shields.io/codacy/coverage/4a6a6ef185ae47ec8b7dcbfbf8d40a40/develop.svg?style=flat-square)](https://www.codacy.com/app/Batteries911/mercury/dashboard)

Mercury is a generic message broker. It runs as a microservice and is constantly taking messages
back and forth over all kinds of communication protocols (currently APNS and ActionCable).

If you need something to be known, he's your guy.

[![Mercury](https://github.com/batteries911/mercury/raw/develop/logo.jpg)](https://en.wikipedia.org/wiki/Mercury_(mythology))

## 1. Requirements

- Ruby 2.4
- PostgreSQL 9.x
- Redis 3.x

## 2. Installation

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

## 3. Usage

### 3.1. Profile

...

### 3.2. Devices

...

### 3.3. Profile Groups

...

### 3.4. Notifications

...

### 3.5. Transports

...

#### 3.5.1. ActionCable

...

#### 3.5.2. APNS

...

## 4. Testing

RSpec is configured for testing. To run the tests:

```console
$ bin/rspec
```

## 5. Deployment

The application is already configured for deployment on Heroku, including a release command that
runs DB migrations.

Provided that you have the [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli) installed,
deploying a new app should be as simple as:

```console
$ heroku create
$ figaro heroku
$ git push heroku master
```

## 6. Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/batteries911/mercury.
