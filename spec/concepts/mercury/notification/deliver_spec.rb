# frozen_string_literal: true

RSpec.describe Mercury::Notification::Deliver do
  subject(:result) do
    described_class.call({
      notification: notification
    }, {
      'transports.map' => {
        'apns' => apn_transport
      }
    })
  end

  let(:notification) { build_stubbed(:notification, :apns) }

  let(:apn_transport) do
    Class.new do
      def self.call(_params); end
    end
  end

  let(:apn_result) { Trailblazer::Operation::Result.new(true, {}) }

  before { allow(apn_transport).to receive(:call).and_return(apn_result) }

  it 'calls the selected transports' do
    expect(apn_transport).to receive(:call)
      .with(notification: notification)
      .once
      .and_return(apn_result)

    result
  end

  context 'when all the transports succeed' do
    let(:apn_result) { Trailblazer::Operation::Result.new(true, {}) }

    it 'marks the result as success' do
      expect(result).to be_success
    end
  end

  context 'when one of the transports fails' do
    let(:apn_result) { Trailblazer::Operation::Result.new(false, {}) }

    it 'marks the result as failure' do
      expect(result).to be_failure
    end
  end
end
