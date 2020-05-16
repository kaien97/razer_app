class Activity < ApplicationRecord
  include Friendlyable
  belongs_to :personal_account
  belongs_to :business
end
