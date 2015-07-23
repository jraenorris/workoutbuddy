require 'rails_helper'

feature 'user recieves an email when a trainer sends them a workout', %{
  As a user
  I want to get an email when a workout is created for me
  So that I can go to the gym asap to complete it
} do

  # Acceptance Criteria
  # [x] Mailer deliveries count should equal 1 when a workout is created

  before :each do
    ActionMailer::Base.deliveries.clear
  end

  let!(:trainer) { FactoryGirl.create(:user, role: 'trainer') }
  let!(:user) { FactoryGirl.create(:user) }

  scenario "review a product" do
    sign_in_as(trainer)

    visit new_sendworkout_path

    select(user.fullname, from: 'workout[user_id]')
    fill_in('Name', with: 'Custom workout for my Trainee')
    fill_in('Description', with: 'Do this twice a week on legs day')

    click_button('Create Workout')

    expect(page).to have_content('Workout created')
    expect(ActionMailer::Base.deliveries.count).to eq(1)
  end
end
