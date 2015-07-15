require 'rails_helper'

feature 'user adds an exercise', %{
  As an authenticated user
  I want to add a exercise for a workout
  So that I can see what I need to do for my Arm Workout day
} do

  # Acceptance Criteria
  # [] I must be signed in
  # [] If user is not signed in, user will be prompted to sign in
  # [] If a user tries to add to a workout that isn't there, an error will show
  # [] My exercise must include a type and intensity, like the example
  # [] When I submit my exercise, I can see it on the workout's detail page
  # [] I must be presented with errors if I leave an invalid exercise
  # [] If all is good, I get a successfully submitted message

  let(:user) { FactoryGirl.create(:user) }
  let!(:workout) { FactoryGirl.create(:workout, user: user) }
  let!(:user2) { FactoryGirl.create(:user) }

  context "user is signed in" do
    scenario 'user adds a valid exercise from workout detail page' do
      sign_in_as(user)
      visit workout_path(workout)

      within(".hide-for-small") do
        click_link "Add Exercises"
      end

      expect(page).to have_content("following this example")

      fill_in "Activity", with: "Sit ups for 30 seconds"
      fill_in "Intensity", with: "3 sets with 1 minute breaks"

      click_button 'Add to workout'

      expect(page).to have_content("Exercise added to #{workout.name}!")
      expect(page).to have_content("Sit ups for 30 seconds")
    end

    scenario 'user adds an invalid exercise' do
      sign_in_as(user)
      visit new_workout_exercise_path(workout)

      fill_in "Activity", with: "Sit ups for 30 seconds"

      click_button 'Add to workout'

      expect(page).to have_content("Intensity can't be blank")
      page.find_field('Activity').set("Sit upts for 30 seconds")
    end

    scenario 'user attempts to add to another persons workout' do
      sign_in_as(user2)
      visit new_workout_exercise_path(workout)

      expect(page).to have_content("Only workouts you created are viewable")
    end
  end

  context "user is not signed in" do
    scenario 'visitor tries to visit a show page' do
      visit visit new_workout_exercise_path(workout)
      expect(page).to have_content("Log in")
    end
  end
end
