require 'rails_helper'
describe TimetablesController, type: :request do

  before do
    @timetable = FactoryBot.create(:timetable)
    author = @timetable.user
    @user = FactoryBot.create(:user, grade_id: author.grade_id, classroom_id: author.classroom_id, number_id: 52)
    sign_in @user
  end

  describe 'GET #index' do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do 
      get timetables_path
      expect(response.status).to eq 200
    end

    it 'indexアクションにリクエストするとレスポンスに時間割の日付が存在する' do
      get timetables_path
      expect(response.body).to include(@timetable.next_day.to_s)
    end

    it 'indexアクションにリクエストするとレスポンスに時間割の１時間目が存在する' do
      get timetables_path
      expect(response.body).to include(@timetable.first_class.name)
    end

    it 'indexアクションにリクエストするとレスポンスに時間割の２時間目が存在する' do
      get timetables_path
      expect(response.body).to include(@timetable.second_class.name)
    end

    it 'indexアクションにリクエストするとレスポンスに時間割の３時間目が存在する' do
      get timetables_path
      expect(response.body).to include(@timetable.third_class.name)
    end

    it 'indexアクションにリクエストするとレスポンスに時間割の４時間目が存在する' do
      get timetables_path
      expect(response.body).to include(@timetable.fourth_class.name)
    end

    it 'indexアクションにリクエストするとレスポンスに時間割の５時間目が存在する' do
      get timetables_path
      expect(response.body).to include(@timetable.fifth_class.name)
    end

    it 'indexアクションにリクエストするとレスポンスに時間割の６時間目が存在する' do
      get timetables_path
      expect(response.body).to include(@timetable.sixth_class.name)
    end

    it 'indexアクションにリクエストするとレスポンスに下校時刻が存在する' do
      get timetables_path
      expect(response.body).to include(@timetable.leave_time)
    end

    it 'indexアクションにリクエストするとレスポンスに宿題が存在する' do
      get timetables_path
      expect(response.body).to include(@timetable.homework)
    end

    it 'indexアクションにリクエストするとレスポンスに持ってくるものが存在する' do
      get timetables_path
      expect(response.body).to include(@timetable.preparation)
    end

    it 'indexアクションにリクエストするとレスポンスにお知らせが存在する' do
      get timetables_path
      expect(response.body).to include(@timetable.notice)
    end
  end

  describe 'GET #show' do
    it 'showアクションにリクエストすると正常にレスポンスが返ってくる' do 
      get timetable_path(@timetable)
      expect(response.status).to eq 200
    end

    it 'showアクションにリクエストするとレスポンスに時間割の日付が存在する' do
      get timetable_path(@timetable)
      expect(response.body).to include(@timetable.next_day.to_s)
    end

    it 'showアクションにリクエストするとレスポンスに時間割の１時間目が存在する' do
      get timetable_path(@timetable)
      expect(response.body).to include(@timetable.first_class.name)
    end

    it 'showアクションにリクエストするとレスポンスに時間割の２時間目が存在する' do
      get timetable_path(@timetable)
      expect(response.body).to include(@timetable.second_class.name)
    end

    it 'showアクションにリクエストするとレスポンスに時間割の３時間目が存在する' do
      get timetable_path(@timetable)
      expect(response.body).to include(@timetable.third_class.name)
    end

    it 'showアクションにリクエストするとレスポンスに時間割の４時間目が存在する' do
      get timetable_path(@timetable)
      expect(response.body).to include(@timetable.fourth_class.name)
    end

    it 'showアクションにリクエストするとレスポンスに時間割の５時間目が存在する' do
      get timetable_path(@timetable)
      expect(response.body).to include(@timetable.fifth_class.name)
    end

    it 'showアクションにリクエストするとレスポンスに時間割の６時間目が存在する' do
      get timetable_path(@timetable)
      expect(response.body).to include(@timetable.sixth_class.name)
    end

    it 'showアクションにリクエストするとレスポンスに下校時刻が存在する' do
      get timetable_path(@timetable)
      expect(response.body).to include(@timetable.leave_time)
    end

    it 'showアクションにリクエストするとレスポンスに宿題が存在する' do
      get timetable_path(@timetable)
      expect(response.body).to include(@timetable.homework)
    end

    it 'showアクションにリクエストするとレスポンスに持ってくるものが存在する' do
      get timetable_path(@timetable)
      expect(response.body).to include(@timetable.preparation)
    end

    it 'showアクションにリクエストするとレスポンスにお知らせが存在する' do
      get timetable_path(@timetable)
      expect(response.body).to include(@timetable.notice)
    end

    it 'showアクションにリクエストするとレスポンスに編集ボタンが存在する' do
      get timetable_path(@timetable)
      expect(response.body).to include("編集")
    end

    it 'showアクションにリクエストするとレスポンスに削除ボタンが存在する' do
      get timetable_path(@timetable)
      expect(response.body).to include("削除")
    end
  end
end
