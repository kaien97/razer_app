class User < ApplicationRecord
  include Friendlyable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :personal_account
  has_one :business_account

  after_create :initialize_account

  def initialize_account
    account = self.create_personal_account!
    account.create_identity!
  end

  def account
    return self.personal_account
  end
end
