# frozen_string_literal: true

RSpec.describe Dor::Event::Client do
  it 'has a version number' do
    expect(Dor::Event::Client::VERSION).not_to be_nil
  end

  describe '.create' do
    let(:create_operation) { instance_double(Dor::Event::Client::CreateOperation, create: true) }

    before do
      allow(Dor::Event::Client::CreateOperation).to receive(:new).and_return(create_operation)
    end

    it 'invokes CreateOperation' do
      expect(described_class.create(druid: 'druid:1234', type: 'test', data: {})).to be true
      expect(create_operation).to have_received(:create).with(druid: 'druid:1234', type: 'test', data: {})
    end
  end

  describe '#configure' do
    subject(:client) do
      described_class.configure(hostname: 'localhost', vhost: '/', username: 'guest', password: 'guest')
    end

    it 'returns Client class' do
      expect(client).to eq described_class
    end
  end
end
