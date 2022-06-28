# frozen_string_literal: true

module Dor
  module Event
    class Client
      # Create an Event
      class CreateOperation
        def initialize(channel:)
          @channel = channel
        end

        # @param druid [String] object identifier
        # @param type [String] a type for the event, e.g., publish, shelve
        # @param data [Hash] an unstructured hash of event data
        # @return [Boolean] true if successful
        def create(druid:, type:, data:)
          message = { druid: druid, event_type: type, data: data }
          channel.topic('sdr.objects.event').publish(message.to_json, routing_key: type)

          true
        end

        private

        attr_reader :channel
      end
    end
  end
end
