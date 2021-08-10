class CreateTagsRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :tags_relationships do |t|
      t.references :diary, foreign_key: true
      t.references :tag, foreign_key: true
    end
  end
end
