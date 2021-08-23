require 'rails_helper'

RSpec.describe 'Items', type: :system do
  before do
    @item = FactoryBot.create(:item)
  end

  context '商品登録ができるとき' do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @item.user.email
      fill_in 'user[password]', with: @item.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 商品一覧ページへのボタンがあることを確認する
      expect(page).to have_content('フリーマーケット')
      # 商品一覧ページに移動する
      visit items_path
      # 商品投稿ボタンがあることを確認する
      expect(page).to have_content('出品する')
      # 商品投稿ページに移動する
      visit new_item_path
      # フォームに情報を入力する
      image_path = Rails.root.join('public/images/user.png')
      attach_file('item[image]', image_path, make_visible: true)
      fill_in 'item[name]', with: @item.name
      fill_in 'item[introduce]', with: @item.introduce
      select @item.category.name, from: 'item[category_id]'
      select @item.status.name, from: 'item[status_id]'
      select @item.grade.name, from: 'item[grade_id]'
      select @item.size.name, from: 'item[size_id]'
      select @item.pay_for_shopping.name, from: 'item[pay_for_shopping_id]'
      select @item.delivery_area.name, from: 'item[delivery_area_id]'
      select @item.day_to_ship.name, from: 'item[day_to_ship_id]'
      fill_in 'item[price]', with: @item.price
      # 送信するとitemモデルのカウントが1上がることを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Item.count }.by(1)
      # トップページには先ほど投稿した内容の商品が存在することを確認する
      expect(page).to have_selector("img[src$='user.png']")
      expect(page).to have_content(@item.name)
      expect(page).to have_content(@item.price)
      expect(page).to have_content(@item.pay_for_shopping.name)
    end
  end

  context '商品投稿ができないとき' do
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

RSpec.describe '商品編集', type: :system do
  before do
    @item = FactoryBot.create(:item)
    @item2 = FactoryBot.create(:item)
  end

  context '商品編集ができるとき' do
    it 'ログインしたユーザーは商品の編集ができる' do
      # 商品を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @item.user.email
      fill_in 'user[password]', with: @item.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 商品一覧ページへのボタンがあることを確認する
      expect(page).to have_content('フリーマーケット')
      # 商品一覧ページに移動する
      visit items_path
      # 商品詳細ボタンがあることを確認する
      expect(page).to have_link @item.name, href: item_path(@item)
      # 商品詳細ページに移動する
      visit item_path(@item)
      # 編集ボタンがあることを確認する
      expect(page).to have_link '商品の編集', href: edit_item_path(@item)
      # 編集ページに遷移する
      visit edit_item_path(@item)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(
        find('#item-name').value
      ).to eq(@item.name)
      expect(
        find('#item-info').value
      ).to eq(@item.introduce)
      expect(
        find('#item-category').value
      ).to eq(@item.category.id.to_s)
      expect(
        find('#item-sales-status').value
      ).to eq(@item.status.id.to_s)
      expect(
        find('#item-grade').value
      ).to eq(@item.grade.id.to_s)
      expect(
        find('#item-size').value
      ).to eq(@item.size.id.to_s)
      expect(
        find('#item-shipping-fee-status').value
      ).to eq(@item.pay_for_shopping.id.to_s)
      expect(
        find('#item-prefecture').value
      ).to eq(@item.delivery_area.id.to_s)
      expect(
        find('#item-scheduled-delivery').value
      ).to eq(@item.day_to_ship.id.to_s)
      expect(
        find('#item-price').value
      ).to eq(@item.price.to_s)
      # 商品内容を編集する
      image_path = Rails.root.join('public/images/user.png')
      attach_file('item[image]', image_path, make_visible: true)
      fill_in 'item[name]', with: @item.name + '編集したテキスト'
      fill_in 'item[introduce]', with: @item.introduce + '編集したテキスト'
      select '国語', from: 'item[category_id]'
      select '新品・未使用', from: 'item[status_id]'
      select '6年', from: 'item[grade_id]'
      select '100cm', from: 'item[size_id]'
      select '着払い（購入者負担）', from: 'item[pay_for_shopping_id]'
      select '福岡県', from: 'item[delivery_area_id]'
      select '2~3日で発送', from: 'item[day_to_ship_id]'
      fill_in 'item[price]', with: '1200'
      # 編集してもitemモデルのカウントは変わらないことを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Item.count }.by(0)
      # 商品一覧ページに遷移することを確認する
      expect(current_path).to eq(items_path)
      # トップページには先ほど投稿した内容の商品が存在することを確認する
      expect(page).to have_selector("img[src$='user.png']")
      expect(page).to have_content(@item.name)
    end
  end

  context '商品編集ができないとき' do
    it '商品登録したユーザー以外のユーザーは編集画面には遷移できない' do
      # ユーザーでログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @item2.user.email
      fill_in 'user[password]', with: @item2.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 商品一覧ページへのボタンがあることを確認する
      expect(page).to have_content('フリーマーケット')
      # 商品一覧ページに移動する
      visit items_path

      expect(page).to have_link @item.name, href: item_path(@item)
      # 新規投稿ページに移動する
      visit item_path(@item)
      # 商品詳細ボタンがあることを確認する
      expect(page).to have_no_link '編集する', href: edit_item_path(@item)
    end
    it 'ログインしていないとにの商品編集画面には遷移できない' do
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

