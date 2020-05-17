class ActivitiesController < ApplicationController
  before_action :authenticate_user!

  respond_to :html, :js
  # Form to create booking
  def new
    @account = current_user.personal_account
    @business = Business.find_by(hash_id: params[:b_id])
    @cost_per_pax = (@business.price_max + @business.price_min).to_f/2.0
  end

  # Create a booking
  def create
    @account = current_user.personal_account
    @business = Business.find_by(hash_id: params[:activity][:b_id])
    activity = Activity.create(personal_account: @account, business: @business, timing: params[:activity][:timing].in_time_zone("Singapore").to_datetime)
    result = activity.update(activity_params.merge({status: "confirmed"}))
    if result
      flash[:success] = "Your booking was successful!"
    else
      flash[:danger] = "An error has occured. Please try again."
    end
    redirect_to root_path
  end

  # Cancel booking or Make Payment
  def update
    activity = Activity.find_by(hash_id: params[:id])
    account = current_user.personal_account
    business = activity.business
    business_account = business.business_account
    # Business will enter the cost of the activity, for now, use the estimate to generate cost
    cost = activity.cost || (activity.n_pax * (business.price_max + business.price_min).to_f/2.0 )
    activity.update(cost: cost)
    final_cost = cost - activity.paid.to_f

    if params[:status] == 'pay'
      result = MambuService.new.transfer(account, business_account, final_cost, "Payment to #{business.name}")
      if result
        activity.update(status: "paid")
        flash[:success] = "Succesfully completed payment"
      elsif MambuService.new.balance(account).to_i < final_cost
        flash[:warning] = "Insufficient balance"
      else
        flash[:danger] = "An error has occured. Please try again."
      end

    # Pay 10% of cost if cancel time is less than 30 minutes away from activity time
    elsif params[:status] == 'cancel'
      if (activity.timing - Time.now) < 30.minutes
        result = MambuService.new.transfer(account, business_account, final_cost*0.1, "Late cancellation payment to #{business.name}")
        if result
          activity.update(status: "cancelled")
          flash[:success] = "Succesfully cancelled booking"
        else
          flash[:danger] = "An error has occured. Please try again."
        end
      else
        activity.update(status: "cancelled")
        flash[:success] = "Succesfully cancelled booking"
      end

    else
      flash[:danger] = "An error has occured. Please try again."
    end
    redirect_to root_path
  end

  def show
    @activity = Activity.find_by(hash_id: params[:id])
  end

  # See all previous activities
  def index
    @account = current_user.personal_account
    @activities = @account.activities&.order("timing DESC")
  end

  # List activities to invite a person to
  def invite
    @account = current_user.personal_account
    @invitee = PersonalAccount.find_by(hash_id: params[:f_id])
    @activities = @account.activities&.order("timing ASC").select{|a| a if (a.timing > Time.now && a.status != "cancelled")}
  end

  # Invite person to a particular activity
  def jio
    @invitee = PersonalAccount.find_by(hash_id: params[:f_id])
    flash[:success] = "#{@invitee.name} has been invited!"
    redirect_to root_path
  end

  private
  def activity_params
    params.require(:activity).permit(:n_pax)
  end
end
