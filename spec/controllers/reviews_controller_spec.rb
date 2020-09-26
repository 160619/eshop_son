require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do

  describe "#create" do
    context 'create a review successfully' do
      let(:user) do
        User.create(email: 'demo@gmail.com', password:'123456', password_confirmation: '123456')
      end
      let(:category) do
        Category.create(name: 'Apple')
      end
      let(:product) do
        Product.create(name: 'P1', price: 1000, quantity: 100, category_id: category.id)
      end

      before do
        sign_in user
      end

      it "creates a new review in database" do
        post :create, params: { product_id: product.id, review: { content: 'a'*20, rating: 5 }}
        expect(Review.count).to eql(1)
      end

      it "calculates product avg rating " do
        post :create, params: { product_id: product.id, review: { content: 'a'*20, rating: 5 }}
        expect(product.reload.aggregate_rating).to eql(5)
      end

      it "redirect_to show product page" do
        post :create, params: { product_id: product.id, review: { content: 'a'*20, rating: 5 }}
        expect(response).to redirect_to(product_path(product))
     end
    end

    context 'create a review failed' do
      let(:user) do
        User.create(email: 'demo@gmail.com', password:'123456', password_confirmation: '123456')
      end
      let(:category) do
        Category.create(name: 'Apple')
      end
      let(:product) do
        Product.create(name: 'P1', price: 1000, quantity: 100, category_id: category.id)
      end

      before do
        sign_in user
      end

      it "creates a new review in database" do
        post :create, params: { product_id: product.id, review: { content: 'a'*20, rating: 5 }}
        expect(Review.count).to eql(1)
      end

      it "calculates product avg rating " do
        post :create, params: { product_id: product.id, review: { content: 'a'*20, rating: 5 }}
        expect(product.reload.aggregate_rating).to eql(5)
      end


      it "redirect_to product show pages" do
        post :create, params: { product_id: product.id, review: { content: 'a'*20, rating: 5 }}
        expect(response).to redirect_to(product_path(product))
     end
   end
  end
end
