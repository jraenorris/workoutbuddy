class Completed < ActiveRecord::Base
  belongs_to :user
  belongs_to :workout

  validates :user, presence: true
  validates :workout, presence: true
  validates :workout_name, presence: true
end
