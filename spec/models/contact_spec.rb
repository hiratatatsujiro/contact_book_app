require 'rails_helper'

RSpec.describe Contact, type: :model do
<<<<<<< Updated upstream
  pending "add some examples to (or delete) #{__FILE__}"
=======
  before do
    @contact = FactoryBot.build(:contact)
  end

  context '内容に問題がない場合' do
    it '全て入力があれば登録できる' do
      expect(@contact).to be_valid
    end

    it 'conditionが空でも登録できる' do
      @contact.condition_id == 1
      expect(@contact).to be_valid
    end

    it 'reasonが空でも登録できる' do
      @contact.reason == ''
      expect(@contact).to be_valid
    end

    it 'pool_marathonが空でも登録できる' do
      @contact.pool_marathon_id == 1
      expect(@contact).to be_valid
    end

    it 'contactが空でも登録できる' do
      @contact.contact == ''
      expect(@contact).to be_valid
    end
  end

  context '内容に問題がある場合' do
    it 'userが紐付いていないと登録できない' do
      @contact.user = nil
      @contact.valid?
      expect(@contact.errors.full_messages).to include('ユーザーを入力してください')
    end
  end
>>>>>>> Stashed changes
end
