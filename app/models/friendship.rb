class Friendship < ApplicationRecord
  belongs_to :account_1, :class_name => "PersonalAccount"
  belongs_to :account_2, :class_name => "PersonalAccount"
  validates :account_1, presence: true
  validates :account_2, presence: true
end
