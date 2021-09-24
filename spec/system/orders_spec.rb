require 'rails_helper'

RSpec.describe 'OrderInfomations', type: :system do
  let!(:user){FactoryBot.create(:user)}
  let!(:item){FactoryBot.create(:item)}
  let!(:order_information){FactoryBot.create(:order_information, item_id: item.id)}


  context '商品購入ができるとき'do
    it 'ログインしたユーザーは商品購入できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 商品一覧ページへのボタンがあることを確認する
      expect(page).to have_content('フリーマーケット')
      # 商品一覧ページに移動する
      visit items_path
      # 商品詳細ボタンがあることを確認する
      expect(page).to have_content(item.name)
      # 商品詳細ページに移動する
      visit item_path(item)
      # 購入画面に進むボタンがあることを確認する
      expect(page).to have_content('購入画面に進む')
      # 商品購入ページに移動する
      visit item_orders_path(item.id)
      # フォームに情報を入力する
      fill_in 'order_information[number]', with: 424242424242424242
      fill_in 'order_information[exp_month]', with: 3
      fill_in 'order_information[exp_year]', with: 23
      fill_in 'order_information[cvc]', with: 123
      fill_in 'order_information[postal_code]', with: order_information.postal_code
      select  "福岡県", from: 'order_information[delivery_area_id]'
      fill_in 'order_information[city]', with: order_information.city
      fill_in 'order_information[house_number]', with: order_information.house_number
      fill_in 'order_information[building]', with: order_information.building
      fill_in 'order_information[phone_number]', with: order_information.phone_number
      # 購入ボタンを押す
      find('input[name="commit"]').click 
      # トップページには"soldout"が存在することを確認する
      expect(page).to have_content("Sold Out!!")
  end
  end

  context '商品購入ができないとき'do
    it 'ログインしていないと学級通信投稿ページに遷移できない' do
     # トップページにいる
     visit root_path
     # 商品一覧ページへのボタンがあることを確認する
     expect(page).to have_content('フリーマーケット')
     # 商品一覧ページに移動する
     visit items_path
     # ログインページへ戻されることを確認する
     expect(current_path).to eq(new_user_session_path)
    end
  end
end


