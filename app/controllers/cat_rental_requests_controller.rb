class CatRentalRequestsController < ApplicationController
  before_action :verify_ownership, only: [:approve, :deny]
  before_action :verify_logged_in, only: [:create, :new]

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

    def verify_ownership
      unless current_user == User.find(Cat.find(params[:id]).user_id)
        redirect_to cat_url(params[:id])
      end
    end

    def verify_logged_in
      redirect_to cats_url if current_user.nil?
    end
end
