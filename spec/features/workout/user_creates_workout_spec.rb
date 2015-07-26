require 'rails_helper'

feature 'user adds a new workout', %{
  As a user
  I want to visit the new workout page
  So I can create a new workout
} do

  # [x] I can navigate to the workout/new page
  # [x] I can create a new workout with a short description
  # [x] I am redirected to the workout show page w/ success message if valid
  # [x] I am given a failure message if invalid

  let!(:workout) { FactoryGirl.build(:workout) }
  let!(:user) { FactoryGirl.create(:user) }

  context 'user is signed in' do
    scenario 'authenticated user submits a new workout' do
      sign_in_as(user)
      visit new_workout_path

      fill_in('Name', with: workout.name)
      fill_in('Description', with: workout.description)

      click_button('Create Workout')

      expect(page).to have_content(workout.name)
    end

    scenario 'user submits an invalid workout' do
      sign_in_as(user)
      visit new_workout_path

      fill_in('Name', with: '')
      fill_in('Description', with: workout.description)

      click_button('Create Workout')

      expect(page).to have_content("Name can't be blank")
    end
  end

  context 'user is not signed in' do
    # unauthorized user
    scenario 'unauthenticated user cannot submit a new workout' do
      visit new_workout_path
      expect(page).to have_content("You need to sign in or sign up before")
    end
  end
end
