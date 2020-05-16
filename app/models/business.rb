class Business < ApplicationRecord
  include Friendlyable
  belongs_to :business_account
end
