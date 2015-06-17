require 'spec_helper'

describe Restaurant, type: :model do 
  it { is_expected.to have_many :reviews }

  it 'has no reviews if deleted' do
    restaurant = Restaurant.create(name: 'KFC')
    Review.create(thoughts: 'Good', rating: 5, restaurant_id: restaurant.id)
    expect { restaurant.destroy}.to change {Review.count}.by(-1)
  end
end

