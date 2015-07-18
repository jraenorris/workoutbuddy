require 'rails_helper'

feature 'user updates their exercise', %{
  As an authenticated user
  I want to be able to changed my exercise
  To reflect a higher intensity
} do

  # Acceptance Criteria
  # [x] I must be signed in
  # [x] If I'm not signed in, I should be prompted to do so
  # [x] I can only edit my own exercises
  # [x] The Edit Exercise form is autofilled with my original exercise info
  # [x] I will see an error if I submit an invalid edit
  # [x] When I submit my changes, I can see them on the workout's detail page
  # [x] I get a successfully updated message

  let!(:user) { FactoryGirl.create(:user) }
  let!(:workout) { FactoryGirl.create(:workout, user: user) }
  let!(:exercise) { FactoryGirl.create(:exercise, workout: workout) }

  context "user is signed in" do
    scenario 'an authenticated user updates their exercise validly' do
      sign_in_as(user)

      visit edit_workout_path(workout)

      within(".exercises-table-edit-page") do
        find(".edit-icon").click
      end

      fill_in "exercise[intensity]", with: "More intense length"

      click_button "Update Exercise"

      expect(page).to have_content("More intense length")
      expect(page).to have_content('Your exercise has been updated')
    end

    scenario 'an authenticated user updates their exercise invalidly' do
      sign_in_as(user)

      visit edit_workout_path(workout)
      within(".exercises-table-edit-page") do
        find(".edit-icon").click
      end

      fill_in "exercise[intensity]", with: ""

      click_button "Update Exercise"

      expect(page).to have_content("Intensity can't be blank")
    end

    scenario "an authenticated user cannot update another user's exercise" do
      user2 = FactoryGirl.create(:user)
      sign_in_as(user2)

      visit edit_workout_path(workout)

      expect(page).to have_content("Only workouts you created are viewable")
    end
  end

  context "user is not signed in" do
    scenario "an unauthenticated user cannot update any exercises" do
      visit edit_workout_path(workout)

      expect(page).to have_content("Log in")
    end
  end
end
