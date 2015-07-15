class Exercise < ActiveRecord::Base
  belongs_to :workout

  validates :activity, presence: true, length: { in: 5..50 }
  validates :intensity, presence: true, length: { in: 2..50 }
end
