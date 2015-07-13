# require 'rails_helper'
#
# feature 'user adds a new workout', %{
#   As a user
#   I want to visit the new workout page
#   So I can create a new workout
# } do
#
#   # [] - I can navigate to the workout/new page
#   # [] - I can create a new workout with a short description
#   # [] - I am redirected to the workout show page w/ success message if valid
#   # [] - I am given a failure message if invalid
#
#   let!(:workout) { FactoryGirl.build(:workout) }
#   let!(:user) { FactoryGirl.create(:user) }
#
#   context 'user is signed in' do
#     # valid test
#     scenario 'authenticated user submits a new workout' do
#       sign_in_as(user)
#       visit new_restaurant_path
#
#       fill_in('Name', with: workout.name)
#       fill_in('Address', with: workout.address)
#       fill_in('City', with: workout.city)
#       fill_in('State', with: workout.state)
#       fill_in('Zip', with: workout.zip_code)
#
#       click_button('Add Restaurant')
#
#       expect(page).to have_content(workout.name)
#
#     end
#
#     # invalid test
#     scenario 'user submits an invalid workout' do
#       sign_in_as(user)
#       visit new_restaurant_path
#
#       fill_in('Name', with: "")
#       fill_in('Address', with: workout.address)
#       fill_in('City', with: workout.city)
#       fill_in('State', with: workout.state)
#       fill_in('Zip', with: workout.zip_code)
#
#       click_button('Add Restaurant')
#
#       expect(page).to have_content("Name can't be blank")
#     end
#   end
#
#   context 'user is not signed in' do
#     # unauthorized user
#     scenario 'unauthenticated user cannot submit a new workout' do
#       visit new_restaurant_path
#       expect(page).to have_content("You need to sign in or sign up before")
#     end
#   end
# end
