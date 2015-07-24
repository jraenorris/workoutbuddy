class CompletedsController < ApplicationController
  before_action :authenticate_user!

  def index
    @completeds = Completed.where(
      'user_id = ? and created_at > ?',
      current_user,
      30.days.ago
    )
    @workouts_for_bar = workout_frequency(current_user)
    @non_workouts = 30 - @workouts_for_bar
    @non_workouts = 30 - @workouts_for_bar
    @percent_done = (@workouts_for_bar * 100) / 30
  end

  def create
    @workout_id = Workout.find_by(id: params[:workout_id])
    @workout_name = params[:workout_name]
    @completed = Completed.new(
      workout: @workout_id,
      workout_name: @workout_name,
      user: current_user
    )
    if @completed.save
      flash[:success] = "Great job completing your workout!"
      redirect_to completeds_path
    else
      flash[:notice] = @completed.errors.full_messages.join(". ")
      render :new
    end
  end
end
