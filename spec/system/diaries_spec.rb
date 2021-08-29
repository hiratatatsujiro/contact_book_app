require 'rails_helper'

RSpec.describe 'Diaries', type: :system do
  before do
    @diary = FactoryBot.create(:diary)
  end

  context '日記投稿ができるとき'do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @diary.user.email
      fill_in 'user[password]', with: @diary.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 日記覧ページへのボタンがあることを確認する
      expect(page).to have_content('日記')
      # 日記一覧ページに移動する
      visit diaries_path
      # 日記投稿ボタンがあることを確認する
      expect(page).to have_content('日記を書く')
      # 日記投稿ページに移動する
      visit new_diary_path
      # フォームに情報を入力する
      select 2021 ,from: 'diary[diary_day(1i)]'
      select 4 ,from: 'diary[diary_day(2i)]'
      select 4 ,from: 'diary[diary_day(3i)]'
      image_path = Rails.root.join('public/images/user.png')
      attach_file('diary[image]',image_path, make_visible: true)
      fill_in 'diary[title]', with: @diary.title
      fill_in 'diary[diary]', with: @diary.diary
      # 送信するとdiaryモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Diary.count }.by(1)
      # トップページには先ほど投稿した内容の日記が存在することを確認する（画像）
      expect(page).to have_selector("img[src$='user.png']")
      # トップページには先ほど投稿した内容の日記タイトルが存在することを確認する（テキスト）
      expect(page).to have_content(@diary.title)
      expect(page).to have_content(@diary.diary)
      expect(page).to have_content(@diary.diary_day)
  end
  end

  context '日記投稿ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
     # トップページにいる
     visit root_path
     # 連絡一覧ページへのボタンがあることを確認する
     expect(page).to have_content('日記')
     # 連絡一覧ページに移動する
     visit diaries_path
     # ログインページへ戻されることを確認する
     expect(current_path).to eq(new_user_session_path)
    end
  end
end

RSpec.describe '日記編集', type: :system do
  before do
    @diary = FactoryBot.create(:diary, diary_day: "2021-02-09")
    @diary2 = FactoryBot.create(:diary)
  end

  context '日記編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿した連絡の編集ができる' do
     # 連絡を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @diary.user.email
      fill_in 'user[password]', with: @diary.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 連絡一覧ページへのボタンがあることを確認する
      expect(page).to have_content('日記')
      # 連絡一覧ページに移動する
      visit diaries_path
      # 新規投稿ボタンがあることを確認する
      expect(page).to have_link @diary.title, href: diary_path(@diary)
      # 新規投稿ページに移動する
      visit diary_path(@diary)
      # 連絡詳細ボタンがあることを確認する
      expect(page).to have_link '編集する', href: edit_diary_path(@diary)
      # トップページには先ほど投稿した内容の連絡が存在することを確認する（テキスト）
      visit edit_diary_path(@diary)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(
        find('#diary_diary_day_1i').value
      ).to eq("2021")
      expect(
        find('#diary_diary_day_2i').value
      ).to eq("2")
      expect(
        find('#diary_diary_day_3i').value
      ).to eq("9")
      expect(
        find('#title').value
      ).to eq(@diary.title)
      expect(
        find('#diary').value
      ).to eq(@diary.diary)
      # 連絡内容を編集する
      select 2021 ,from: 'diary[diary_day(1i)]'
      select 6 ,from: 'diary[diary_day(2i)]'
      select 9 ,from: 'diary[diary_day(3i)]'
      image_path = Rails.root.join('public/images/user.png')
      attach_file('diary[image]',image_path, make_visible: true)
      fill_in 'diary[title]', with: @diary.title + "編集したテキスト"
      fill_in 'diary[diary]', with: @diary.diary + "編集したテキスト"
      # 編集してもTweetモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Diary.count }.by(0)
      # 連絡一覧ページに遷移することを確認する
      expect(current_path).to eq(diaries_path)
      # トップページには先ほど投稿した内容の連絡が存在することを確認する（画像）
      expect(page).to have_selector("img[src$='user.png']")
      # トップページには先ほど投稿した内容の連絡が存在することを確認する
      expect(page).to have_content(@diary.title)
      # トップページには先ほど投稿した内容の日記が存在することを確認する
      expect(page).to have_content(@diary.diary)
    end
  end

   context '日記編集ができないとき' do
     it 'ログインしたユーザーは自分以外が投稿した日記の編集画面には遷移できない' do
      # ユーザーでログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @diary.user.email
      fill_in 'user[password]', with: @diary.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 日記一覧ページへのボタンがあることを確認する
      expect(page).to have_content('日記')
      # 日記一覧ページに移動する
      visit diaries_path
      # 日記投稿ボタンがあることを確認する
      expect(page).to have_no_link @diary2.created_at.strftime('%Y/%m/%d %H:%M'), href: diary_path(@diary2)
    end
    it 'ログインしていないとにの日記編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # 日記一覧ページへのボタンがあることを確認する
      expect(page).to have_content('日記')
      # 日記一覧ページに移動する
      visit contacts_path
      # ログインページへ戻されることを確認する
      expect(current_path).to eq(new_user_session_path)
    end
  end
