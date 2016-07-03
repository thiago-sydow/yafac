
RSpec.describe Yafac::Models::Offer do

  describe '#initialize' do
    let(:attributes) {
      {
        "title" => "Tap  Fish",
        "thumbnail" => {
         "lowres" => "low_res_img",
         "hires" => "high_res_img"
        },
        "payout" => 90,
      }
    }

    context 'when all attributes are present' do
      let(:offer) { Yafac::Models::Offer.new(attributes) }

      it { expect(offer.title).to eq attributes['title'] }
      it { expect(offer.thumbnail).to eq attributes['thumbnail']['lowres'] }
      it { expect(offer.payout).to eq attributes['payout'] }
    end

    context 'when title is missing' do
      let(:offer) { Yafac::Models::Offer.new(attributes) }

      before { attributes.delete('title') }

      it { expect(offer.title).to eq '' }
      it { expect(offer.thumbnail).to eq attributes['thumbnail']['lowres'] }
      it { expect(offer.payout).to eq attributes['payout'] }
    end

    context 'when payout is missing' do
      let(:offer) { Yafac::Models::Offer.new(attributes) }

      before { attributes.delete('payout') }

      it { expect(offer.title).to eq attributes['title'] }
      it { expect(offer.thumbnail).to eq attributes['thumbnail']['lowres'] }
      it { expect(offer.payout).to eq '' }
    end

    context 'when thumbnail lowres key is missing' do
      let(:offer) { Yafac::Models::Offer.new(attributes) }

      before { attributes['thumbnail'].delete('lowres') }

      it { expect(offer.title).to eq attributes['title'] }
      it { expect(offer.thumbnail).to eq '' }
      it { expect(offer.payout).to eq attributes['payout'] }
    end

    context 'when thumbnail key is missing' do
      let(:offer) { Yafac::Models::Offer.new(attributes) }

      before { attributes.delete('thumbnail') }

      it { expect(offer.title).to eq attributes['title'] }
      it { expect(offer.thumbnail).to eq '' }
      it { expect(offer.payout).to eq attributes['payout'] }
    end
  end

end
