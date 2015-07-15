class ExercisesController < ApplicationController
  before_action :authenticate_user!

  def new
    not_user_redirect
    @exercise = Exercise.new
    @workout = Workout.find(params[:workout_id])
  end

  def create
    not_user_redirect
    @workout = Workout.find(params[:workout_id])
    @exercise = Exercise.new(exercise_params)
    @exercise.workout = @workout
    if @exercise.save
      flash[:success] = "Exercise added to #{@workout.name}!"
      redirect_to workout_path(@workout)
    else
      flash[:notice] = @exercise.errors.full_messages.join(". ")
      render :new
    end
  end

  def not_user_redirect
    if Workout.find(params[:workout_id]).user != current_user
      flash[:notice] = "Only workouts you created are viewable and/or editable"
      redirect_to workouts_path
    end
  end

  # def destroy
  #   @exercise = Exercise.find(params[:id]).destroy
  #   flash[:success] = "Your exercise has been taken out of your workout"
  #   redirect_to workout_path[:workout_id]
  # end

  private

  def exercise_params
    params.require(:exercise).permit(:workout_id, :activity, :intensity)
  end
end
