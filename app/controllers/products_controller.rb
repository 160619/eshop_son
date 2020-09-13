# frozen_string_literal: true

class ProductsController < ApplicationController
  def new
    @products = Product.new
  end

  def index
    @products = Product.all.order(:name)
  end

  def show
    @product = Product.find(params[:id])
    @review = @product.reviews.new
    @comment = @review.comments.new
  end

  def create
    @product = Product.new product_params
    if @product.save
      flash[:success] = 'Create product successfully'
      redirect_to root_path
    else
      flash[:alert] = 'Create product failed'
      render :new
    end
  end

  def edit
      @product = Product.find(params[:id])
  end

  def update
    @product= Product.find(params[:id])
    if @product.update(product_params)
      flash[:notice] = "Product successfully updated!"
      redirect_to products_path
    else
      render :edit
    end
  end

  def destroy
    if Product.find(params[:id]).destroy
      flash[:notice] = "Product successfully removed!"
      redirect_to products_path
    end
  end

  private

  def product_params
    params.require(:product).permit :category_id, :name, :description, :price, :quantity
  end
end
