class AddTimestampsToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_timestamps :personal_accounts, default: Time.zone.now
    change_column_default :personal_accounts, :created_at, nil
    change_column_default :personal_accounts, :updated_at, nil

    add_timestamps :business_accounts, default: Time.zone.now
    change_column_default :business_accounts, :created_at, nil
    change_column_default :business_accounts, :updated_at, nil
  end
end
