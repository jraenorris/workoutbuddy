# require 'rails_helper'
#
# feature 'trainer sees user list', %Q{
#   As an authenticated trainer
#   I want to see a list of users
#   So I can find my trainees
# } do
#   # Acceptance Criteria
#   # [] I must be signed in with a trainer account
#   # [] I recieve an error if I try to view the page and am not signed in
#   # [] Trainees should be a paginated list organized by their name
#
#   let!(:trainer) { FactoryGirl.create(:user, role: 'trainer') }
#   let!(:user_a) { FactoryGirl.create(:user, name: "Alonso")}
#   let!(:user_z) { FactoryGirl.create(:user, name: "Zenon")}
#
#
#   scenario 'authenticated trainer views user list' do
#     25.times do
#       FactoryGirl.create(:user)
#     end
#
#     sign_in_as(trainer)
#
#     visit '/admin/users'
#
#     expect(page).to have_content(user_a.name)
#     expect(page).to_not have_content(user_z.name)
#   end
#
#   # scenario 'user attempts to view user list' do
#   #   sign_in_as(trainer)
#   #
#   #   visit users_path
#   #
#   #   expect(page).to have_content("Must be a trainer")
#   #   expect(page).to_not have_content(user_z.name)
#   # end
# end
