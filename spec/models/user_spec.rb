require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
    @user.image = fixture_file_upload('app/assets/images/output-image1.png')
  end

  context '内容に問題がない場合' do
    it '全ての情報があれば登録できる' do
      expect(@user).to be_valid
    end
  end

  context '内容に問題がある場合' do
    it 'imageが空だと登録できない' do
      @user.image = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Image can't be blank")
    end

    it 'nicknameが空だと登録できない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it 'emailが空だと登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'emailに@がなければ登録できない' do
      @user.email = 'test'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end

    it 'emailが重複すれば登録できない' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end

    it 'passwordが空だと登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'passwordが5文字以下だと登録できない' do
      @user.password = '111aa'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end

    it 'passwordは半角数字のみでは登録できない' do
      @user.password = '111111'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
    end

    it 'passwordは半角英字のみでは登録できない' do
      @user.password = 'aaaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
    end

    it 'passwordは全角では登録できない' do
      @user.password = 'kLp１１１'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
    end

    it 'password_confirmationが空だと登録できない' do
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'passwordとpassword_confirmationが不一致だと登録できない' do
      @user.password_confirmation = '111bbb'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'introductionが空だと登録できない' do
      @user.introduction = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Introduction can't be blank")
    end

    it 'last_nameが空だと登録できない' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'last_nameが半角英字だと登録できない' do
      @user.last_name = 'hirata'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name is invalid. Input full-width characters.')
    end

    it 'last_nameが半角数字だと登録できない' do
      @user.last_name = '11111'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name is invalid. Input full-width characters.')
    end

    it 'last_nameが半角カタカナだと登録できない' do
      @user.last_name = 'ﾋﾗﾀ'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name is invalid. Input full-width characters.')
    end

    it 'first_nameが空だと登録できない' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'first_nameが半角英字だと登録できない' do
      @user.first_name = 'hirata'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name is invalid. Input full-width characters.')
    end

    it 'first_nameが半角数字だと登録できない' do
      @user.first_name = '11111'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name is invalid. Input full-width characters.')
    end

    it 'first_nameが半角カタカナだと登録できない' do
      @user.first_name = 'ﾋﾗﾀ'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name is invalid. Input full-width characters.')
    end

    it 'last_name_readingが空だと登録できない' do
      @user.last_name_reading = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name reading can't be blank")
    end

    it 'last_name_readingが半角カタカナだと登録できない' do
      @user.last_name_reading = 'ﾋﾗﾀ'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name reading is invalid. Input full-width katakana characters.')
    end

    it 'last_name_readingが半角数字だと登録できない' do
      @user.last_name_reading = '1111'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name reading is invalid. Input full-width katakana characters.')
    end

    it 'last_name_readingが半角英字だと登録できない' do
      @user.last_name_reading = 'aaa'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name reading is invalid. Input full-width katakana characters.')
    end

    it 'last_name_readingが全角ひらがなと登録できない' do
      @user.last_name_reading = 'ひらた'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name reading is invalid. Input full-width katakana characters.')
    end

    it 'last_name_readingが全角英字だと登録できない' do
      @user.last_name_reading = 'ｂｆｃ'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name reading is invalid. Input full-width katakana characters.')
    end

    it 'last_name_readingが全角数字だと登録できない' do
      @user.last_name_reading = '１１１'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name reading is invalid. Input full-width katakana characters.')
    end

    it 'first_name_readingが空だと登録できない' do
      @user.first_name_reading = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name reading can't be blank")
    end

    it 'first_name_readingが半角カタカナだと登録できない' do
      @user.first_name_reading = 'ﾋﾗﾀ'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name reading is invalid. Input full-width katakana characters.')
    end

    it 'first_name_readingが半角数字だと登録できない' do
      @user.first_name_reading = '111'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name reading is invalid. Input full-width katakana characters.')
    end

    it 'first_name_readingが半角英字だと登録できない' do
      @user.first_name_reading = 'aaa'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name reading is invalid. Input full-width katakana characters.')
    end

    it 'first_name_readingが全角ひらがなだと登録できない' do
      @user.first_name_reading = 'ひらた'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name reading is invalid. Input full-width katakana characters.')
    end

    it 'first_name_readingが全角英字だと登録できない' do
      @user.first_name_reading = 'ｓｄｇ'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name reading is invalid. Input full-width katakana characters.')
    end

    it 'first_name_readingが全角数字だと登録できない' do
      @user.first_name_reading = '１１１'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name reading is invalid. Input full-width katakana characters.')
    end

    it 'grade_idが1の場合は登録できない' do
      @user.grade_id = 1
      @user.valid?
      expect(@user.errors.full_messages).to include("Grade can't be blank")
    end

    it 'classroom_idが1の場合は登録できない' do
      @user.classroom_id = 1
      @user.valid?
      expect(@user.errors.full_messages).to include("Classroom can't be blank")
    end

    it 'number_idが1の場合は登録できない' do
      @user.number_id = 1
      @user.valid?
      expect(@user.errors.full_messages).to include("Number can't be blank")
    end

    it 'birthdayが空だと登録できない' do
      @user.birthday = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end
  end
end
