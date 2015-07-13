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

  private

  def workout_params
    params.require(:workout).permit(:name, :description, :user)
  end
end
