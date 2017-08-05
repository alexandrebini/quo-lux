require 'rails_helper'

RSpec.describe Amazon::Title do
  let(:html) do
    <<-EOS
      <span id='productTitle'>
        Louisville Slugger Genuine Series 3X Ash Mixed Baseball Bat
      </span>
    EOS
  end
  let(:page) { Nokogiri.parse(html) }
  subject { described_class.new(page) }

  its(:value) { is_expected.to eql('Louisville Slugger Genuine Series 3X Ash Mixed Baseball Bat') }
end
