class CreateBusinessAccount < ActiveRecord::Migration[5.2]
  def change
    create_table :business_accounts do |t|
      t.float :money
      t.references :user, foreign_key: {on_delete: :cascade}
      t.string :hash_id
      t.string :mambu_user_id
      t.string :mambu_account_id
    end

    create_table :businesses do |t|
      t.string :timings_available
      t.integer :postal_code
      t.string :service
      t.string :name
      t.string :address
      t.integer :price_max
      t.integer :price_min
      t.jsonb :info, default: {}
      t.string :phone_number
      t.string :hash_id
      t.references :business_account, foreign_key: {on_delete: :cascade}
    end

    rename_table :accounts, :personal_accounts
    add_reference :identities, :personal_account, index: true, foreign_key: {on_delete: :cascade}
    remove_reference :identities, :account
  end
end
