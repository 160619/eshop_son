# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  def new
    @review = Review.find(params[:review_id])
    @comment = @review.comments.new
  end

  def create
    @review = Review.find(params[:review_id])
    @comment = @review.comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = 'Your comment was successfully added!'
      redirect_to product_path(@review.product_id)
    else
      render 'product/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit :body, :review_id, :user_id
  end
end
