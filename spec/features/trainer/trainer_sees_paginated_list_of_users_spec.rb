require 'rails_helper'

feature 'trainer sees user list', %Q{
  As an authenticated trainer
  I want to see a list of users
  So I can find my trainees
} do
  # Acceptance Criteria
  # [x] I must be signed in with a trainer account
  # [x] I recieve an error if I try to view the page and am not a trainer
  # [x] Users should be a paginated list organized by their name

  let!(:trainer) { FactoryGirl.create(:user, role: 'trainer') }
  let!(:user_a) { FactoryGirl.create(:user, fullname: "Alonsy Alonso") }
  let!(:user_z) { FactoryGirl.create(:user, fullname: "Zenon girl of the..") }

  scenario 'authenticated trainer views user list' do
    25.times do
      FactoryGirl.create(:user)
    end

    sign_in_as(trainer)

    visit trainer_users_path

    expect(page).to have_content(user_a.fullname)
    expect(page).to_not have_content(user_z.fullname)
  end

  scenario 'user attempts to view user list' do
    sign_in_as(user_a)

    visit trainer_users_path

    expect(page).to have_content("Must be a trainer")
    expect(page).to_not have_content(user_z.fullname)
  end
end
