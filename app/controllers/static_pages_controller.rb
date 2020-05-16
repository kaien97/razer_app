class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      redirect_to account_dashboard_path(current_user.personal_account.hash_id)
    end
  end

  def help
  end

  def about
  end
end
