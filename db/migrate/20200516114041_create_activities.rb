class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.string :name
      t.string :timing
      t.integer :n_pax
      t.float :cost
      t.float :paid
      t.string :status
      t.string :participant_list, array: true, default: []
      t.timestamps
      t.string :hash_id
      t.references :business
      t.references :personal_account
    end
  end
end
