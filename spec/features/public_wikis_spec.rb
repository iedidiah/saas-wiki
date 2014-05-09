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
end

