require 'rails_helper'

RSpec.describe Diary, type: :model do
  before do
    @diary = FactoryBot.build(:diary)
  end

  context '内容に問題がない場合' do
    it '全ての情報があれば登録できる' do
      expect(@diary).to be_valid
    end
  end

  context '内容に問題がある場合' do
    it 'diary_dayが空だと登録できない' do
      @diary.diary_day = ''
      @diary.valid?
      expect(@diary.errors.full_messages).to include("書いた日を入力してください")
    end

    it 'imageが空だと登録できない' do
      @diary.image = nil
      @diary.valid?
      expect(@diary.errors.full_messages).to include("画像を入力してください")
    end

    it 'titleが空だと登録できない' do
      @diary.title = ''
      @diary.valid?
      expect(@diary.errors.full_messages).to include("タイトルを入力してください")
    end

    it 'diaryが空だと登録できない' do
      @diary.diary = ''
      @diary.valid?
      expect(@diary.errors.full_messages).to include("日記を入力してください")
    end

    it 'userが紐付いていないと登録できない' do
      @diary.user = nil
      @diary.valid?
      expect(@diary.errors.full_messages).to include('ユーザーを入力してください')
    end
  end
end
