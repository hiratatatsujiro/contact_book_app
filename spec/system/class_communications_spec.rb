require 'rails_helper'

RSpec.describe 'ClassCommunications', type: :system do
  before do
    @user_teacher = FactoryBot.create(:user, number_id: 52)
    @class_communication = FactoryBot.create(:class_communication, user_id: @user_teacher.id)
    @user_child = FactoryBot.create(:user, grade_id: @user_teacher.grade_id, classroom_id: @user_teacher.classroom_id)
  end

  context '学級通信投稿ができるとき'do
    it 'ログインしたid=52ユーザーは新規投稿できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @user_teacher.email
      fill_in 'user[password]', with: @user_teacher.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 学級通信一覧ページへのボタンがあることを確認する
      expect(page).to have_content('学級通信')
      # 学級通信一覧ページに移動する
      visit class_communications_path
      # 学級通信投稿ボタンがあることを確認する
      expect(page).to have_content('学級通信を書く')
      # 学級通信投稿ページに移動する
      visit new_class_communication_path
      # フォームに情報を入力する
      select 2021 ,from: 'class_communication[class_communication_day(1i)]'
      select 4 ,from: 'class_communication[class_communication_day(2i)]'
      select 4 ,from: 'class_communication[class_communication_day(3i)]'
      image_path = Rails.root.join('public/images/user.png')
      attach_file('class_communication[images][]',image_path, make_visible: true)
      fill_in 'class_communication[title]', with: @class_communication.title
      fill_in 'class_communication[text]', with: @class_communication.text
      # 送信するとclass_communicationモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { ClassCommunication.count }.by(1)
      # トップページには先ほど投稿した内容の学級通信が存在することを確認する
      expect(page).to have_selector("img[src$='user.png']")
      expect(page).to have_content(@class_communication.title)
      expect(page).to have_content(@class_communication.text)
  end
  end

  context '学級通信投稿ができないとき'do
    it 'ログインしていないと学級通信投稿ページに遷移できない' do
     # トップページにいる
     visit root_path
     # 学級通信一覧ページへのボタンがあることを確認する
     expect(page).to have_content('学級通信')
     # 学級通信一覧ページに移動する
     visit class_communications_path
     # ログインページへ戻されることを確認する
     expect(current_path).to eq(new_user_session_path)
    end
    it 'ログインしていても、id=52以外は投稿できない' do
      # ログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @user_child.email
      fill_in 'user[password]', with: @user_child.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # トップページにいる
      visit root_path
      # 学級通信一覧ページへのボタンがあることを確認する
      expect(page).to have_content('学級通信')
      # 学級通信一覧ページに移動する
      visit class_communications_path
      # ログインページへ戻されることを確認する
      expect(page).to have_no_content('学級通信を書く')
     end
  end
end

RSpec.describe '学級通信編集', type: :system do
  before do
    @user_teacher = FactoryBot.create(:user, number_id: 52)
    @class_communication = FactoryBot.create(:class_communication, class_communication_day: "2021-04-09", user_id: @user_teacher.id)
    @user_child = FactoryBot.create(:user, grade_id: @user_teacher.grade_id, classroom_id: @user_teacher.classroom_id)
  end

  context '学級通信編集ができるとき' do
    it 'ログインしたユーザー（id=52）は学級通信の編集ができる' do
     # 学級通信を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @user_teacher.email
      fill_in 'user[password]', with: @user_teacher.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 学級通信一覧ページへのボタンがあることを確認する
      expect(page).to have_content('学級通信')
      # 学級通信一覧ページに移動する
      visit class_communications_path
      # 学級通信詳細ボタンがあることを確認する
      expect(page).to have_link @class_communication.title, href: class_communication_path(@class_communication)
      # 学級通信詳細ページに移動する
      visit class_communication_path(@class_communication)
      # 編集ボタンがあることを確認する
      expect(page).to have_link '編集する', href: edit_class_communication_path(@class_communication)
      # 編集ページに遷移する
      visit edit_class_communication_path(@class_communication)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(
        find('#class_communication_class_communication_day_1i').value
      ).to eq("2021")
      expect(
        find('#class_communication_class_communication_day_2i').value
      ).to eq("4")
      expect(
        find('#class_communication_class_communication_day_3i').value
      ).to eq("9")
      expect(
        find('#title').value
      ).to eq(@class_communication.title)
      expect(
        find('#text').value
      ).to eq(@class_communication.text)
      # 学級通信内容を編集する
      select 2021 ,from: 'class_communication[class_communication_day(1i)]'
      select 3 ,from: 'class_communication[class_communication_day(2i)]'
      select 24 ,from: 'class_communication[class_communication_day(3i)]'
      image_path = Rails.root.join('public/images/user.png')
      attach_file('class_communication[images][]',image_path, make_visible: true)
      fill_in 'class_communication[title]', with: @class_communication.title + "編集したテキスト"
      fill_in 'class_communication[text]', with: @class_communication.text + "編集したテキスト"
      # 編集してもclass_communicationモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Diary.count }.by(0)
      # 学級通信一覧ページに遷移することを確認する
      expect(current_path).to eq(class_communications_path)
      # トップページには先ほど投稿した内容の学級通信が存在することを確認する
      expect(page).to have_selector("img[src$='user.png']")
      # トップページには先ほど投稿した内容の学級通信が存在することを確認する
      expect(page).to have_content(@class_communication.title)
      # トップページには先ほど投稿した内容の学級通信が存在することを確認する
      expect(page).to have_content(@class_communication.text)
    end
  end

   context '日記編集ができないとき' do
     it 'ログインした(id=52)以外のユーザーは編集画面には遷移できない' do
      # ユーザーでログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @user_child.email
      fill_in 'user[password]', with: @user_child.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 学級通信一覧ページへのボタンがあることを確認する
      expect(page).to have_content('学級通信')
      # 学級通信一覧ページに移動する
      visit class_communications_path

      expect(page).to have_link @class_communication.title, href: class_communication_path(@class_communication)
      # 新規投稿ページに移動する
      visit class_communication_path(@class_communication)
      # 学級通信詳細ボタンがあることを確認する
      expect(page).to have_no_link '編集する', href: edit_class_communication_path(@class_communication)
    end
    it 'ログインしていないとにの学級通信編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # 学級通信一覧ページへのボタンがあることを確認する
      expect(page).to have_content('学級通信')
      # 学級通信一覧ページに移動する
      visit class_communications_path
      # ログインページへ戻されることを確認する
      expect(current_path).to eq(new_user_session_path)
    end
  end
