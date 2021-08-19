require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  context '内容に問題がない場合' do
    it '全ての情報があれば登録できる' do
      expect(@user).to be_valid
    end
  end

  context '内容に問題がある場合' do
    it 'imageが空だと登録できない' do
      @user.image = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("画像を入力してください")
    end

    it 'nicknameが空だと登録できない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("ニックネームを入力してください")
    end

    it 'emailが空だと登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Eメールを入力してください")
    end

    it 'emailに@がなければ登録できない' do
      @user.email = 'test'
      @user.valid?
      expect(@user.errors.full_messages).to include('Eメールは不正な値です')
    end

    it 'emailが重複すれば登録できない' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
    end

    it 'passwordが空だと登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワードを入力してください")
    end

    it 'passwordが5文字以下だと登録できない' do
      @user.password = '111aa'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
    end

    it 'passwordは半角数字のみでは登録できない' do
      @user.password = '111111'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードに誤りがあります。文字と数字の両方を含める必要があります')
    end

    it 'passwordは半角英字のみでは登録できない' do
      @user.password = 'aaaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードに誤りがあります。文字と数字の両方を含める必要があります')
    end

    it 'passwordは全角では登録できない' do
      @user.password = 'kLp１１１'
      @user.valid?
      expect(@user.errors.full_messages).to include('パスワードに誤りがあります。文字と数字の両方を含める必要があります')
    end

    it 'password_confirmationが空だと登録できない' do
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
    end

    it 'passwordとpassword_confirmationが不一致だと登録できない' do
      @user.password_confirmation = '111bbb'
      @user.valid?
      expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
    end

    it 'introductionが空だと登録できない' do
      @user.introduction = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("自己紹介を入力してください")
    end

    it 'last_nameが空だと登録できない' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("苗字を入力してください")
    end

    it 'last_nameが半角英字だと登録できない' do
      @user.last_name = 'hirata'
      @user.valid?
      expect(@user.errors.full_messages).to include('苗字に誤りがあります。全角で入力してください')
    end

    it 'last_nameが半角数字だと登録できない' do
      @user.last_name = '11111'
      @user.valid?
      expect(@user.errors.full_messages).to include('苗字に誤りがあります。全角で入力してください')
    end

    it 'last_nameが半角カタカナだと登録できない' do
      @user.last_name = 'ﾋﾗﾀ'
      @user.valid?
      expect(@user.errors.full_messages).to include('苗字に誤りがあります。全角で入力してください')
    end

    it 'first_nameが空だと登録できない' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("名前を入力してください")
    end

    it 'first_nameが半角英字だと登録できない' do
      @user.first_name = 'hirata'
      @user.valid?
      expect(@user.errors.full_messages).to include('名前に誤りがあります。全角で入力してください')
    end

    it 'first_nameが半角数字だと登録できない' do
      @user.first_name = '11111'
      @user.valid?
      expect(@user.errors.full_messages).to include('名前に誤りがあります。全角で入力してください')
    end

    it 'first_nameが半角カタカナだと登録できない' do
      @user.first_name = 'ﾋﾗﾀ'
      @user.valid?
      expect(@user.errors.full_messages).to include('名前に誤りがあります。全角で入力してください')
    end

    it 'last_name_readingが空だと登録できない' do
      @user.last_name_reading = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("苗字の読み方を入力してください")
    end

    it 'last_name_readingが半角カタカナだと登録できない' do
      @user.last_name_reading = 'ﾋﾗﾀ'
      @user.valid?
      expect(@user.errors.full_messages).to include('苗字の読み方に誤りがあります。全角カタカナで入力してください')
    end

    it 'last_name_readingが半角数字だと登録できない' do
      @user.last_name_reading = '1111'
      @user.valid?
      expect(@user.errors.full_messages).to include('苗字の読み方に誤りがあります。全角カタカナで入力してください')
    end

    it 'last_name_readingが半角英字だと登録できない' do
      @user.last_name_reading = 'aaa'
      @user.valid?
      expect(@user.errors.full_messages).to include('苗字の読み方に誤りがあります。全角カタカナで入力してください')
    end

    it 'last_name_readingが全角ひらがなと登録できない' do
      @user.last_name_reading = 'ひらた'
      @user.valid?
      expect(@user.errors.full_messages).to include('苗字の読み方に誤りがあります。全角カタカナで入力してください')
    end

    it 'last_name_readingが全角英字だと登録できない' do
      @user.last_name_reading = 'ｂｆｃ'
      @user.valid?
      expect(@user.errors.full_messages).to include('苗字の読み方に誤りがあります。全角カタカナで入力してください')
    end

    it 'last_name_readingが全角数字だと登録できない' do
      @user.last_name_reading = '１１１'
      @user.valid?
      expect(@user.errors.full_messages).to include('苗字の読み方に誤りがあります。全角カタカナで入力してください')
    end

    it 'first_name_readingが空だと登録できない' do
      @user.first_name_reading = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("名前の読み方を入力してください")
    end

    it 'first_name_readingが半角カタカナだと登録できない' do
      @user.first_name_reading = 'ﾋﾗﾀ'
      @user.valid?
      expect(@user.errors.full_messages).to include('名前の読み方に誤りがあります。全角カタカナで入力してください')
    end

    it 'first_name_readingが半角数字だと登録できない' do
      @user.first_name_reading = '111'
      @user.valid?
      expect(@user.errors.full_messages).to include('名前の読み方に誤りがあります。全角カタカナで入力してください')
    end

    it 'first_name_readingが半角英字だと登録できない' do
      @user.first_name_reading = 'aaa'
      @user.valid?
      expect(@user.errors.full_messages).to include('名前の読み方に誤りがあります。全角カタカナで入力してください')
    end

    it 'first_name_readingが全角ひらがなだと登録できない' do
      @user.first_name_reading = 'ひらた'
      @user.valid?
      expect(@user.errors.full_messages).to include('名前の読み方に誤りがあります。全角カタカナで入力してください')
    end

    it 'first_name_readingが全角英字だと登録できない' do
      @user.first_name_reading = 'ｓｄｇ'
      @user.valid?
      expect(@user.errors.full_messages).to include('名前の読み方に誤りがあります。全角カタカナで入力してください')
    end

    it 'first_name_readingが全角数字だと登録できない' do
      @user.first_name_reading = '１１１'
      @user.valid?
      expect(@user.errors.full_messages).to include('名前の読み方に誤りがあります。全角カタカナで入力してください')
    end

    it 'grade_idが1の場合は登録できない' do
      @user.grade_id = 1
      @user.valid?
      expect(@user.errors.full_messages).to include("学年を選択して下さい")
    end

    it 'classroom_idが1の場合は登録できない' do
      @user.classroom_id = 1
      @user.valid?
      expect(@user.errors.full_messages).to include("組を選択して下さい")
    end

    it 'number_idが1の場合は登録できない' do
      @user.number_id = 1
      @user.valid?
      expect(@user.errors.full_messages).to include("出席番号を選択して下さい")
    end

    it 'birthdayが空だと登録できない' do
      @user.birthday = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("生年月日を入力してください")
    end
  end
end
