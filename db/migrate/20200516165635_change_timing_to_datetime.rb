class ChangeTimingToDatetime < ActiveRecord::Migration[5.2]
  def change
    remove_column :activities, :timing, :string
    add_column :activities, :timing, :datetime
  end
end
