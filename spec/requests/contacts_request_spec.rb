require 'rails_helper'
describe ContactsController, type: :request do

  before do
    @contact = FactoryBot.create(:contact)
    author = @contact.user
    @user = FactoryBot.create(:user, grade_id: author.grade_id, classroom_id: author.classroom_id, number_id: 52)
    sign_in @user
  end

  describe 'GET #index' do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do 
      get contacts_path
      expect(response.status).to eq 200
    end

    it 'indexアクションにリクエストするとレスポンスに送信日が存在する' do
      get contacts_path
      expect(response.body).to include(@contact.created_at.strftime('%Y/%m/%d %H:%M'))
    end
  end

  describe 'GET #show' do
    it 'showアクションにリクエストすると正常にレスポンスが返ってくる' do 
      get contact_path(@contact)
      expect(response.status).to eq 200
    end

    it 'showアクションにリクエストするとレスポンスに連絡者の名前が存在する' do
      get contact_path(@contact)
      expect(response.body).to include(@contact.user.last_name)
    end

    it 'showアクションにリクエストするとレスポンスに連絡者の名前が存在する' do
      get contact_path(@contact)
      expect(response.body).to include(@contact.user.first_name)
    end

    it 'showアクションにリクエストするとレスポンスに学級通信の書いた日が存在する' do
      get contact_path(@contact)
      expect(response.body).to include(@contact.created_at.strftime('%Y/%m/%d %H:%M'))
    end

    it 'showアクションにリクエストするとレスポンスに学級通信の書いた日が存在する' do
      get contact_path(@contact)
      expect(response.body).to include(@contact.condition.name)
    end

    it 'showアクションにリクエストするとレスポンスに学級通信の書いた日が存在する' do
      get contact_path(@contact)
      expect(response.body).to include(@contact.reason)
    end

    it 'showアクションにリクエストするとレスポンスに学級通信の書いた日が存在する' do
      get contact_path(@contact)
      expect(response.body).to include(@contact.pool_marathon.name)
    end

    it 'showアクションにリクエストするとレスポンスに学級通信の書いた日が存在する' do
      get contact_path(@contact)
      expect(response.body).to include(@contact.contact)
    end
  end
end
