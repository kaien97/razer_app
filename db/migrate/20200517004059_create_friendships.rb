class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.integer :account_1_id
      t.integer :account_2_id
      t.timestamps
    end

    create_table :notifications do |t|
      t.string :message
      t.string :notif_type
      t.boolean :resolved, default: false
      t.jsonb :data
      t.references :personal_account, foreign_key: {on_delete: :cascade}
      t.timestamps
    end

    add_column :businesses, :rating, :float
  end
end