end

RSpec.describe '削除', type: :system do
  before do
    @diary1 = FactoryBot.create(:diary)
    @diary2 = FactoryBot.create(:diary)
  end
  context '日記削除ができるとき' do
    it 'ログインしたユーザーは自らが投稿した日記の削除ができる' do
      #diary1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @diary1.user.email
      fill_in 'user[password]', with: @diary1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
       # 日記一覧ページへのボタンがあることを確認する
       expect(page).to have_content('日記')
       # 日記一覧ページに移動する
       visit diaries_path
       # 日記投稿ボタンがあることを確認する
       expect(page).to have_link @diary1.title, href: diary_path(@diary1)
       # 日記投稿ページに移動する
       visit diary_path(@diary1)
       # 日記1に「削除」のリンクがあることを確認する
       expect(page).to have_link '削除', href: diary_path(@diary1)
       # 日記を削除するとレコードの数が1減ることを確認する
       expect{
       (page).find_link('削除', href: diary_path(@diary1)).click
       }.to change { Diary.count }.by(-1)
       # 日記一覧画面へ遷移する
       visit diaries_path
       # トップページには日記1の内容が存在しないことを確認する
       expect(page).to have_no_link @diary1.title, href: diary_path(@diary1)
    end
  end
  context '日記削除ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿した日記の削除ができない' do
      # 日記1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @diary1.user.email
      fill_in 'user[password]', with: @diary1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 日記一覧ページへのボタンがあることを確認する
      expect(page).to have_content('日記')
      # 日記一覧ページに移動する
      visit contacts_path
      # 日記詳細ボタンがないことを確認する
      expect(page).to have_no_link @diary2.created_at.strftime('%Y/%m/%d %H:%M'), href: diary_path(@diary2)
    end

    it 'ログインしていないと日記削除ボタンがない' do
      # トップページにいる
      visit root_path
      # 日記一覧ページへのボタンがあることを確認する
      expect(page).to have_content('日記')
      # 日記一覧ページに移動する
      visit diaries_path
      # ログインページへ戻されることを確認する
      expect(current_path).to eq(new_user_session_path)
    end
  end
end

RSpec.describe '日記詳細', type: :system do
  before do
    @diary = FactoryBot.create(:diary)
  end
  it 'ログインしたユーザーは日記詳細ページに遷移してコメント投稿欄が表示される' do
    # ログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @diary.user.email
      fill_in 'user[password]', with: @diary.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 連絡一覧ページへのボタンがあることを確認する
      expect(page).to have_content('日記')
       # 連絡一覧ページに移動する
      visit diaries_path
      # 連絡詳細ボタンがあることを確認する
      expect(page).to have_link @diary.title, href: diary_path(@diary)
      # 詳細ページに遷移する
      visit diary_path(@diary)
      # ページに情報が存在する
      expect(page).to have_content("コメント")
    end
  it 'ログインしていない状態で日記詳細ページに遷移できない' do
    # トップページに移動する
    visit root_path
    # 連絡一覧ページへのボタンがあることを確認する
    expect(page).to have_content('日記')
    # 連絡一覧ページに移動する
    visit contacts_path
    # ログインページへ戻されることを確認する
    expect(current_path).to eq(new_user_session_path)
    end
end