RSpec.describe '削除', type: :system do
  before do
    @item = FactoryBot.create(:item)
    @item2 = FactoryBot.create(:item)
  end
  context '学級通信削除ができるとき' do
    it 'ログインしたユーザーは自らが投稿した学級通信の削除ができる' do
      # ログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @item.user.email
      fill_in 'user[password]', with: @item.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 商品一覧ページへのボタンがあることを確認する
      expect(page).to have_content('フリーマーケット')
      # 商品一覧ページに移動する
      visit items_path
      # 商品投稿ボタンがあることを確認する
      expect(page).to have_link @item.name, href: item_path(@item)
      # 商品投稿ページに移動する
      visit item_path(@item)
      # 商品に「削除」のリンクがあることを確認する
      expect(page).to have_link '削除', href: item_path(@item)
      # 商品を削除するとレコードの数が1減ることを確認する
      expect do
        page.find_link('削除', href: item_path(@item)).click
      end.to change { Item.count }.by(-1)
      # 商品一覧画面へ遷移する
      visit items_path
      # トップページには商品の内容が存在しないことを確認する
      expect(page).to have_no_link @item.name, href: item_path(@item)
    end
  end
  context '商品削除ができないとき' do
    it '商品を登録したユーザー以外のユーザーは商品を削除できない' do
      # ログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @item.user.email
      fill_in 'user[password]', with: @item.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 商品一覧ページへのボタンがあることを確認する
      expect(page).to have_content('フリーマーケット')
      # 商品一覧ページに移動する
      visit items_path
      # 商品投稿ボタンがあることを確認する
      expect(page).to have_link @item2.name, href: item_path(@item2)
      # 商品投稿ページに移動する
      visit item_path(@item2)
      # 商品に「削除」のリンクがあることを確認する
      expect(page).to have_no_link '削除', href: item_path(@item2)
    end
    it 'ログインしていないと日記削除ボタンがない' do
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

RSpec.describe '商品詳細', type: :system do
  before do
    @item = FactoryBot.create(:item)
  end
  it 'ログインしたユーザーは学級通信詳細ページに遷移してコメント欄が表示される' do
    # ログインする
    visit new_user_session_path
    fill_in 'user[email]', with: @item.user.email
    fill_in 'user[password]', with: @item.user.password
    find('input[name="commit"]').click
    expect(current_path).to eq(root_path)
    # 商品一覧ページへのボタンがあることを確認する
    expect(page).to have_content('フリーマーケット')
    # 商品一覧ページに移動する
    visit items_path
    # 商品詳細ボタンがあることを確認する
    expect(page).to have_link @item.name, href: item_path(@item)
    # 商品詳細ページに遷移する
    visit item_path(@item)
    # ページに情報が存在する
    expect(page).to have_content('コメントする')
  end
  it 'ログインしていない状態で商品詳細ページに遷移できない' do
    # トップページに移動する
    visit root_path
    # 商品一覧ページへのボタンがあることを確認する
    expect(page).to have_content('フリーマーケット')
    # 商品一覧ページに移動する
    visit items_path
    # ログインページへ戻されることを確認する
    expect(current_path).to eq(new_user_session_path)
  end
end
