class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.belongs_to :workout, null: false
      t.string :activity, null: false
      t.string :intensity, null: false
    end
  end
end
