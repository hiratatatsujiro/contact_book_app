require 'rails_helper'

RSpec.describe OrderInformation, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_information = FactoryBot.build(:order_information, user_id: user.id, item_id: item.id)
    sleep 0.1
  end
  context '内容に問題がない場合' do
    it 'tokenと住所情報等が適切に入力されていれば登録できる' do
      expect(@order_information).to be_valid
    end

    it 'buildingがなくても登録できる' do
      @order_information.building = ''
      expect(@order_information).to be_valid
    end
  end

  context '内容に問題がある場合' do
    it 'tokenがなければ保存できない' do
      @order_information.token = ''
      @order_information.valid?
<<<<<<< Updated upstream
      expect(@order_information.errors.full_messages).to include("Token can't be blank")
=======
      expect(@order_information.errors.full_messages).to include('カード情報を入力してください')
>>>>>>> Stashed changes
    end

    it 'postal_codeがなければ保存できない' do
      @order_information.postal_code = ''
      @order_information.valid?
<<<<<<< Updated upstream
      expect(@order_information.errors.full_messages).to include("Postal code can't be blank")
=======
      expect(@order_information.errors.full_messages).to include('郵便番号を入力してください')
>>>>>>> Stashed changes
    end

    it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
      @order_information.postal_code = '8301211'
      @order_information.valid?
      expect(@order_information.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
    end

    it 'postal_codeが全角数字だと保存できないこと' do
      @order_information.postal_code = '８３０１２１１'
      @order_information.valid?
      expect(@order_information.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
    end

    it 'postal_codeが全角ひらがなだと保存できないこと' do
      @order_information.postal_code = 'あいう-えおかき'
      @order_information.valid?
      expect(@order_information.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
    end

    it 'postal_codeが全角英字だと保存できないこと' do
      @order_information.postal_code = 'ｋｋｋ-ｋｋｋｋ'
      @order_information.valid?
      expect(@order_information.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
    end

    it 'postal_codeが全角カタカナだと保存できないこと' do
      @order_information.postal_code = 'アイウ-エオカキ'
      @order_information.valid?
      expect(@order_information.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
    end

    it 'postal_codeが半角カタカナだと保存できないこと' do
      @order_information.postal_code = 'ｱｲｳ-ｴｵｶｷ'
      @order_information.valid?
      expect(@order_information.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
    end

    it 'postal_codeが半角英字だと保存できないこと' do
      @order_information.postal_code = 'aaa-aaaa'
      @order_information.valid?
      expect(@order_information.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
    end

    it 'delivery_area_idが1ならば保存できない' do
      @order_information.delivery_area_id = 1
      @order_information.valid?
<<<<<<< Updated upstream
      expect(@order_information.errors.full_messages).to include("Delivery area can't be blank")
=======
      expect(@order_information.errors.full_messages).to include('都道府県を選択してください')
>>>>>>> Stashed changes
    end

    it 'cityがなければ保存できない' do
      @order_information.city = ''
      @order_information.valid?
<<<<<<< Updated upstream
      expect(@order_information.errors.full_messages).to include("City can't be blank")
=======
      expect(@order_information.errors.full_messages).to include('市区町村を入力してください')
>>>>>>> Stashed changes
    end

    it 'house_numberがなければ保存できない' do
      @order_information.house_number = ''
      @order_information.valid?
<<<<<<< Updated upstream
      expect(@order_information.errors.full_messages).to include("House number can't be blank")
=======
      expect(@order_information.errors.full_messages).to include('番地を入力してください')
>>>>>>> Stashed changes
    end

    it 'phone_numberがなければ保存できない' do
      @order_information.phone_number = ''
      @order_information.valid?
<<<<<<< Updated upstream
      expect(@order_information.errors.full_messages).to include("Phone number can't be blank")
=======
      expect(@order_information.errors.full_messages).to include('電話番号を入力してください')
>>>>>>> Stashed changes
    end

    it 'phone_numberが9字以下ならば保存できない' do
      @order_information.phone_number = '090434888'
      @order_information.valid?
      expect(@order_information.errors.full_messages).to include('Phone number is too short')
    end

    it 'phone_numberが12字以上であれば保存できない' do
      @order_information.phone_number = '09011112222345'
      @order_information.valid?
      expect(@order_information.errors.full_messages).to include('Phone number is too long')
    end

    it 'phone_numberが全角数字だと保存できないこと' do
      @order_information.phone_number = '０９０１１１１２２２２'
      @order_information.valid?
      expect(@order_information.errors.full_messages).to include('Phone number is invalid. Input only number')
    end

    it 'phone_numberが全角ひらがなだと保存できないこと' do
      @order_information.phone_number = 'あいうえおかきくけこさ'
      @order_information.valid?
      expect(@order_information.errors.full_messages).to include('Phone number is invalid. Input only number')
    end

    it 'phone_numberが全角英字だと保存できないこと' do
      @order_information.phone_number = 'ｋｋｋｋｋｋｋｋｋｋｋ'
      @order_information.valid?
      expect(@order_information.errors.full_messages).to include('Phone number is invalid. Input only number')
    end

    it 'phone_numberが全角カタカナだと保存できないこと' do
      @order_information.phone_number = 'ｱｲｳｴｵｶｷｸｹｺｻ'
      @order_information.valid?
      expect(@order_information.errors.full_messages).to include('Phone number is invalid. Input only number')
    end

    it 'phone_numberが半角カタカナだと保存できないこと' do
      @order_information.phone_number = 'ｱｲｳｴｵｶｷｸｹｺｻ'
      @order_information.valid?
      expect(@order_information.errors.full_messages).to include('Phone number is invalid. Input only number')
    end

    it 'phone_numberが半角英字だと保存できないこと' do
      @order_information.phone_number = 'aaabbbbcccc'
      @order_information.valid?
      expect(@order_information.errors.full_messages).to include('Phone number is invalid. Input only number')
    end

    it 'phone_numberが英数混合では登録できないこと' do
      @order_information.phone_number = '0942-77-001'
      @order_information.valid?
      expect(@order_information.errors.full_messages).to include('Phone number is invalid. Input only number')
    end

    it 'user_idが空なら保存できない' do
      @order_information.user_id = ''
      @order_information.valid?
<<<<<<< Updated upstream
      expect(@order_information.errors.full_messages).to include("User can't be blank")
=======
      expect(@order_information.errors.full_messages).to include('Userを入力してください')
>>>>>>> Stashed changes
    end

    it 'item_idが空ならば保存できない' do
      @order_information.item_id = ''
      @order_information.valid?
<<<<<<< Updated upstream
      expect(@order_information.errors.full_messages).to include("Item can't be blank")
=======
      expect(@order_information.errors.full_messages).to include('Itemを入力してください')
>>>>>>> Stashed changes
    end
  end
end
