require 'rails_helper'

RSpec.describe 'ChatMessages', type: :request do
  describe 'GET /index' do
    before do
      @tweet = FactoryBot.create(:tweet)
    end
  
    describe 'GET #index' do
      it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do 
        get root_path
        expect(response.status).to eq(【A】)
      end
      it 'indexアクションにリクエストするとレスポンスに投稿済みのツイートのテキストが存在する' do 
       get root_path
       expect(response.【B】).to include(【C】.text)
      end
      it 'indexアクションにリクエストするとレスポンスに投稿済みのツイートの画像URLが存在する' do 
       get root_path
       expect(response.【B】).to include(【C】.image)
      end
      it 'indexアクションにリクエストするとレスポンスに投稿検索フォームが存在する' do 
        get root_path
        expect(response.【B】).to 【D】('投稿を検索する')
      end
    end
  end
end
