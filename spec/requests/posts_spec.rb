require 'rails_helper'

RSpec.describe 'Posts controller', type: :request do
  describe 'GET /index' do
    before :each do
      get '/users/1/posts'
    end
    it 'renders the right template' do
      expect(response).to render_template(:index)
    end

    it 'the response body includes the correct placeholder text' do
      expect(response.body).to include('Here are the post for all users')
    end

    it 'the correct response status' do
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /show' do
    before :each do
      get '/users/1/posts/2'
    end
    it 'renders the right template' do
      expect(response).to render_template(:show)
    end

    it 'the response body includes the correct placeholder text' do
      expect(response.body).to include('You will see only one post here')
    end

    it 'the correct response status' do
      expect(response.status).to eq(200)
    end
  end
end
