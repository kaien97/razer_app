class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.float :money
      t.integer :credit_score
      t.references :user, foreign_key: {on_delete: :cascade}
      t.string :hash_id
    end
  end
end
