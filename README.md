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

There are four core concepts in Mercury:

- **Profile:** A profile identifies a user who can receive and send messages.
- **Profile Group:** Profile groups are collections of users who share traits. The most common use
  for profile groups is to group users by role (admin, regular user etc.)
- **Device:** Devices are anything you can be notify: a physical iOS device, an email address etc.
- **Transport:** Transports are technologies supported for relying messages back and forth. Some
  transports have write-only capability (e.g. APNS), while some allow for two-way communication
  (Ably, ActionCable).
  
## 4. Transports

Out of the box, Mercury supports three transports:

- **ActionCable** (read and write)
- **Ably** (read and write)
- **APNS** (write)

Incoming ActionCable and Ably messages are received, parsed to extract the profile ID and then
forwarded over RabbitMQ.

## 5. Testing

RSpec is configured for testing. To run the tests:

```console
$ bin/rspec
```

## 6. Deployment

The application is already configured for deployment on Heroku, including a release command that
runs DB migrations.

Provided that you have the [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli) installed,
deploying a new app should be as simple as:

```console
$ heroku create
$ figaro heroku
$ git push heroku master
```

## 7. Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/batteries911/mercury.
