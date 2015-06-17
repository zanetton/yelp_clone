require 'spec_helper'

describe Restaurant, type: :model do
  it { is_expected.to have_many :reviews }

  it 'has no reviews if deleted' do
    restaurant = Restaurant.create(name: 'KFC')
    review = restaurant.reviews.create(thoughts:'good', rating: '5')
    restaurant.destroy
    expect{Review.find(review.id)}.to raise_error "Couldn't find Review with 'id'=#{review.id}"
  end
end
