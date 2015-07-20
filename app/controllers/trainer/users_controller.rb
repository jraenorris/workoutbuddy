class Trainer::UsersController < ApplicationController
  before_action :authorize_trainer!

  def index
    @users = User.all.order(:fullname).page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @workouts = Workout.where(user: @user).page(params[:page]).per(10)
  end
end
