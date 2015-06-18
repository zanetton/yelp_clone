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
      user_sign_up('test@example.com')
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
      create_restaurant('KFC')
      click_link('Sign out')
      user_sign_up('test2@example.com')
      expect(page).not_to have_link 'Edit KFC'
    end

    it 'Should not be able to delete a restaurant it did not create'do
      create_restaurant('KFC')
      click_link('Sign out')
      user_sign_up('test2@example.com')
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
