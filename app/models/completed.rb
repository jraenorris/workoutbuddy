class Completed < ActiveRecord::Base
  belongs_to :user
  belongs_to :workout

  validates :user, presence: true
  validates :workout, presence: true
  validates :workout_name, presence: true

  def self.last_30_days_for(user)
    where('user_id = ? and created_at > ?', user, 30.days.ago)
  end
end
