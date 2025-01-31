[![Gem Version](https://badge.fury.io/rb/dor-event-client.svg)](https://badge.fury.io/rb/dor-event-client)
[![CircleCI](https://circleci.com/gh/sul-dlss/dor-event-client.svg?style=svg)](https://circleci.com/gh/sul-dlss/dor-event-client)
[![codecov](https://codecov.io/github/sul-dlss/dor-event-client/graph/badge.svg?token=FOQQPE3CKA)](https://codecov.io/github/sul-dlss/dor-event-client)

# Dor::Event::Client

Dor::Event::Client is a Ruby gem that acts as a client for the event services provided by [dor-services-app](https://github.com/sul-dlss/dor-services-app).

Currently, the client only supports the asynchronous creation of events (via RabbitMQ). In the future, other operations
(including synchronous operations via HTTP) may be supported. At present, additional event operations are supported by
[dor-services-client](https://github.com/sul-dlss/dor-services-client).


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dor-event-client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dor-event-client

## Configuration

To configure and use the client, here's an example for a Rails app:

In `config/initializers/dor_event_client.rb`:
```ruby
Dor::Event::Client.configure(hostname: Settings.rabbitmq.hostname,
  vhost: Settings.rabbitmq.vhost,
  username: Settings.rabbitmq.username,
  password: Settings.rabbitmq.password)
```


## Operations

```ruby
# Create and list events for an object
Dor::Event::Client.create(druid:, type:, data:)

# For example:
Dor::Event::Client.create(
  druid: 'druid:bb408qn5061',
  type: 'druid_version_replicated',
  data {
      host: 'preservation-catalog-qa-02.stanford.edu',
      version: 19,
      invoked_by: 'preservation-catalog',
      parts_info: [
        {
          md5: '1a528419dea59d86cfd0c456e9f10024',
          size: 123630,
          s3_key: 'bb/408/qn/5061/bb408qn5061.v0019.zip'
        }
      ],
      endpoint_name: 'aws_s3_east_1'
    }:
  )
```

## Development

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sul-dlss/dor-event-client

## Copyright

Copyright (c) 2018 Stanford Libraries. See LICENSE for details.
