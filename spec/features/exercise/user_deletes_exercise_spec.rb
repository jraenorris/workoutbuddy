require 'rails_helper'

feature 'user deletes their exercise', %{
  As an authenticated user
  I want to be able to delete my exercise
  Because I no longer want that exercise in the workout
} do

  # [] I must be signed in
  # [] I can only delete my own reviews
  # [] I delete by clicking on the delete button in the workout edit page
  # [] I am prompted to confirm the deletion
  # [] I get a successfully deleted message
  # [] I no longer see my exercise on the workout edit page

  let!(:user) { FactoryGirl.create(:user) }
  let!(:workout) { FactoryGirl.create(:workout, user: user) }
  let!(:exercise) { FactoryGirl.create(:exercise, workout: workout) }
  let!(:user2) { FactoryGirl.create(:user) }

  context "user is signed in" do
    scenario 'an authenticated user wants to delete their exercise' do
      sign_in_as(user)

      visit edit_workout_path(workout)

      click_link "Delete exercise"

      expect(page).to_not have_content(exercise.activity)
      expect(page).to have_content(
        "Your exercise has been taken out of your workout"
      )
    end

    scenario "an authenticated user cannot delete another user's exercise" do
      sign_in_as(user2)

      visit edit_workout_path(workout)

      expect(page).to have_content("Only workouts you created are viewable")
    end
  end

  context "user is not signed in" do
    scenario "an unauthenticated user cannot delete any reviews" do
      visit edit_workout_path(workout)

      expect(page).to have_content("Log in")
    end
  end
end
