require 'rails_helper'

feature 'trainer submits workout for user', %{
  As an authenticated trainer
  I want to create a workout for a user
  So they can have a new workout to accomplish
} do
  # Acceptance Criteria
  # [x] I must be signed in with a trainer account
  # [x] I must recieve errors if I submit invalid workout information
  # [x] I must be able to select which user the workout will be made for
  # [x] Creating a workout brings me to the edit page for that workout

  let!(:trainer) { FactoryGirl.create(:user, role: 'trainer') }
  let!(:user) { FactoryGirl.create(:user) }

  scenario 'trainer creates new workout for a user validly' do
    sign_in_as(trainer)

    visit new_sendworkout_path

    select(user.fullname, from: 'workout[user_id]')
    fill_in('Name', with: 'Custom workout for my Trainee')
    fill_in('Description', with: 'Do this twice a week on legs day')

    click_button('Create Workout')

    expect(page).to have_content('Workout created')
    expect(page).to have_content("Add to your workout")
  end

  scenario 'trainer creates new workout for a user invalidly' do
    sign_in_as(trainer)

    visit new_sendworkout_path

    select(user.fullname, from: 'workout[user_id]')
    fill_in('Description', with: 'Do this twice a week on legs day')

    click_button('Create Workout')

    expect(page).to have_content("Name can't be blank")
  end
end
