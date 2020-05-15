class AccountController < ApplicationController
  before_action :authenticate_user!
  before_action :check_if_verified, except: [:verify, :verification]

  respond_to :html, :js
  def create
  end

  def add
  end

  def select
  end

  def delete
  end

  def verify
  end

  def verification
    current_user.account.identity.update(verify_params)
    result, message = IdentityService.new.fwd_verify(current_user.account.identity)
    if result
      flash[:success] = message
    else
      flash[:danger] = message
    end
    redirect_to root_path
  end

  def dashboard
    @account = current_user.account

    if @account.mambu_user_id
      @mambu_key = @account.mambu_user_id
    else
      IdentityService.new.create_mambu_client(@account.identity)
      IdentityService.new.create_mambu_account(@account)
    end

    @account_details = HTTParty.get("https://#{ENV['MAMBU_USERNAME']}:#{ENV['MAMBU_PASSWORD']}@#{ENV['MAMBU_TENANT']}/api/savings/#{@account.mambu_account_id}/")
    # balance in @account_details["balance"]
  end

  private

  def check_if_verified
    if !current_user&.account&.verified
      redirect_to account_verify_path(current_user.hash_id)
    end
  end

  def verify_params
    params.require(:identity).permit(:first_name, :middle_name, :last_name, :temp_image_front, :temp_image_back)
  end

end
