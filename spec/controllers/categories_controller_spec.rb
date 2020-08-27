require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do

  describe "#index" do
    it "assigns categories" do
      Category.create(name: 'Macbook')
      get :index
      categories = assigns(:categories)
      expect(categories.size).to eql(1)
    end

     it "renders the index view" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "#new" do
    it "assigns a new category to @categories" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "#create" do
    context "success" do
      it "create a presisted category" do
        post :create, params: { category: {name:'Macbook'}}
        expect(Category.count).to eql(1)
      end

      it "redirect_to categories index pages" do
        post :create, params: { category: {name:'Macbook'}}
        expect(response).to redirect_to(root_path)
     end
    end


  end
end
