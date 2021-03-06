class ExercisesController < ApplicationController
  before_action :authenticate_user!

  def create
    not_user_redirect
    @workout = Workout.find(params[:workout_id])
    @exercise = Exercise.new(exercise_params)
    @exercise.workout = @workout
    respond_to do |format|
      if @exercise.save
        format.json { render json: @exercise }
      else
        format.json { render json: @exercise.errors.full_messages.join(". ") }
      end
    end
  end

  def edit
    not_user_redirect
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
      render :edit
    end
  end

  def destroy
    @exercise = Exercise.find(params[:id]).destroy
    flash[:success] = "Your exercise has been taken out of your workout"
    redirect_to edit_workout_path(params[:workout_id])
  end

  def not_user_redirect
    user = Workout.find(params[:workout_id]).user
    if user != current_user && current_user.role != 'trainer'
      flash[:notice] = "Only workouts you created are viewable and/or editable"
      redirect_to workouts_path
    end
  end

  private

  def exercise_params
    if params['exercise']
      params.require(:exercise).permit(:workout_id, :activity, :intensity)
    else
      param_hash = JSON.parse(params.keys[0])
      param_hash[:workout_id] = params[:workout_id]
      param_hash
    end
  end
end
