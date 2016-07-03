RSpec.describe Yafac::OfferClient do
  let(:informed) { {pub0: 'x', uid: 'y', page: '1'} }
  let(:client) { Yafac::OfferClient.new(informed) }

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
      it 'returns an array of offers' do

      end
    end

    context 'when uid parameter is invalid' do
      it 'raises an error with the reason' do

      end
    end

    context 'when page parameter is invalid' do
      it 'raises an error with the reason' do

      end
    end
  end
end
