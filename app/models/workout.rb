class Workout < ActiveRecord::Base
  belongs_to :user
  has_many :exercises, dependent: :destroy

  validates :name, presence: true, length: { in: 4..50 }
  validates :description, presence: true, length: { in: 15..250 }
  validates :user, presence: true
end
