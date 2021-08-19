require 'rails_helper'
describe ClassCommunicationsController, type: :request do

  before do
    @user = FactoryBot.create(:user)
    sign_in @user
    @class_communication = FactoryBot.create(:class_communication)
  end

  describe 'GET #index' do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do 
      get class_communications_path
      expect(response.status).to eq 200
    end

    it 'indexアクションにリクエストするとレスポンスに学級通信のタイトルが存在する' do 
      get class_communications_path
      expect(response.body).to include(@class_communication.title)
    end

   
  end
end