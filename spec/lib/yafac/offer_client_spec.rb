RSpec.describe Yafac::OfferClient do

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

end
