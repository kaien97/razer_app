class RenameIdentitiesType < ActiveRecord::Migration[5.2]
  def change
    rename_column :identities, :type, :id_type
  end
end
