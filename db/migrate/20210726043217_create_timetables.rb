class CreateTimetables < ActiveRecord::Migration[6.0]
  def change
    create_table :timetables do |t|
      t.date :next_day,  null: false
      t.integer :first_hour,  null: false
      t.integer :second_hour, null: false
      t.integer :third_hour, null: false
      t.integer :fourth_hour, null: false
      t.integer :fifth_hour, null: false
      t.integer :sixth_hour, null: false
      t.string  :homework, null: false
      t.string :preparation, null: false       
      t.string :leave_time, null: false       
      t.text :notice    
      t.references  :user, foreign_key: true
      
      t.timestamps
    end
  end
end
