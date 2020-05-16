class BusinessAccount < ApplicationRecord
  include Friendlyable
  belongs_to :user
  has_many :businesses


end
