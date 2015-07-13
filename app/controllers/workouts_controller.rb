class WorkoutsController < ApplicationController
  before_action :authenticate_user!

  def index
    @workouts = Workout.all
  end

  def show
    @workout = Workout.find(params[:id])
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
  end

  def update
    @workout = Workout.find(params[:id])
    if @workout.update_attributes(workout_params)
      flash[:success] = 'Changes saved successfully'
      redirect_to workout_path(@workout)
    else
      flash[:notice] = @workout.errors.full_messages.join(". ")
      render :edit
    end
  end
  private

  def workout_params
    params.require(:workout).permit(:name, :description, :user)
  end
end
