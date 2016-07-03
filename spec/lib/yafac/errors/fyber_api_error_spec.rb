
RSpec.describe Yafac::Errors::FyberApiError do

  describe '#to_s' do
    let(:error) { Yafac::Errors::FyberApiError.new('400', 'INVALID_UID', 'invalid uid informed') }
    let(:expected) { "Fyber API Error: http_status=400, reason=INVALID_UID, message=invalid uid informed" }

    it 'builds a readable information of the error' do
      expect(error.to_s).to eq expected
    end
  end
end
