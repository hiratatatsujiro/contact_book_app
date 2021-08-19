require 'rails_helper'

RSpec.describe Timetable, type: :model do
  before do
    @timetable = FactoryBot.build(:timetable)
  end

  context '内容に問題がない場合' do
    it '全ての情報があれば登録できる' do
      expect(@timetable).to be_valid
    end
  end

  context '内容に問題がある場合' do
    it 'next_dayが空だと登録できない' do
      @timetable.next_day = ''
      @timetable.valid?
      expect(@timetable.errors.full_messages).to include("学校に来る日を入力してください")
    end

    it 'first_class_idが空だと登録できない' do
      @timetable.first_class_id = 1
      @timetable.valid?
      expect(@timetable.errors.full_messages).to include("1時間目が選択されていません")
    end

    it 'second_class_idが空だと登録できない' do
      @timetable.second_class_id = 1
      @timetable.valid?
      expect(@timetable.errors.full_messages).to include("2時間目が選択されていません")
    end

    it 'third_class_idが空だと登録できない' do
      @timetable.third_class_id = 1
      @timetable.valid?
      expect(@timetable.errors.full_messages).to include("3時間目が選択されていません")
    end

    it 'fourth_class_idが空だと登録できない' do
      @timetable.fourth_class_id = 1
      @timetable.valid?
      expect(@timetable.errors.full_messages).to include("4時間目が選択されていません")
    end

    it 'fifth_class_idが空だと登録できない' do
      @timetable.fifth_class_id = 1
      @timetable.valid?
      expect(@timetable.errors.full_messages).to include("5時間目が選択されていません")
    end

    it 'sixth_class_idが空だと登録できない' do
      @timetable.sixth_class_id = 1
      @timetable.valid?
      expect(@timetable.errors.full_messages).to include("6時間目が選択されていません")
    end

    it 'leave_timeが空だと登録できない' do
      @timetable.leave_time = ''
      @timetable.valid?
      expect(@timetable.errors.full_messages).to include("下校時刻を入力してください")
    end

    it 'homeworkが空だと登録できない' do
      @timetable.homework = ''
      @timetable.valid?
      expect(@timetable.errors.full_messages).to include("宿題を入力してください")
    end

    it 'preparationが空だと登録できない' do
      @timetable.preparation = ''
      @timetable.valid?
      expect(@timetable.errors.full_messages).to include("持ってくるものを入力してください")
    end


    it 'userが紐付いていないと登録できない' do
      @timetable.user = nil
      @timetable.valid?
      expect(@timetable.errors.full_messages).to include('ユーザーを入力してください')
    end
  end
end
