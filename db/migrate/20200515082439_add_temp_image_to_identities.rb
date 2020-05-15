class AddTempImageToIdentities < ActiveRecord::Migration[5.2]
  def change
    add_column :identities, :temp_image_front, :string
    add_column :identities, :temp_image_back, :string
  end
end
