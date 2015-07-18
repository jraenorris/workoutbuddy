class Trainer::UsersController < ApplicationController
  before_action :authorize_trainer!

  def index
    @users = User.all.order(:fullname).page(params[:page])
  end
end
