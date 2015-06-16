require 'spec_helper'

describe Restaurant, type: :model do 
  it { is_expected.to have_many :reviews }

  it 'has no reviews if deleted' do
    restaurant = Restaurant.new
    restaurant.destroy
    expect(restaurant).not_to include :reviews
  end
end

