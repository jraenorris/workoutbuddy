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
    @workout.user ||= current_user
    if @workout.save
      if current_user.role = "trainer"
        WorkoutMailer.new_workout(@workout).deliver_later
      end
      flash[:success] = "Workout created! Add some excercises!"
      redirect_to edit_workout_path(@workout)
    else
      flash[:notice] = @workout.errors.full_messages.join(". ")
      if @workout.user == current_user
        render :new
      else
        @users = User.all.map { |user| [user.fullname, user.id] }
        render 'sendworkout/new'
      end
    end
  end

  def edit
    @workout = Workout.find(params[:id])
    not_user_redirect
    @exercise = Exercise.new
  end

  def update
    @workout = Workout.find(params[:id])
    not_user_redirect
    if @workout.update_attributes(workout_params)
      flash[:success] = 'Changes saved successfully'
      redirect_to edit_workout_path(@workout)
    else
      flash[:notice] = @workout.errors.full_messages.join(". ")
      @exercise = Exercise.new
      @exercises = Exercise.where(workout: params[:id])
      render :edit
    end
  end

  def destroy
    @workout = Workout.find(params[:id]).destroy
    flash[:success] = "Deleted"
    redirect_to workouts_path
  end

  def not_user_redirect
    if @workout.user != current_user && current_user.role != 'trainer'
      flash[:notice] = "Only workouts you created are viewable and/or editable"
      redirect_to workouts_path
    end
  end

  private

  def workout_params
    params.require(:workout).permit(:name, :description, :user, :user_id)
  end
end
