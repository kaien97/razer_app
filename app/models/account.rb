class Account < ApplicationRecord
  include Friendlyable
  belongs_to :user
  has_one :identity

  has_many :credits, class_name:	"Loan",
                foreign_key:	"loaner_id"
  has_many :lends, class_name:	"Loan",
                   foreign_key:	"lender_id"
  has_many :loaners, through: :credits, source: :loaner
  has_many :lenders, through: :lends, source: :lender

  def verified
    return self.identity.verified
  end
end
