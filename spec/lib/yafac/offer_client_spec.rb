
RSpec.describe Yafac::OfferClient, :vcr do
  let(:informed) { {pub0: 'x', uid: 'player1', page: '1'} }
  let(:client) { Yafac::OfferClient.new(informed) }

  before(:all) { Timecop.freeze(Time.utc(2016, 7, 3, 12, 0, 0)) }
  after(:all) { Timecop.return }

  describe '#initialize' do
    it 'merges the informed attributes into params' do
      expect(client.instance_variable_get(:@params)).to include(informed)
    end

    it 'adds a timestamp key to params' do
      expect(client.instance_variable_get(:@params)).to include(:timestamp)
    end
  end

  describe '#get_offers' do
    context 'when all parameters are valid' do
      context 'and there are offers to show' do
        it 'returns an array of offers' do
          expect(client.get_offers).to all( be_an(Yafac::Models::Offer) )
        end
      end

      context 'and there are no offers to show' do
        before { allow(JSON).to receive(:parse).and_return({ 'code' => 'NO_CONTENT', 'offers' => [] }) }

        it 'returns an array of offers' do
          expect(client.get_offers).to be_empty
        end
      end
    end

    context 'when uid parameter is invalid' do
      before { informed.delete(:uid) }

      it 'raises an error with the ERROR_INVALID_UID reason' do
        expect { client.get_offers }.to raise_error do |error|
          expect(error).to be_a(Yafac::Errors::FyberApiError)
          expect(error.reason).to eq 'ERROR_INVALID_UID'
        end
      end
    end

    context 'when page parameter is invalid' do
      before { informed[:page] = '-1' }

      it 'raises an error with the reason' do
        expect { client.get_offers }.to raise_error do |error|
          expect(error).to be_a(Yafac::Errors::FyberApiError)
          expect(error.reason).to eq 'ERROR_INVALID_PAGE'
        end
      end
    end
  end

  describe '#hash_key' do
    it 'calculates the hash correctly' do
      expect(client.hash_key).to eq '8deb5eddbf4ecc0291adaa7736430f99fee12c01'
    end
  end

  describe '#valid_signature?' do
    let(:response) { double(HTTParty::Response) }

    context 'with a valid response and signature' do
      before do
        allow(response).to receive(:body).and_return('{"test": 1}')
        allow(response).to receive(:headers).and_return({'X-Sponsorpay-Response-Signature' => '3cd5eb34f7b53d998e95fd24059275d1b06c6301'})
      end

      it 'validates the response' do
        expect(client.valid_signature?(response)).to be_truthy
      end
    end

    context 'with a valid response and invalid signature' do
      before do
        allow(response).to receive(:body).and_return('{"test": 1}')
        allow(response).to receive(:headers).and_return({'X-Sponsorpay-Response-Signature' => '3Dd5eb34f7b53d998e95fd24059275d1b06c6301'})
      end

      it 'validates the response' do
        expect(client.valid_signature?(response)).to be_falsey
      end
    end

    context 'with a invalid response and signature' do
      before do
        allow(response).to receive(:body).and_return('{"test": 1, "malicious": true}')
        allow(response).to receive(:headers).and_return({'X-Sponsorpay-Response-Signature' => '3cd5eb34f7b53d998e95fd24059275d1b06c6301'})
      end

      it 'validates the response' do
        expect(client.valid_signature?(response)).to be_falsey
      end
    end

  end
end
