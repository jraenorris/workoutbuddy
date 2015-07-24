class Trainer::UsersController < ApplicationController
  before_action :authorize_trainer!

  def index
    @users = User.all.order(:fullname).page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @workouts = Workout.where(user: @user).page(params[:page]).per(10)
    @completeds = Completed.where(
      'user_id = ? and created_at > ?',
      @user,
      30.days.ago
    )
    @workouts_for_bar = workout_frequency(@user)
    @non_workouts = 30 - @workouts_for_bar
    @percent_done = (@workouts_for_bar * 100) / 30
  end
end
