require 'rails_helper'

feature "User can sign in and out" do
  context "user not signed in and on the homepage" do
    it "should see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
    end

    it "should not see 'sign out' link" do
      visit('/')
      expect(page).not_to have_link('Sign out')
    end
  end

  context "user signed in on the homepage" do
    before do
      visit('/')
      click_link('Sign up')
      fill_in('Email', with: 'test@example.com')
      fill_in('Password', with: 'testtest')
      fill_in('Password confirmation', with: 'testtest')
      click_button('Sign up')
    end


    it "should see 'sign out' link" do
      visit('/')
      expect(page).to have_link('Sign out')
    end

    it "should not see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).not_to have_link('Sign in')
      expect(page).not_to have_link('Sign up')
    end

    it 'Should not be able to edit a restaurant it did not create'do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with:'KFC'
      click_button 'Create Restaurant'
      click_link('Sign out')
      click_link('Sign up')
      fill_in('Email', with: 'test2@example.com')
      fill_in('Password', with: 'test2test2')
      fill_in('Password confirmation', with: 'test2test2')
      click_button('Sign up')
      expect(page).not_to have_link 'Edit KFC'
    end

    it 'Should not be able to delete a restaurant it did not create'do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with:'KFC'
      click_button 'Create Restaurant'
      click_link('Sign out')
      click_link('Sign up')
      fill_in('Email', with: 'test2@example.com')
      fill_in('Password', with: 'test2test2')
      fill_in('Password confirmation', with: 'test2test2')
      click_button('Sign up')
      expect(page).not_to have_link 'Delete KFC'
    end
  end



  context 'User is not signed in' do
    it 'should not be able to create a new restaurant'do
      visit('/')
      click_link 'Add a restaurant'
      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end
  end


end
