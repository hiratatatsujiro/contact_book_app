class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.integer :condition_id
      t.string :reason         
      t.integer :pool_marathon_id 
      t.text :contact          
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
