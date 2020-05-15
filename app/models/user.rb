class User < ApplicationRecord
  include Friendlyable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :account

  after_create :initialize_account

  def initialize_account
    account = self.create_account!
    account.create_identity!
  end
end
