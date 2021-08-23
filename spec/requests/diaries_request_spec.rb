require 'rails_helper'
describe DiariesController, type: :request do
  before do
    @diary = FactoryBot.create(:diary)
    author = @diary.user
    @user = FactoryBot.create(:user, grade_id: author.grade_id, classroom_id: author.classroom_id, number_id: 52)
    sign_in @user
  end

  describe 'GET #index' do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
      get diaries_path
      expect(response.status).to eq 200
    end

    it 'indexアクションにリクエストするとレスポンスに日記のタイトルが存在する' do
      get diaries_path
      expect(response.body).to include(@diary.title)
    end

    it 'indexアクションにリクエストするとレスポンスに日記が存在する' do
      get diaries_path
      expect(response.body).to include(@diary.diary)
    end

    it 'indexアクションにリクエストするとレスポンスに日記の書いた日が存在する' do
      get diaries_path
      expect(response.body).to include(@diary.diary_day.to_s)
    end

    it 'indexアクションにリクエストするとレスポンスに投稿検索フォームが存在する' do
      get diaries_path
      expect(response.body).to include('検索')
    end
  end

  describe 'GET #show' do
    it 'showアクションにリクエストすると正常にレスポンスが返ってくる' do
      get diary_path(@diary)
      expect(response.status).to eq 200
    end

    it 'showアクションにリクエストするとレスポンスに日記のタイトルが存在する' do
      get diary_path(@diary)
      expect(response.body).to include(@diary.title)
    end

    it 'showアクションにリクエストするとレスポンスに日記が存在する' do
      get diary_path(@diary)
      expect(response.body).to include(@diary.diary)
    end

    it 'showアクションにリクエストするとレスポンスに日記の書いた日が存在する' do
      get diary_path(@diary)
      expect(response.body).to include(@diary.diary_day.to_s)
    end

    it 'showアクションにリクエストするとレスポンスにコメント機能が存在する' do
      get diary_path(@diary)
      expect(response.body).to include('コメント')
    end
  end
end
