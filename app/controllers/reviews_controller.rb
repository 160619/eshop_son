# frozen_string_literal: true

class ReviewsController < ApplicationController
  before_action :authenticate_user!
  def new
    @product = Product.find(params[:product_id])
    @review = @product.reviews.new
  end

  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.new(review_params)
    @review.user_id = current_user.id

    respond_to do |format|
      if @review.save
        html_comment_form = render_to_string(
          partial:  'comments/comment',
          locals: { review: @review, comment: Comment.new }
        )
        @product.calculate_rating
        format.json { render json: review_serializer(html_comment_form), status: :created }
      else
        format.json { render json: @review.errors.full_messages, status: :unprocessable_entiry }
      end
    end
  end

  def show
    @review = Review.find(params[:id])
    @product = @review.product
    @comment = @review.comments.new
  end

  def edit
    @review = Review.find(params[:id])
    @product = @review.product
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      flash[:notice] = 'Review successfully updated!'
      redirect_to product_path(@review.product)
    else
      render :edit
    end
  end

  def destroy
    @product = Review.find(params[:id]).product
    if Review.find(params[:id]).destroy
      flash[:notice] = 'Review successfully removed!'
      redirect_to product_path(@product)
    end
  end

  private
  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:user_id, :content, :rating, :product_id)
  end

  def review_serializer(comment_form)
     {
       id: @review.id,
       content: @review.content,
       rating: @review.rating,
       user: {
         email: @review.user.email
       },
       product: {
         aggregate_rating: @product.reload.aggregate_rating
       },
       comment_form: comment_form
     }
   end

   def comment_form_html
     render_to_string(
       partial: 'comments/comment',
       locals: { review: @review, comment: Comment.new }
     )
   end
end
