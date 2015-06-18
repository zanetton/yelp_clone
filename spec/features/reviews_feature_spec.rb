require 'rails_helper'

feature 'reviewing' do

  before do
  user_sign_up('test@example.com')
  end

  scenario 'Allows users to leave a review using a form' do
    create_restaurant('KFC')
    visit '/restaurants'
    click_link 'Review KFC'
    leave_review('so so', '3')
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end

  scenario 'Only one review per restaurant per user'do
    create_restaurant('KFC')
    click_link 'Review KFC'
    leave_review('so so', '3')
    click_link 'Review KFC'
    leave_review('so so', '3')
    expect(page).to have_content 'You have already reviewed this restaurant'

  end



  scenario 'User can delete their review'do
    create_restaurant('KFC')
    click_link 'Review KFC'
    leave_review('so so', '3')
    click_link 'Delete Review'
    expect(page).not_to have_content 'so so'
    expect(page).to have_content 'You have successfully deleted your review'
  end
  scenario 'User cannot delete other review'do
    create_restaurant('KFC')
    click_link 'Review KFC'
    leave_review('so so', '3')
    click_link 'Sign out'
    user_sign_up('test3@example.com')
    visit '/restaurants'
    click_link 'Delete Review'
    expect(page).to have_content 'You can only delete your own reviews'
end
  scenario 'displays an average rating for all reviews' do
    create_restaurant('KFC')
    click_link 'Review KFC'
    leave_review('So so', '3')
    click_link 'Sign out'
    user_sign_up('test2@example.com')
    click_link 'Review KFC'
    leave_review('Great', '5')
    click_link 'Sign out'
    expect(page).to have_content('Average rating: 4')
  end
end
