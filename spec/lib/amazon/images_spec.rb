require 'rails_helper'

RSpec.describe Amazon::Images do
  let(:first_image) do
    {
      high: 'https://images-na.ssl-images-amazon.com/images/I/71XaxP6VRgL.jpg',
      thumb: 'https://images-na.ssl-images-amazon.com/images/I/31Pral-j3cL.jpg'
    }
  end

  let(:second_image) do
    {
      high: 'https://images-na.ssl-images-amazon.com/images/I/71XaxP6VRgL.jpg',
      thumb: 'https://images-na.ssl-images-amazon.com/images/I/31Pral-j3cL.jpg'
    }
  end

  let(:html) do
    <<-EOS
      <script>
        var data = {
          'colorImages': {
            "initial":[
              { "hiRes":"#{first_image[:high]}", "thumb":"#{first_image[:thumb]}" },
              { "hiRes":"#{second_image[:high]}", "thumb":"#{second_image[:thumb]}" }
            ]
          }
        };
        return data;
      </script>
    EOS
  end
  let(:page) { Nokogiri.parse(html) }
  subject { described_class.new(page) }

  its(:value) { is_expected.to include(first_image[:high]) }
  its(:value) { is_expected.to_not include(first_image[:thumb]) }
  its(:value) { is_expected.to include(second_image[:high]) }
  its(:value) { is_expected.to_not include(second_image[:thumb]) }
end
