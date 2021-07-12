class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.string :comment,   null: false
      t.references :user,  foreign_key: true
      t.references :diary, foreign_key: true
      t.timestamps
    end
  end
end
