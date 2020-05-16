class Loan < ApplicationRecord
  include Friendlyable
  belongs_to :loaner, class_name: "Account"
  belongs_to :lender, class_name: "Account"
  validates :loaner_id, presence: true
  validates :lender_id, presence: true
end
