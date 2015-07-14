require 'rails_helper'

feature 'user edits details of a created workout', %{
  As an authenticated user
  I want to update a workout
  So that I can update the description to be more accurate
} do

  # Acceptance Criteria
  # [x] Authenticated user can go to show page and see edit button
  # [x] Authenticated user that was not the creator cannot see edit button
  # [x] Unauthenticate user can go to show page but not see edit button
  # [x] User can validly edit the workout information and get a success flash
  # [x] If user submits invalid information they are given errors

  let!(:user) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user) }
  let!(:workout) { FactoryGirl.create(:workout, user_id: user.id) }

  context "authenticated user" do
    scenario "user updates their workout information" do
      sign_in_as(user)

      visit workout_path(workout)

      within(".hide-for-small") do
        click_link "Edit"
      end

      fill_in "Description", with: "This workout has been replaced by Workout 3"

      click_button "Submit Changes"

      expect(page).to have_content("This workout has been replaced by ")
      expect(page).to have_content("Changes saved successfully")
    end

    scenario "user invalidly tries to update their workout information" do
      sign_in_as(user)

      visit workout_path(workout)

      within(".hide-for-small") do
        click_link "Edit"
      end

      fill_in "Name", with: ""

      click_button "Submit Changes"

      expect(page).to have_content("Name can't be blank")
    end
  end

  context "authenticated user tries to update workout they didn't create" do
    scenario "user cannot see show page to edit" do
      sign_in_as(user2)

      visit workout_path(workout)

      expect(page).to have_content("Only workouts you created are viewable")
      expect(page).to_not have_content("Edit")
    end

    scenario "user cannot see edit page" do
      sign_in_as(user2)

      visit edit_workout_path(workout)

      expect(page).to have_content("Only workouts you created are viewable")
      expect(page).to_not have_content("Edit")
    end
  end

  context "unauthenticated user" do
    scenario "user navigates to edit page " do
      visit workout_path(workout)

      expect(page).to_not have_content("Edit")
    end
  end
end
