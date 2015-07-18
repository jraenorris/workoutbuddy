require 'rails_helper'

feature 'trainer sees user list', %Q{
  As an authenticated trainer
  I want to see a list of users
  So I can find my trainees
} do
  # Acceptance Criteria
  # [] I must be signed in with a trainer account
  # [] I recieve an error if I try to view the page and am not signed in
  # [] Details page should have workout names & descriptions, paginated

  let!(:trainer) { FactoryGirl.create(:user, role: 'trainer') }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:workout) { FactoryGirl.create(:workout, user: user) }

  scenario 'trainer clicks on users name and sees their details' do
    10.times do
      FactoryGirl.create(:workout, user: user)
    end

    FactoryGirl.create(:workout, user: user, name: "should not be on page")

    sign_in_as(trainer)

    visit trainer_users_path

    click_link user.fullname

    expect(page).to have_content(workout.name)
    expect(page).to_not have_content('should not be on page')
  end

  scenario 'user attempts to view user details' do
    sign_in_as(user)

    visit trainer_user_path(user)

    expect(page).to have_content("Must be a trainer")
  end
end
