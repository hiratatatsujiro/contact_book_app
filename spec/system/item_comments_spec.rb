require 'rails_helper'

RSpec.describe '商品コメント', type: :system do
  before do
    @item = FactoryBot.create(:item)
    @item_comment = Faker::Lorem.sentence
  end

  it 'ログインしたユーザーは商品詳細ページでコメント投稿できる' do
    # ログインする
    visit new_user_session_path
    fill_in 'user[email]', with: @item.user.email
    fill_in 'user[password]', with: @item.user.password
    find('input[name="commit"]').click
    expect(current_path).to eq(root_path)
    # 商品一覧ページに遷移する
    visit items_path
    # 商品詳細ボタンが存在する
    expect(page).to have_link @item.name, href: item_path(@item)
    # 日記詳細ページに遷移する
    visit item_path(@item)
    # フォームに情報を入力する
    fill_in 'item_comment[comment]', with: @item_comment
    # コメントを送信すると、Commentモデルのカウントが1上がることを確認する
    expect{
      find('input[name="commit"]').click
    }.to change { ItemComment.count }.by(1)
    # 詳細ページにリダイレクトされることを確認する
    expect(current_path).to eq item_path(@item)
    # 詳細ページ上に先ほどのコメント内容が含まれていることを確認する
    expect(page).to have_content(@item_comment)
  end
end
