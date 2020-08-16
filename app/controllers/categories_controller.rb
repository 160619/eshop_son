# frozen_string_literal: true

class CategoriesController < ApplicationController
  def new
    @categories = Category.all
  end

  def index
    @categories = Category.all
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = 'Create category successfully'
      redirect_to root_path
    else
      flash[:alert] = 'Create category failed'
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit :name, :parent_id
  end
end
