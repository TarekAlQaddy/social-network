class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.text :caption
      t.boolean :is_public
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
