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

describe '#average_rating' do
  context 'no reviews' do
    it 'returns "N/A" when there are no reviews' do
      restaurant = Restaurant.create(name: 'The Ivy')
      expect(restaurant.average_rating).to eq 'N/A'
    end
  end
  context '1 review' do
  it 'returns that rating' do
    restaurant = Restaurant.create(name: 'The Ivy')
    restaurant.reviews.create(rating: 4)
    expect(restaurant.average_rating).to eq 4
  end
end

  context 'multiple reviews' do
    let(:user1){ User.create(email: 'test1@example.com', password: 'testtest')}
    let(:user2){ User.create(email: 'test2@example.com', password: 'test2test2')}

    it 'returns the average' do
      restaurant = Restaurant.create(name: 'The Ivy')
      restaurant.reviews.create(user: user1, rating: 1)
      restaurant.reviews.create(user: user2, rating: 5)
      expect(restaurant.average_rating).to eq 3
    end
  end
end
