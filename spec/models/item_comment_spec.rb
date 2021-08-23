require 'rails_helper'

RSpec.describe ItemComment, type: :model do
<<<<<<< Updated upstream
  pending "add some examples to (or delete) #{__FILE__}"
=======
  before do
    @item_comment = FactoryBot.build(:item_comment)
  end

  context '内容に問題がない場合' do
    it '全ての情報があれば登録できる' do
      expect(@item_comment).to be_valid
    end
  end

  context '内容に問題がある場合' do
    it 'commentが空だと登録できない' do
      @item_comment.comment = ''
      @item_comment.valid?
      expect(@item_comment.errors.full_messages).to include('コメントを入力してください')
    end

    it 'userが紐付いていないと登録できない' do
      @item_comment.user = nil
      @item_comment.valid?
      expect(@item_comment.errors.full_messages).to include('ユーザーを入力してください')
    end

    it 'diaryが紐付いていないと登録できない' do
      @item_comment.item = nil
      @item_comment.valid?
      expect(@item_comment.errors.full_messages).to include('商品を入力してください')
    end
  end
>>>>>>> Stashed changes
end
