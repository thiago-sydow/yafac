
RSpec.describe Yafac::OfferClient, :vcr do

  describe '#initialize' do
    let(:informed) { {pub0: 'x', uid: 'y', page: '1'} }
    let(:client) { Yafac::OfferClient.new(informed) }

    it 'merges the informed attributes into params' do
      expect(client.instance_variable_get(:@params)).to include(informed)
    end

    it 'adds a timestamp key to params' do
      expect(client.instance_variable_get(:@params)).to include(:timestamp)
    end
  end

  describe '#get_offers' do
    let(:informed) { {pub0: 'x', uid: 'y', page: '1'} }
    let(:client) { Yafac::OfferClient.new(informed) }

    context 'when all parameters are valid' do
      context 'and there are offers to show' do
        it 'returns an array of offers' do
          expect(client.get_offers).to all( be_an(Yafac::Models::Offer) )
        end
      end

      context 'and there are offers to show' do
        before { allow(JSON).to receive(:parse).and_return({ 'offers' => [] }) }

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
      before { informed[:page] = 'x' }

      xit 'raises an error with the reason' do
        expect { client.get_offers }.to raise_error do |error|
          expect(error).to be_a(Yafac::Errors::FyberApiError)
          expect(error.reason).to eq 'ERROR_INVALID_PAGE'
        end
      end
    end
  end
end
