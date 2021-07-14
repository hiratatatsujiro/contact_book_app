require 'rails_helper'

RSpec.describe 'ChatMessages', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/chat_messages/index'
      expect(response).to have_http_status(:success)
    end
  end
end
