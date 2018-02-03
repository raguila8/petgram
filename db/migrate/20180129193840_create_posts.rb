class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.text :description
      t.string :image
			t.belongs_to :profile, index: true

      t.timestamps
    end
  end
end
