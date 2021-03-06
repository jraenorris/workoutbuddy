class Workout < ActiveRecord::Base
  belongs_to :user
  has_many :exercises, dependent: :destroy
  has_many :completeds

  validates :name, presence: true, length: { in: 4..50 }
  validates :description, presence: true, length: { in: 15..250 }
  validates :user, presence: true

  def visible_table?
    if exercises.any?
      ''
    else
      'hide'
    end
  end
end
