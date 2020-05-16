class CreateCalendar < ActiveRecord::Migration[5.2]
  def change
    create_table :calendars do |t|
      t.string :cal_type
      t.string :cal_url
      t.jsonb :auth_info, default: {}
      t.references :businesses, foreign_key: {on_delete: :cascade}
      t.references :personal_accounts, foreign_key: {on_delete: :cascade}
    end
  end
end
