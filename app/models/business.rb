class Business < ApplicationRecord
  include Friendlyable
  belongs_to :business_account
  has_many :activities
  serialize :timings_available
end
