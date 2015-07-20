class CreateCompletedsTable < ActiveRecord::Migration
  def change
    create_table :completeds do |t|
      t.belongs_to :user, null: false
      t.belongs_to :workout, null: false
      t.string :workout_name, null: false
      
      t.timestamps null: false
    end
  end
end
