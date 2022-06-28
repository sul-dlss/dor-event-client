# frozen_string_literal: true

RSpec.describe Dor::Event::Client::CreateOperation do
  subject(:operation) { described_class.new(channel: channel) }

  let(:channel) { instance_double(Dor::Event::Client::RabbitChannelFactory) }

  describe '#create' do
    let(:topic) { instance_double(Bunny::Exchange, publish: true) }
    let(:druid) { 'druid:1234' }
    let(:data) { { target: 'SearchWorks', host: 'foo.example.edu', result: 'success!' } }
    let(:msg) do
      '{"druid":"druid:1234","event_type":"publish","data":{"target":"SearchWorks","host":' \
        '"foo.example.edu","result":"success!"}}'
    end

    before do
      allow(channel).to receive(:topic).and_return(topic)
    end

    it 'sends message' do
      expect(operation.create(druid: druid, type: 'publish', data: data)).to be true
      expect(topic).to have_received(:publish).with(msg, routing_key: 'publish')
    end
  end
end
