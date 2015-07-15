require 'rails_helper'

describe Exercise do
  let(:workout) { FactoryGirl.create(:workout) }

  describe "dependent destroy" do
    it "will delete exercises for that workout but not others" do
      exercise1 = FactoryGirl.create(:exercise, workout: workout)
      exercise2 = FactoryGirl.create(:exercise)

      workout.destroy

      exercise1.should_not exist_in_database
      exercise2.should exist_in_database
    end
  end
end
