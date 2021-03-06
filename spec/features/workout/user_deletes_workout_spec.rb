require 'rails_helper'

feature 'user deletes a workout they created', %{
  As a user
  I want to delete a workout
  Because I have created a better arm workout to replace it
} do

  # Acceptance Criteria
  # [x] User can see delete link for their workout
  # [x] User cannot see delete link for a workout that isnt't theirs
  # [x] User can click on delete link and workout will no longer be indexed

  let(:user) { FactoryGirl.create(:user) }
  let!(:workout) { FactoryGirl.create(:workout, user_id: user.id) }
  let(:user2) { FactoryGirl.create(:user) }

  context "authenticated as a user" do
    scenario 'user deletes their workout' do
      sign_in_as(user)

      visit workouts_path

      click_link workout.name
      within(".top-bar-section .hide-for-small") do
        click_link "Delete"
      end

      expect(page).to have_content("Deleted")
      expect(page).to_not have_content(workout.name)
    end

    scenario 'user cannot delete a workout they did not create' do
      sign_in_as(user2)

      visit workout_path(workout)

      expect(page).to have_content("Only workouts you created are viewable")
      expect(page).to_not have_content("Delete")
    end
  end

  context "unauthenticated as a user" do
    scenario 'user deletes a workout' do
      visit workout_path(workout)

      expect(page).to_not have_content("Delete Workout")
    end
  end
end
