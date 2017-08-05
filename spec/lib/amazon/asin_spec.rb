require 'rails_helper'

RSpec.describe Amazon::Asin do
  let(:page) { Nokogiri.parse("<input type='hidden' id='ASIN' name='ASIN' value='B012CS70R8'>") }
  subject { described_class.new(page) }

  its(:value) { is_expected.to eql('B012CS70R8') }
end
