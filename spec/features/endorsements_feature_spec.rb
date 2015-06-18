require 'rails_helper'

feature 'endorsing reviews' do
  before do
    user_sign_up('test@example.com')
    create_restaurant('KFC')
    click_link 'Review KFC'
    leave_review('It was an abomination', '3')
  end

  scenario 'a user can endorse a review, which updates the review endorsement count', js: true do
    visit '/restaurants'
    click_link 'Endorse KFC'
    expect(page).to have_content('1 endorsement')
  end

  scenario 'several users can endorse a review, which updates the review endorsement count', js: true do
    visit '/restaurants'
    click_link 'Endorse KFC'
    click_link 'Sign out'
    user_sign_up('test2@example.com')
    click_link 'Endorse KFC'
    click_link 'Sign out'
    user_sign_up('test3@example.com')
    click_link 'Endorse KFC'
    expect(page).to have_content('3 endorsements')
  end
end
