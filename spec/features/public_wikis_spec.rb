require 'spec_helper'

feature 'Wikis' do

  scenario 'that are public should be visible on the home page' do
    @u1 = create(:user)
    @wiki = create(:wiki, creator: @u1, title: "First Wiki")
    visit '/'
    expect(page).to have_content("First Wiki")
    click_link('First Wiki')
    expect(page).to have_content('This is the first post that Admin is writing.')
  end
  
  scenario 'that are not public should not be visible on the home page' do
    @u2 = create(:user)
    @wiki = create(:wiki, creator: @u2, title: "Not Public", public: false) 
    visit '/'
    expect(page).to_not have_content("Not Public")
  end

  scenario 'should be visible to creator on "My Wiki" page' do
    @u1 = create(:user)
    @wiki = create(:wiki, creator: @u1, title: "Non-public Wiki", public: false)
     visit '/'
     expect(page).to have_content('Sign In')
     click_link "Sign In"
     expect(page).to have_content('Email')
     fill_in 'Email', with: @u1.email
     fill_in 'Password', with: "helloworld"
     click_button 'Sign in'
     click_link'My Wikis' 
     expect(page).to have_content("Non-public Wiki")
  end

  scenario 'should be able to be created in signed in user "My Wikis" page' do
    @u1 = create(:user)
    visit '/'
    expect(page).to have_content('Sign In')
    click_link "Sign In"
    expect(page).to have_content('Email')
    fill_in 'Email', with: @u1.email
    fill_in 'Password', with: "helloworld"
    click_button 'Sign in'
    click_link'My Wikis' 
    click_button 'Create a new Wiki'
    fill_in 'Title', with: "Testing New Wiki"
    fill_in 'Body', with: "This is my first wiki created through form. It will be public"
    click_button 'Create Wiki'
    expect(page).to have_content ('Your new Wiki has been created.')
    expect(page).to have_content ('Testing New Wiki')
  end
  scenario 'should be editable by it\'s creator.' do
    @u1 = create(:user, paid: true)
    @wiki = create(:wiki, creator: @u1, title: "First Wiki")
    visit'/'
    expect(page).to have_content('Sign In')
    click_link "Sign In"
    expect(page).to have_content('Email')
    fill_in 'Email', with: @u1.email
    fill_in 'Password', with: "helloworld"
    click_button 'Sign in'
    click_link 'My Wikis' 
    click_link 'Edit' 
  #  check 'Public'
    click_button 'Update Wiki'
    expect(page).to have_content('You have updated a Wiki')
  end

end
