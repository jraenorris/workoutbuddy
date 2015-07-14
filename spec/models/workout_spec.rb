require 'rails_helper'

RSpec.describe Workout, type: :model do
  it { should have_valid(:name).when('Basic arm workout') }
  it { should have_valid(:description).when('This is the workout description') }
  it { should_not have_valid(:name).when('') }
  it { should_not have_valid(:name).when(nil) }
  it { should_not have_valid(:description).when('') }
  it { should_not have_valid(:description).when(nil) }
end
