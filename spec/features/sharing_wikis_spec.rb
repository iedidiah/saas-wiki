require 'spec_helper'

feature 'User who is paying' do
 
  scenario 'should be able to create a paid for account', :js => true do
    @u1 = create(:user)
    visit '/'
    expect(page).to have_content('Sign In')
    click_link "Sign In"
    expect(page).to have_content('Email')
    fill_in 'Email', with: @u1.email
    fill_in 'Password', with: "helloworld"
    click_button 'Sign in'
    click_link 'Private Wikis'
    click_button 'Pay with Card'
    within_frame('stripe_checkout_app') do
      expect(page).to have_content 'I want to create Private Wikis'
      fill_in 'Email', with: 'admin@example.com'
      fill_in 'Card number', with: '4242424242424242'
      fill_in 'MM / YY', with: '12/20'
      fill_in 'CVC', with: '123'
      save_and_open_page
      click_on 'Pay $5.00'
      find('.button.animated.success .tick').should be_visible
    end
      expect(page).to have_content 'You are now in the Wiki Private Club!'
  end

  scenario 'should not see the link Private Wikis' do
    @u1 = create(:user)
    @u1.update_attribute(:paid, true)
    visit '/'
    expect(page).to have_content('Sign In')
    click_link "Sign In"
    expect(page).to have_content('Email')
    fill_in 'Email', with: @u1.email
    fill_in 'Password', with: "helloworld"
    click_button 'Sign in'
    expect(page).to have_no_content('Private Wikis')
  end

  scenario 'should be able to create private Wikis but those that are not paying customers should not be able to create private Wikis' do
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
    expect(page).to have_no_content('Public')
  end

  scenario 'should be able to add collaborators to specific wikis' do 
    @u1 = create(:user) do |user|
      user.wikis.create(attributes_for(:wiki))
      user.wikis.first.update_attribute(:public, false)
      user.wikis.first.update_attribute(:title, "Non-public Wiki")
    end
    @u1.update_attribute(:paid, true)
    @u2 = create(:user)
    visit '/'
    expect(page).to have_content('Sign In')
    click_link "Sign In"
    expect(page).to have_content('Email')
    fill_in 'Email', with: @u1.email
    fill_in 'Password', with: "helloworld"
    click_button 'Sign in'
    expect(page).to have_content('My Wikis')
    click_link 'My Wikis' 
    expect(page).to have_content("Non-public Wiki")
    click_link "Edit"
    expect(page).to have_content("Add collaborators to this Wiki")
    fill_in "Collaborators", with: @u2.email
  end
end

