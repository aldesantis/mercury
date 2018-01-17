# Mercury

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/4a6a6ef185ae47ec8b7dcbfbf8d40a40)](https://www.codacy.com?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=batteries911/mercury&amp;utm_campaign=Badge_Grade)
[![Codacy Badge](https://api.codacy.com/project/badge/Coverage/4a6a6ef185ae47ec8b7dcbfbf8d40a40)](https://www.codacy.com?utm_source=github.com&utm_medium=referral&utm_content=batteries911/mercury&utm_campaign=Badge_Coverage)
[![CircleCI](https://circleci.com/gh/batteries911/mercury.svg?style=svg&circle-token=6f41a542a40faa6f344e2dba0d2c5ec9afb9e10e)](https://circleci.com/gh/batteries911/mercury)

Mercury is a generic message broker. It runs as a microservice and is constantly taking messages
back and forth over all kinds of communication channels.

If you need something to be known, he's your guy.

[![Mercury](https://github.com/batteries911/mercury/raw/develop/logo.jpg)](https://en.wikipedia.org/wiki/Mercury_(mythology))

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

## Usage

There are four core concepts in Mercury:

- **Profile:** A profile identifies a user who can receive and send messages.
- **Profile Group:** Profile groups are collections of users who share traits. The most common use
  for profile groups is to group users by role (admin, regular user etc.)
- **Device:** Devices are anything you can notify: a physical iOS device, an email address etc.
- **Transport:** Transports are technologies supported for relying messages back and forth. Some
  transports have write-only capability (e.g. APNS, PubNub), while some allow for two-way 
  communication (ActionCable).
  
## Transports

Out of the box, Mercury supports three transports.

### PubNub

[PubNub](https://www.pubnub.com/) is the preferred transport for real-time communication and is 
replacing ActionCable.

**Outgoing messages** are delivered to the `profiles:ID` channel if the recipient is a specific
profile or to the `profile_groups:ID` channel if the recipient is a profile group.

**Authentication** happens through PubNub authentication keys. The key can be sent to any clients 
that wish to connect to PubNub.

### ActionCable

While still supported, ActionCable is being replaced by the PubNub transport due to its unreliability.

When clients connect, they are automatically subscribed to their profile's channel and to the
channel of each profile group they belong to.

**Outgoing messages** are delivered to the profile channel if the recipient is a specific
profile or to the profile group channel if the recipient is a profile group.

**Incoming messages** are parsed to extract the Mercury profile ID and then pushed to RabbitMQ
where they can be consumed by any subscribers.

**Authentication** happens through JWT. The provided JWT can be used to connect to ActionCable.

### APNS

APNS support is provided by [RPush](https://github.com/rpush/rpush).

APNS is a bit different from the other transports, because it requires for each APNS application
to be configured and for its certificate to be imported. It also requires that each profile has
a device in order to send notification to the appropriate APNS tokens.

Mercury comes out of the box with the sandbox and production certificates for the Batteries911
iOS apps. They can be imported with a Rake task:

```console
$ CERTS_PASSWORD=SecretPassword rails mercury:import_certs
```

If you need to import the certificates, ask Alessandro or Julian for the password.

**Outgoing messages** require that the APNS app to use for delivery is specified. If the recipient
is a profile, the message is delivered to the profile's devices for that APNS app. If the recipient
is a profile group, the message is delivered to all the devices for that APNS app in the profile
group.

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
