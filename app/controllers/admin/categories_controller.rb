class Admin::CategoriesController < ApplicationController
  before_action :authorize
  def index
    @categories = Category.all
    @main_categories = Category.limit(3)
  end

  def edit
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path
    else
     render :new
    end  
  end

  def update
    @category = Category.find(params[:id])
    @category.update(category_params)
    redirect_to admin_categories_path
  end

  def destroy
    Category.find(params[:id]).destroy
    redirect_to :back
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
