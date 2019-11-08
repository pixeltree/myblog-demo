require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  before { sign_in FactoryBot.create(:user) }

  let(:title) { Faker::Lorem.sentence }
  let(:body) { Faker::Lorem.paragraph }

  let(:valid_attributes) {
    {
      title: title,
      body: body
    }
  }

  let(:invalid_attributes) {
    {
      title: nil,
      body: nil
    }
  }

  describe "GET #index" do
    it "returns a success response" do
      Post.create! valid_attributes
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      post = Post.create! valid_attributes
      get :show, params: { id: post.to_param }
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      post = Post.create! valid_attributes
      get :edit, params: { id: post.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Post" do
        expect {
          post :create, params: { post: valid_attributes }
        }.to change(Post, :count).by(1)
      end

      it "redirects to the created post" do
        post :create, params: { post: valid_attributes }
        expect(response).to redirect_to(Post.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { post: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_title) { Faker::Lorem.sentence }
      let(:new_body) { Faker::Lorem.paragraph }

      let(:new_attributes) {
        {
          title: new_title,
          body: new_body
        }
      }

      it "updates the requested post" do
        post = Post.create! valid_attributes
        put :update, params: { id: post.to_param, post: new_attributes }
        post.reload

        expect(post.title).to eq new_title
        expect(post.body).to eq new_body
      end

      it "redirects to the post" do
        post = Post.create! valid_attributes
        put :update, params: { id: post.to_param, post: valid_attributes }
        expect(response).to redirect_to(post)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        post = Post.create! valid_attributes
        put :update, params: { id: post.to_param, post: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested post" do
      post = Post.create! valid_attributes
      expect {
        delete :destroy, params: { id: post.to_param }
      }.to change(Post, :count).by(-1)
    end

    it "redirects to the posts list" do
      post = Post.create! valid_attributes
      delete :destroy, params: { id: post.to_param }
      expect(response).to redirect_to(posts_url)
    end
  end

end
