require 'rails_helper'
<<<<<<< Updated upstream

RSpec.describe 'ClassCommunications', type: :request do
=======
describe ClassCommunicationsController, type: :request do
  before do
    @class_communication = FactoryBot.create(:class_communication)
    author = @class_communication.user
    @user = FactoryBot.create(:user, grade_id: author.grade_id, classroom_id: author.classroom_id)
    sign_in @user
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

    it 'indexアクションにリクエストするとレスポンスに学級通信の文章が存在する' do
      get class_communications_path
      expect(response.body).to include(@class_communication.text)
    end

    it 'indexアクションにリクエストするとレスポンスに学級通信の書いた日が存在する' do
      get class_communications_path
      expect(response.body).to include(@class_communication.class_communication_day.to_s)
    end

    it 'indexアクションにリクエストするとレスポンスに投稿検索フォームが存在する' do
      get class_communications_path
      expect(response.body).to include('検索')
    end
  end

  describe 'GET #show' do
    it 'showアクションにリクエストすると正常にレスポンスが返ってくる' do
      get class_communication_path(@class_communication)
      expect(response.status).to eq 200
    end

    it 'showアクションにリクエストするとレスポンスに学級通信のタイトルが存在する' do
      get class_communication_path(@class_communication)
      expect(response.body).to include(@class_communication.title)
    end

    it 'showアクションにリクエストするとレスポンスに学級通信の文章が存在する' do
      get class_communication_path(@class_communication)
      expect(response.body).to include(@class_communication.text)
    end

    it 'showアクションにリクエストするとレスポンスに学級通信の書いた日が存在する' do
      get class_communication_path(@class_communication)
      expect(response.body).to include(@class_communication.class_communication_day.to_s)
    end

    it 'showアクションにリクエストするとレスポンスにいいね機能が存在する' do
      get class_communication_path(@class_communication)
      expect(response.body).to include('いいね')
    end
  end
>>>>>>> Stashed changes
end
