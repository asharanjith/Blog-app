require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
  describe 'GET /users' do
    before(:each) do
      get users_path
    end
    it 'return a sucess status of 200' do
      expect(response).to have_http_status(200)
      expect(response).to be_successful
    end
    it 'renders the index template' do
      expect(response).to render_template(:index)
    end
  end
  describe 'GET /users/:id' do
    before(:each) do
      get '/users/1'
    end
    it 'return a sucess status of 200' do
      expect(response).to have_http_status(200)
      expect(response).to be_successful
    end
    it 'renders the show template' do
      expect(response).to render_template(:show)
    end
  end
end
