require 'spec_helper'

feature 'public and non public wikis' do

  scenario 'should be visible on the home page' do
    @u1 = create(:user) do |user|
      user.wikis.create(attributes_for(:wiki))
    end
   
    visit '/'
    expect(page).to have_content("First Wiki")
    click_link('First Wiki')
    expect(page).to have_content('This is the first post that Admin is writing.')
  end
  
  scenario 'should not be visible on the home page' do
    @u1 = create(:user) do |user|
      user.wikis.create(attributes_for(:wiki))
    end
    @u2 = create(:user) do |user|
      user.wikis.create(attributes_for(:wiki))
      user.wikis.first.update_attribute(:public, false)
    end
   
    visit '/'
    expect(page).to have_content("First Wiki")
    click_link('Wikis')
    page.should have_content('This is the first post that Admin is writing.')
    page.should have_content(@u1.user_name)
    page.should_not have_content(@u2.user_name)
  end

  scenario 'should be visible to creator on "My Wiki" page' do
    @u1 = create(:user) do |user|
      user.wikis.create(attributes_for(:wiki))
    end
    @u2 = create(:user) do |user|
      user.wikis.create(attributes_for(:wiki))
      user.wikis.first.update_attribute(:public, false)
      user.wikis.first.update_attribute(:title, "Non-public Wiki")
    end
     visit '/'
     expect(page).to have_content('Sign In')
     click_link "Sign In"
     expect(page).to have_content('Email')
     fill_in 'Email', with: @u2.email
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
    click_link 'Create Wiki'

  end
end
