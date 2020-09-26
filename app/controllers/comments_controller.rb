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
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { flash[:success] = 'Your comment was successfully added!'
        redirect_to product_path(@review.product_id) }
        format.js
        format.json { render json: @comment, status: :created, location: @user }
      else
        format.html { render 'product/show' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit :body, :review_id, :user_id
  end
end
