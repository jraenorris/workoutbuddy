class SendworkoutController < ApplicationController
  def new
    @workout = Workout.new
    @users = User.all.map { |user| [user.fullname, user.id] }
  end
end
