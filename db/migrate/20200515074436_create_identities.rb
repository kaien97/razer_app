class CreateIdentities < ActiveRecord::Migration[5.2]
  def change
    create_table :identities do |t|
      t.string :encrypted_idnum
      t.string :encrypted_dob
      t.string :encrypted_name
      t.string :encrypted_race
      t.string :encrypted_country
      t.datetime :issue_date
      t.datetime :end_date
      t.string :type
      t.boolean :verified, default: false
      t.references :account, foreign_key: {on_delete: :cascade}
    end
  end
end
