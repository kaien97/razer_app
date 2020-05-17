class PersonalAccount < ApplicationRecord
  include Friendlyable
  belongs_to :user
  has_one :identity
  has_many :activities

  has_many :friendships_one, class_name: "Friendship", foreign_key: "account_1_id"
  has_many :friendships_two, class_name: "Friendship", foreign_key: "account_2_id"
  has_many :friends_type_one, through: :friendships_one, source: :account_2
  has_many :friends_type_two, through: :friendships_two, source: :account_1

  # For future use
  has_many :credits, class_name:	"Loan",
                foreign_key:	"loaner_id"
  has_many :lends, class_name:	"Loan",
                   foreign_key:	"lender_id"
  has_many :loaners, through: :credits, source: :loaner
  has_many :lenders, through: :lends, source: :lender

  def verified
    return self.identity.verified
  end

  def friends
    friends_1 = self.friends_type_one
    friends_2 = self.friends_type_two
    return friends_1 + friends_2
  end

  def name
    return (self.identity.first_name + " " + self.identity.last_name)
  end
end
