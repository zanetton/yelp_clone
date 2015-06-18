class Restaurant < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  validates :name, length: {minimum: 3}, uniqueness: true
  belongs_to :user

def build_review (current_user, review_params)
  # byebug
    review = Review.new(review_params)
    review.user_id = current_user.id
    review.restaurant_id = self.id
    review
end

end
