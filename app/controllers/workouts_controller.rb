class WorkoutsController < ApplicationController
  before_action :authenticate_user!

  def index
    @workouts = current_user.workouts
  end

  def show
    @workout = Workout.find(params[:id])
    not_user_redirect
    @exercises = Exercise.where(workout: params[:id])
  end

  def new
    @workout = Workout.new
  end

  def create
    @workout = Workout.new(workout_params)
    @workout.user = current_user
    if @workout.save
      flash[:success] = "Workout created! Add some excercises!"
      redirect_to workout_path(@workout)
    else
      flash[:notice] = @workout.errors.full_messages.join(". ")
      render :new
    end
  end

  def edit
    @workout = Workout.find(params[:id])
    not_user_redirect
  end

  def update
    @workout = Workout.find(params[:id])
    not_user_redirect
    if @workout.update_attributes(workout_params)
      flash[:success] = 'Changes saved successfully'
      redirect_to workout_path(@workout)
    else
      flash[:notice] = @workout.errors.full_messages.join(". ")
      render :edit
    end
  end

  def destroy
    @workout = Workout.find(params[:id]).destroy
    flash[:success] = "Deleted"
    redirect_to workouts_path
  end

  def not_user_redirect
    if @workout.user != current_user
      flash[:notice] = "Only workouts you created are viewable and/or editable"
      redirect_to workouts_path
    end
  end

  private

  def workout_params
    params.require(:workout).permit(:name, :description, :user)
  end
end
