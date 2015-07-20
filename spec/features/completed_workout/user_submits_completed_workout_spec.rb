require 'rails_helper'

feature 'user submits completed workout', %Q{
  As a user
  I want to submit when I complete a workout
  So that my trainer and I can track my progress
} do

  # Acceptance Criteria:
  #  [] I can click a button when I complete an exercise on the show page
  #  [] Once clicked, I can go to my completed workouts index page and see all
  #  the workouts I've completed in the past 30 days
  #  [] My trainer can also see the workouts I've completed on my show page
  #  [] Only myself and my trainer can see my completed workouts

  let!(:user) { FactoryGirl.create(:user) }
  let!(:trainer) { FactoryGirl.create(:user, role: 'trainer') }
  let!(:workout) { FactoryGirl.create(:workout, user: user) }

  scenario 'user clicks completed button and sees workout on completed#index' do
    sign_in_as(user)

    visit workout_path(workout)

    find('.submit-exercise').find('.submit-completed').click

    expect(page).to have_content('Completed Workouts')
    expect(page).to have_content(workout.name)
  end

  scenario 'trainer can see completed workout on user show page' do
    completed = Completed.create(user_id: user.id, workout_id: workout.id, workout_name: "test name")

    sign_in_as(trainer)

    visit trainer_user_path(user)

    expect(page).to have_content("test name")
  end
end
