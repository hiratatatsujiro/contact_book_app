require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context 'ユーザー新規登録ができるとき' do 
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      image_path = Rails.root.join('public/images/user.png')
      attach_file('user[image]',image_path, make_visible: true)
      fill_in 'user[nickname]', with: @user.nickname
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      fill_in 'user[password_confirmation]', with: @user.password_confirmation
      fill_in 'user[introduction]', with: @user.introduction
      fill_in 'user[last_name]', with: @user.last_name
      fill_in 'user[first_name]', with: @user.first_name
      fill_in 'user[last_name_reading]', with: @user.last_name_reading
      fill_in 'user[first_name_reading]', with: @user.first_name_reading
      select @user.grade.name, from: 'user[grade_id]'
      select @user.classroom.name, from: 'user[classroom_id]'
      select @user.number.name, from: 'user[number_id]'
      select 1988 ,from: 'user[birthday(1i)]'
      select 2 ,from: 'user[birthday(2i)]'
      select 9 ,from: 'user[birthday(3i)]'
      
      
      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(1)
      # トップページへ遷移することを確認する
      expect(current_path).to eq(root_path)
      # カーソルを合わせるとログアウトボタンが表示されることを確認する
      expect(page).to have_content('ログアウト')
      # サインアップページへ遷移するボタンやログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end

  context 'ユーザー新規登録ができないとき' do
    # it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
    #   # トップページに移動する
    #   visit root_path
    #   # トップページにサインアップページへ遷移するボタンがあることを確認する
    #   expect(page).to have_content('新規登録')
    #   # 新規登録ページへ移動する
    #   visit new_user_registration_path
    #   # ユーザー情報を入力する
    #   image_path = Rails.root.join('')
    #   attach_file('user[image]',image_path, make_visible: true)
    #   fill_in 'user[nickname]', with: ""
    #   fill_in 'user[email]', with: ""
    #   fill_in 'user[password]', with: ""
    #   fill_in 'user[password_confirmation]', with: ""
    #   fill_in 'user[introduction]', with: ""
    #   fill_in 'user[last_name]', with: ""
    #   fill_in 'user[first_name]', with: ""
    #   fill_in 'user[last_name_reading]', with: ""
    #   fill_in 'user[first_name_reading]', with: ""
    #   select "--", from: 'user[grade_id]'
    #   select "--", from: 'user[classroom_id]'
    #   select "--", from: 'user[number_id]'
    #   select "--" ,from: 'user[birthday(1i)]'
    #   select "--" ,from: 'user[birthday(2i)]'
    #   select "--",from: 'user[birthday(3i)]'
      
    #   # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
    #   expect{
    #     find('input[name="commit"]').click
    #   }.to change { User.count }.by(0)
    #   # 新規登録ページへ戻されることを確認する
    #   expect(current_path).to eq user_registration_path
    # end
  end
end

RSpec.describe 'ログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end
  context 'ログインができるとき' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit new_user_session_path
      # 正しいユーザー情報を入力する
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移することを確認する
      expect(current_path).to eq(root_path)
      # ログアウトボタンが表示されることを確認する
      expect(page).to have_content('ログアウト')
      # サインアップページへ遷移するボタンやログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
  context 'ログインができないとき' do
    it '保存されているユーザーの情報と合致しないとログインができない' do
      # トップページに移動する
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content('ログイン')
      # ログインページへ遷移する
      visit new_user_session_path
      # ユーザー情報を入力する
      fill_in 'user[email]', with: ""
      fill_in 'user[password]', with: ""
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページへ戻されることを確認する
      expect(current_path).to eq(new_user_session_path)
    end
  end
end