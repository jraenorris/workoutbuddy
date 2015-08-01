class CompletedsController < ApplicationController
  before_action :authenticate_user!

  def index
    @completeds = Completed.last_30_days_for(current_user)
    @workouts_for_bar = @completeds.count
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
