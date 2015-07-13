require 'rails_helper'

feature 'user edits details of a created workout', %{
  As an authenticated user
  I want to update a workout
  So that I can update the description to be more accurate
} do

  # Acceptance Criteria
  # [] Authenticated user can go to show page and see edit button
  # [] Authenticated user that was not the creator cannot see edit button
  # [] Unauthenticate user can go to show page but not see edit button
  # [] User can validly edit the workout information and get a success flash
  # [] If user submits invalid information they are given errors

  let!(:user) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user, id: (user.id + 1)) }
  let!(:workout) { FactoryGirl.create(:workout, user_id: user.id) }

  context "authenticated user" do
    scenario "user updates their workout information" do
      sign_in_as(user)

      visit workout_path(workout)

      click_link "Edit Workout"

      fill_in "Description", with: "This workout has been replaced by Workout 3"

      click_button "Submit Changes"

      expect(page).to have_content("This workout has been replaced by ")
      expect(page).to have_content("Changes saved successfully")
    end

    scenario "user invalidly tries to update their workout information" do
      sign_in_as(user)

      visit workout_path(workout)

      click_link "Edit Workout"

      fill_in "Name", with: ""

      click_button "Submit Changes"

      expect(page).to have_content("Name can't be blank")
    end

    scenario "user tries to update a workout they didn't create" do
      sign_in_as(user2)

      visit workout_path(workout)

      expect(page).to_not have_content("Edit Workout")
    end
  end

  context "unauthenticated user" do
    scenario "user navigates to edit page " do
      visit workout_path(workout)

      expect(page).to_not have_content("Edit Workout")
    end
  end
end
