class CatRentalRequestsController < ApplicationController
  def new
    @request = CatRentalRequest.new
    render :new
  end

  def create
    @request = CatRentalRequest.create!(request_params)
    if @request.save
      redirect_to cats_url
    else
      render :new
    end
  end

  def edit
    @request = CatRentalRequest.find(params[:id])
    render :edit
  end

  def update
    @request = CatRentalRequest.find(params[:id])
    if @request.update!(request_params)
      redirect_to cats_url
    else
      render :edit
    end
  end

  private
    def request_params
      params.require(:request).permit(:cat_id, :start_date, :end_date, :status)
    end
end
