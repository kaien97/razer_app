class CreateLoans < ActiveRecord::Migration[5.2]
  def change
    create_table :loans do |t|
      t.integer :loaner_hash_id
      t.integer :lender_hash_id
      t.boolean :settled, default: false
      t.jsonb :history, default: {}
      t.string :hash_id
      t.timestamps
    end

    add_index :loans, :loaner_hash_id
    add_index :loans, :lender_hash_id
    add_index :loans, [:loaner_hash_id, :lender_hash_id], unique: true
  end
end
