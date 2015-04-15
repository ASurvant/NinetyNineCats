class CatRentalRequestsController < ApplicationController
  def new
    @request = CatRentalRequest.new
    render :new
  end

  def create
    @request = CatRentalRequest.new(request_params)
    if @request.save
      redirect_to cat_url(@request.cat)
    else
      render :new
    end
  end

  def approve
    current_request.approve!
    redirect_to cat_url(current_cat)
  end

  def deny
    current_request.deny!
    redirect_to cat_url(current_cat)
  end

  private
    def current_request
      @request ||= CatRentalRequest.includes(:cat).find(params[:id])
    end

    def current_cat
      current_request.cat
    end

    def request_params
      params.require(:request).permit(:cat_id, :start_date, :end_date, :status)
    end
end
