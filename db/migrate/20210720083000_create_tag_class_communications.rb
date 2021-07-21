class CreateTagClassCommunications < ActiveRecord::Migration[6.0]
  def change
    create_table :tag_class_communications do |t|
      t.references :class_communication, foreign_key: true
      t.references :tag, foreign_key: true
      t.timestamps
    end
  end
end
