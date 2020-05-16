class BusinessesController < ApplicationController
  before_action :authenticate_user!, except: [:search, :search_results]
  def search
    @timings = []
    time = Time.now.beginning_of_hour + 1.hour
    while time.strftime("%H").to_i != 22
      @timings.append(time.strftime("%-l%P, %-d %b"))
      time += 1.hour
    end
  end

  def search_results
    if params[:search].empty?
      redirect_to search_businesses_path
    end

    @timings = []
    time = Time.now.beginning_of_hour + 1.hour
    while time.strftime("%H").to_i != 22
      @timings.append(time.strftime("%-l%P, %-d %b"))
      time += 1.hour
    end

    if params[:search][:location].to_i/100000 > 0 # Location search using postcode
      @business_list = Business.all.select{|b| b if (b.postal_code/10000 == params[:search][:location].to_i/10000) }
      @business_list = @business_list.select{|b| b if b.timings_available&.include?(params[:search][:timings]) }
      @business_list = @business_list.select{|b| b if params[:search][:activity].downcase.include?(b.service.downcase) }
    else
      @business_list = Business.all.select{|b| b if b.address.downcase.include?(params[:search][:location].downcase) }
      @business_list = @business_list.select{|b| b if b.timings_available&.include?(params[:search][:timings]) }
      @business_list = @business_list.select{|b| b if params[:search][:activity].downcase.include?(b.service.downcase) }
    end
  end

  def help
  end

  def about
  end
end
