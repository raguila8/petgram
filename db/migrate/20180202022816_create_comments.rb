class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.text :content
      t.references :profile, foreign_key: true
      t.references :post, foreign_key: true

      t.timestamps
    end
		add_index :comments, :profile
		add_index :comments, :post
  end
end
