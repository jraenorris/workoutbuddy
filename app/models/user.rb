class User < ActiveRecord::Base
  has_many :workouts

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
