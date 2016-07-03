
RSpec.describe Yafac::Main, :vcr do

  before(:all) { Timecop.freeze(Time.local(2016, 7, 3, 12, 0, 0)) }
  after(:all) { Timecop.return }

  describe 'GET /' do
    it 'renders no view, only the layout' do
      get '/'
      expect(last_response).to be_ok
    end
  end

  describe 'POST /offers' do
    let(:params) { {pub0: 'x', uid: 'player1', page: '1'} }

    context 'when additional parameter are sent' do
      it 'calls the client only with the permitted' do
        expect(Yafac::OfferClient).to receive(:new).with(params).and_call_original
        post '/offers', params.merge({another: 'param'})
      end
    end

    context 'when everything was ok with Fyber response' do
      before { post '/offers', params }

      it { expect(last_response).to be_ok }
      it { expect(last_response.body).to include('<h3>Results</h3>') }
    end

    context 'when an error occurred with Fyber' do
      before do
        params.delete(:uid)
        post '/offers', params
      end

      it { expect(last_response.body).to include('Fyber Response Code') }
    end

    context 'when the response signature mismatched' do
      before do
        allow_any_instance_of(Yafac::OfferClient).to receive(:get_offers).and_raise(Yafac::Errors::InvalidSignatureError)
        post '/offers', params
      end

      it { expect(last_response.body).to include('Please try again') }
    end
  end
end
