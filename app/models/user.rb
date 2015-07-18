class User < ActiveRecord::Base
  has_many :workouts

  validates :fullname, presence: true
  validates :fullname, length: { in: 3..30 }
  validates :fullname, uniqueness: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
