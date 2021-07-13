require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end

  context '内容に問題がない場合' do
    it '全ての情報があれば登録できる' do
      expect(@comment).to be_valid
    end
  end

  context '内容に問題がある場合' do
    it 'commentが空だと登録できない' do
      @comment.comment = ""
      @comment.valid?
      expect(@comment.errors.full_messages).to include("Comment can't be blank")  
    end

    it 'userが紐付いていないと登録できない' do
      @comment.user = nil
      @comment.valid?
      expect(@comment.errors.full_messages).to include("User must exist")  
    end

    it 'diaryが紐付いていないと登録できない' do
      @comment.diary = nil
      @comment.valid?
      expect(@comment.errors.full_messages).to include("Diary must exist")  
    end
    
  end
end
