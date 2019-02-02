require 'rails_helper'
require 'spec_helper'


RSpec.feature "Auths", type: :feature do
  
  
  feature 'the signup process' do
    scenario 'has a new user page' do  
      visit new_user_path 
      expect(page).to have_content("Sign Up")
    end 
    
    feature 'signing up a user' do
      subject(:input_user) {User.new(username: "Tamir", password: "password") }

      before(:each) do 
        visit new_user_path 
        fill_in 'Password', with: input_user.password
        fill_in 'Username', with: input_user.username
        click_on("Sign Up") 
      end
      scenario 'shows username on the homepage after signup' do 
        expect(current_path).to eq(user_path(User.last))
        expect(page).to have_content(input_user.username)
      end
    end
  end 
  
  feature 'logging in' do
    

    subject(:input_user) {User.create(username: "Tamir", password: "password") }

    before(:each) do 
      visit new_session_path 
      fill_in 'Password', with: input_user.password
      fill_in 'Username', with: input_user.username
      click_on("Log In") 
      p [input_user.session_token]
    end

    scenario 'shows username on the homepage after login' do  

      expect(page).to have_content(input_user.username)
      expect(current_path).to eq(users_path)
    end
    
  end
  
  feature 'logging out' do
    before(:each) do  
      visit users_url 
    end

    scenario 'begins with a logged out state' do   
      expect(page).to have_content"Log In" 
    end
  
    scenario 'doesn\'t show username on the homepage after logout'
  
  end


end
