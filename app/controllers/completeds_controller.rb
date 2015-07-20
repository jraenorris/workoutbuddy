class CompletedsController < ApplicationController

  def index
    @completeds = Completed.where(user: current_user).where('created_at > ?', 30.days.ago)
  end

  def create
    @workout_id = Workout.find_by(id: params[:workout_id])
    @workout_name = params[:workout_name]
    @completed = Completed.new(workout: @workout_id, workout_name: @workout_name, user: current_user)
    if @completed.save
      flash[:success] = "Great job completing your workout!"
      redirect_to completeds_path
    else
      flash[:notice] = @completed.errors.full_messages.join(". ")
      render :new
    end
  end
end
