# frozen_string_literal: true

require 'active_support'
require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/object/json'
require 'active_support/json'
require 'bunny'
require 'singleton'
require 'zeitwerk'

loader = Zeitwerk::Loader.new
loader.inflector = Zeitwerk::GemInflector.new(__FILE__)
loader.push_dir(File.absolute_path("#{__FILE__}/../../.."))
loader.setup

module Dor
  module Event
    # Client for event services.
    class Client
      include Singleton

      # Base class for Dor::Event::Client exceptions
      class Error < StandardError; end

      delegate :create, to: :create_operation

      class << self
        def configure(hostname:, vhost:, username:, password:)
          instance.hostname = hostname
          instance.vhost = vhost
          instance.username = username
          instance.password = password

          # Force channel to be re-established when `.configure` is called
          instance.channel = nil

          self
        end

        delegate :create, to: :instance
      end

      attr_writer :hostname, :vhost, :username, :password, :channel

      private

      attr_reader :hostname, :vhost, :username, :password

      def channel
        @channel ||= RabbitChannelFactory.new(hostname: hostname, vhost: vhost, username: username, password: password)
      end

      def create_operation
        @create_operation ||= CreateOperation.new(channel: channel)
      end
    end
  end
end
