class CreateDiaries < ActiveRecord::Migration[6.0]
  def change
    create_table :diaries do |t|
      t.date :diary_day, null: false
      t.string :title,   null: false
      t.text :diary, null: false  
      t.references :user, foreign_key: true 
      t.timestamps
    end
  end
end
