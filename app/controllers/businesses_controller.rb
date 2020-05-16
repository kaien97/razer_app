class BusinessesController < ApplicationController
  before_action :authenticate_user!, except: [:search, :search_results]
  def search
    @timings = []
    time = Time.now + 1.hour
    while time.strftime("%H").to_i != 0
      @timings.append(time.strftime("%l%P"))
      time += 1.hour
    end
  end

  def search_results
    if params[:search].empty?
      redirect_to search_businesses_path
    end

    if params[:search][:location].to_i/100000 > 0 # Location search using postcode
      #@business_list = Business.all.select{|b| b if (b.postal_code/10000 == params[:search][:location].to_i/10000
      #                                            && b.timings_available.include?(params[:search][:timings])
      #                                            && params[:search][:activity].include?(b.service) )}
    else
      #@business_list = Business.all.select{|b| b if (b.address.include?(params[:search][:location])
      #                                            && b.timings_available.include?(params[:search][:timings])
      #                                            && params[:search][:activity].include?(b.service) )}
    end
  end

  def help
  end

  def about
  end
end
