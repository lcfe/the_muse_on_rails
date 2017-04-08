require 'rails_helper'

describe Jobs::ApiRequester do
  describe '#send_request' do
    let(:url) do
      'http://some.fake.url'
    end
    let(:uri) do
      instance_double 'URI'
    end
    let(:response) do
      instance_double 'Net::HTTPResponse'
    end

    before do
      allow(subject).to receive(:URI).with(url) { uri }
      allow(Net::HTTP).to receive(:get_response).with(uri) { response }
    end

    it 'sends a get request to the url' do
      subject.send_request(url)
      expect(Net::HTTP).to have_received(:get_response).with(uri)
    end
    it 'returns the response object' do
      expect(subject.send_request(url)).to eql(response)
    end
  end
end
