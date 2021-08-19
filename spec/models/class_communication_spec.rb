require 'rails_helper'

RSpec.describe ClassCommunication, type: :model do
  before do
    @class_communication = FactoryBot.build(:class_communication)
  end

  context '内容に問題がない場合' do
    it '全ての情報があれば登録できる' do
      expect(@class_communication).to be_valid
    end
  end

  context '内容に問題がある場合' do
    it 'class_communication_dayが空だと登録できない' do
      @class_communication.class_communication_day = ''
      @class_communication.valid?
      expect(@class_communication.errors.full_messages).to include("書いた日を入力してください")
    end

    it 'imageが空だと登録できない' do
      @class_communication.images = nil
      @class_communication.valid?
      expect(@class_communication.errors.full_messages).to include("画像を入力してください")
    end

    it 'titleが空だと登録できない' do
      @class_communication.title = ''
      @class_communication.valid?
      expect(@class_communication.errors.full_messages).to include("タイトルを入力してください")
    end

    it 'textが空だと登録できない' do
      @class_communication.text = ''
      @class_communication.valid?
      expect(@class_communication.errors.full_messages).to include("本文を入力してください")
    end

    it 'userが紐付いていないと登録できない' do
      @class_communication.user = nil
      @class_communication.valid?
      expect(@class_communication.errors.full_messages).to include('ユーザーを入力してください')
    end
  end
end
