class CreateClassCommunications < ActiveRecord::Migration[6.0]
  def change
    create_table :class_communications do |t|
      t.date :class_communication_day, null: false
      t.string :title,   null: false
      t.text :diary,     null: false
      t.references :user, foreign_key: true 
      t.timestamps
    end
  end
end
