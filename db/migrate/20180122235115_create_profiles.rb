class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.string :username, unique: true, index: true
      t.string :name
      t.text :bio
      t.string :animal
			t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
