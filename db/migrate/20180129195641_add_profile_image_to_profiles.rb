class AddProfileImageToProfiles < ActiveRecord::Migration[5.1]
  def change
		add_column :profiles, :profile_image, :string
  end
end
