require 'spec_helper'

describe Restaurant, type: :model do
  it { is_expected.to have_many :reviews }

  it 'has no reviews if deleted' do
    restaurant = Restaurant.create(name: 'KFC')
    review = restaurant.reviews.create(thoughts:'good', rating: '5')
    restaurant.destroy
    # expect{Review.find(review.id)}.to raise_error "Couldn't find Review with 'id'=#{review.id}"
    expect(Review.where(id: review.id)).not_to exist
  end

  it 'is not valid with a name of less than three characters' do
    restaurant = Restaurant.new(name: "KF")
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it "is not valid unless it has a unique name" do
  Restaurant.create(name: "Moe's Tavern")
  restaurant = Restaurant.new(name: "Moe's Tavern")
  expect(restaurant).to have(1).error_on(:name)
end

end
