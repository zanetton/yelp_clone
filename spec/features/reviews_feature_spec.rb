require 'rails_helper'

feature 'reviewing' do

  before do
    visit('/')
    click_link('Sign up')
    fill_in('Email', with: 'test@example.com')
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button('Sign up')
  end

  scenario 'Allows users to leave a review using a form' do
    Restaurant.create name: 'KFC'
    visit '/restaurants'

    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'

    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end

  scenario 'Only one review per restaurant per user'do
    visit '/restaurants'
    click_link 'Add a restaurant'
    fill_in 'Name', with:'KFC'
    click_button 'Create Restaurant'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'
    expect(page).to have_content 'You have already reviewed this restaurant'

  end



  scenario 'User can delete their review'do
  # byebug
    visit '/restaurants'
    click_link 'Add a restaurant'
    fill_in 'Name', with:'KFC'
    click_button 'Create Restaurant'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'
    click_link 'Delete Review'
    p Restaurant.all
    p Review.all
    expect(page).not_to have_content 'so so'
    expect(Restaurant.count).to eq 1
    expect(page).to have_content 'You have successfully deleted your review'
  end
  scenario 'User cannot delete other review'do
    visit '/restaurants'
    click_link 'Add a restaurant'
    fill_in 'Name', with:'KFC'
    click_button 'Create Restaurant'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'
    click_link 'Sign out'
    click_link('Sign up')
    fill_in('Email', with: 'test3@example.com')
    fill_in('Password', with: 'test3test3')
    fill_in('Password confirmation', with: 'test3test3')
    click_button('Sign up')
    visit '/restaurants'
    click_link 'Delete Review'
    expect(page).to have_content 'You can only delete your own reviews'
end
end
