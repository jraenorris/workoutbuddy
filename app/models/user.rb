class User < ActiveRecord::Base
  has_many :workouts
  has_many :completeds

  validates :fullname, presence: true
  validates :fullname, length: { in: 3..30 }
  validates :fullname, uniqueness: true

  def trainer?
    role == 'trainer'
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
