require 'rails_helper'

feature 'user signs out', %{
  As an authenticated user
  I want to sign out
  So that my identity is forgotten about on the machine I'm using
} do

  # Acceptance Criteria
  # [x] If I'm signed in, i have an option to sign out
  # [x] When I opt to sign out, I get a confirmation that my identity has been
  #   forgotten on the machine I'm using

  scenario 'authenticated user signs out' do
    user = FactoryGirl.create(:user)

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Log in'

    expect(page).to have_content('Signed in successfully')

    within(".top-bar-section") do
      click_link "Sign Out"
    end
    expect(page).to have_content('Signed out successfully')
  end

  scenario 'unauthenticated user attempts to sign out' do
    visit '/'
    expect(page).to_not have_content('Sign Out')
  end
end
