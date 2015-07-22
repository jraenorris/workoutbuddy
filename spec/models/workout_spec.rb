require 'rails_helper'

RSpec.describe Workout, type: :model do
  it { should have_valid(:name).when('Basic arm workout') }
  it { should have_valid(:description).when('This is the workout description') }
  it { should_not have_valid(:name).when('') }
  it { should_not have_valid(:name).when(nil) }
  it { should_not have_valid(:description).when('') }
  it { should_not have_valid(:description).when(nil) }

  describe "#visible_table?" do
    let(:workout) { FactoryGirl.create(:workout) }
    context "has exercises" do
      it 'returns empty string' do
        FactoryGirl.create(:exercise, workout: workout)
        expect(workout.visible_table?).to eq('')
      end
    end

    context "no exercises" do
      it 'returns hide' do
        expect(workout.visible_table?).to eq('hide')
      end
    end
  end
end