end

RSpec.describe '削除', type: :system do
  before do
    @user_teacher = FactoryBot.create(:user, number_id: 52)
    @class_communication = FactoryBot.create(:class_communication, class_communication_day: "2021-04-09", user_id: @user_teacher.id)
    @user_child = FactoryBot.create(:user, grade_id: @user_teacher.grade_id, classroom_id: @user_teacher.classroom_id)
  end
  context '学級通信削除ができるとき' do
    it 'ログインしたユーザー(id=52)は自らが投稿した学級通信の削除ができる' do
      #(id=52)でログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @user_teacher.email
      fill_in 'user[password]', with: @user_teacher.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
       # 学級通信一覧ページへのボタンがあることを確認する
       expect(page).to have_content('学級通信')
       # 学級通信一覧ページに移動する
       visit class_communications_path
       # 学級通信投稿ボタンがあることを確認する
       expect(page).to have_link @class_communication.title, href: class_communication_path(@class_communication)
       # 学級通信投稿ページに移動する
       visit class_communication_path(@class_communication)
       # 学級通信に「削除」のリンクがあることを確認する
       expect(page).to have_link '削除する', href: class_communication_path(@class_communication)
       # 学級通信を削除するとレコードの数が1減ることを確認する
       expect{
       (page).find_link('削除する', href: class_communication_path(@class_communication)).click
       }.to change { ClassCommunication.count }.by(-1)
       # 学級通信一覧画面へ遷移する
       visit class_communications_path
       # トップページには学級通信の内容が存在しないことを確認する
       expect(page).to have_no_link @class_communication.title, href: class_communication_path(@class_communication)
    end
  end
  context '日記削除ができないとき' do
    it 'ログインしていないと日記削除ボタンがない' do
      # トップページにいる
      visit root_path
      # 学級通信一覧ページへのボタンがあることを確認する
      expect(page).to have_content('学級通信')
      # 学級通信一覧ページに移動する
      visit class_communications_path
      # ログインページへ戻されることを確認する
      expect(current_path).to eq(new_user_session_path)
    end
  end
end

RSpec.describe '学級通信詳細', type: :system do
  before do
    @user_teacher = FactoryBot.create(:user, number_id: 52)
    @class_communication = FactoryBot.create(:class_communication, class_communication_day: "2021-04-09", user_id: @user_teacher.id)
    @user_child = FactoryBot.create(:user, grade_id: @user_teacher.grade_id, classroom_id: @user_teacher.classroom_id)
  end
  it 'ログインしたユーザーは学級通信詳細ページに遷移していいねが表示される' do
    # ログインする
     visit new_user_session_path
     fill_in 'user[email]', with: @user_child.email
     fill_in 'user[password]', with: @user_child.password
     find('input[name="commit"]').click
     expect(current_path).to eq(root_path)
     # 学級通信一覧ページへのボタンがあることを確認する
     expect(page).to have_content('学級通信')
     # 学級通信一覧ページに移動する
     visit class_communications_path
     # 学級通信詳細ボタンがあることを確認する
     expect(page).to have_link @class_communication.title, href: class_communication_path(@class_communication)
     # 学級通信詳細ページに遷移する
     visit class_communication_path(@class_communication)
     # ページに情報が存在する
     expect(page).to have_content("いいね")
    end
  it 'ログインしていない状態で日記詳細ページに遷移できない' do
    # トップページに移動する
    visit root_path
    # 学級通信一覧ページへのボタンがあることを確認する
    expect(page).to have_content('学級通信')
    # 学級通信一覧ページに移動する
    visit class_communications_path
    # ログインページへ戻されることを確認する
    expect(current_path).to eq(new_user_session_path)
    end
end


