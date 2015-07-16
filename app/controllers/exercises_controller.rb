class ExercisesController < ApplicationController
  before_action :authenticate_user!

  # def new
  #   not_user_redirect
  #   @exercise = Exercise.new
  #   @workout = Workout.find(params[:workout_id])
  # end

  def create
    not_user_redirect
    @workout = Workout.find(params[:workout_id])
    @exercise = Exercise.new(exercise_params)
    @exercise.workout = @workout
    @exercises = Exercise.where(workout: params[:id])
    if @exercise.save
      flash[:success] = "Exercise added to #{@workout.name}!"
      redirect_to workout_path(@workout)
    else
      flash[:notice] = @exercise.errors.full_messages.join(". ")
      render 'workouts/edit'
    end
  end

  def edit
    not_user_redirect
    @workout = Workout.find(params[:workout_id])
    @exercise = Exercise.find(params[:id])
  end

  def update
    not_user_redirect
    @exercise = Exercise.find(params[:id])
    if @exercise.update_attributes(exercise_params)
      flash[:success] = 'Your exercise has been updated'
      redirect_to workout_path(@exercise.workout)
    else
      flash[:notice] = @exercise.errors.full_messages.join(". ")
      @workout = Workout.find(params[:workout_id])
      @exercise = Exercise.find(params[:id])
      render :edit
    end
  end

  def destroy
    @exercise = Exercise.find(params[:id]).destroy
    flash[:success] = "Your exercise has been taken out of your workout"
    redirect_to workout_path(params[:workout_id])
  end

  def not_user_redirect
    if Workout.find(params[:workout_id]).user != current_user
      flash[:notice] = "Only workouts you created are viewable and/or editable"
      redirect_to workouts_path
    end
  end

  private

  def exercise_params
    params.require(:exercise).permit(:workout_id, :activity, :intensity)
  end
end
