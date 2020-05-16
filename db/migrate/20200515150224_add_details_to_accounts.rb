class AddDetailsToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :identities, :first_name, :string
    add_column :identities, :middle_name, :string
    add_column :identities, :last_name, :string
    add_column :accounts, :mambu_user_id, :string
    add_column :accounts, :mambu_account_id, :string
  end
end
