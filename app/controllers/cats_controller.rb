class CatsController < ApplicationController
  before_action :verify_ownership, only: [:edit, :update]
  before_action :verify_logged_in, only: [:create, :new]

  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id
    if @cat.save
      redirect_to cat_url(@cat)
    else
      render :new
    end
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update!(cat_params)
      redirect_to cat_url(@cat)
    else
      render :edit
    end
  end

  private
    def cat_params
      params.require(:cat).permit(:birth_date,
                          :color, :name, :sex, :description)
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
