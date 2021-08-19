require 'rails_helper'

RSpec.describe Like, type: :model do
  before do
    @like = FactoryBot.build(:like)
  end

  context '内容に問題がない場合' do
    it '全ての情報があれば登録できる' do
      expect(@like).to be_valid
    end
  end

  context '内容に問題がある場合' do
    it 'userが紐付いていないと登録できない' do
      @like.user = nil
      @like.valid?
      expect(@like.errors.full_messages).to include('ユーザーを入力してください')
    end

    it 'class_communicationが紐付いていないと登録できない' do
      @like.class_communication = nil
      @like.valid?
      expect(@like.errors.full_messages).to include('学級通信を入力してください')
    end
  end
end