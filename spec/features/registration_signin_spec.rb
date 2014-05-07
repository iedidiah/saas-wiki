require 'spec_helper'

feature 'flow for registration and signin process' do
   scenario 'New user registration' do
     visit '/'
     expect(page).to have_content('Sign Up')
     click_link "Sign Up"
     expect(page).to have_content('User name')
     fill_in 'User name', with: "Admin1"
     fill_in 'Email', with: "admin1@example.com"
     fill_in 'Password', with: "helloworld"
     fill_in 'Password confirmation', with: "helloworld"
     click_button "Sign up"
     expect(page).to have_content('A message with a confirmation link has been sent to your email address.')
   end


   scenario 'Existing use logging in to website' do
     @u = create(:user) 
     visit '/'
     expect(page).to have_content('Sign In')
     click_link "Sign In"
     expect(page).to have_content('Email')
     fill_in 'Email', with: @u.email
     fill_in 'Password', with: "helloworld"
     click_button 'Sign in'
     expect(page).to have_content('Welcome')
   end
end
