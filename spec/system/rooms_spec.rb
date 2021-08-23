require 'rails_helper'

RSpec.describe 'Rooms', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @author = FactoryBot.create(:user)
    @room = FactoryBot.create(:room)
  end

  context 'チャットルーム作成ができるとき'do
    it 'ログインしたユーザーは新規ルーム作成できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # ルーム一覧ページへのボタンがあることを確認する
      expect(page).to have_content('チャットルーム')
      # ルーム一覧ページに移動する
      visit rooms_path
      # 新規投稿ボタンがあることを確認する
      expect(page).to have_content('チャットルーム作成')
      # 新規投稿ページに移動する
      visit new_room_path
      # フォームに情報を入力する
      fill_in 'room[name]', with: @room.name
      find(:css, "#room_user_ids_#{@author.id}").set(true)
      # 送信するとroomモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Room.count }.by(1)
      # ルーム一覧ページに遷移することを確認する
      expect(current_path).to eq(room_chat_messages_path(@room.id + 1))
      # トップページには先ほど投稿した内容の連絡が存在することを確認する
      expect(page).to have_content(@room.name)
    end
  end

  context '時間わり投稿ができないとき'do
    it 'ログインしていないと時間わり投稿ページに遷移できない' do
     # トップページにいる
     visit root_path
     # ルーム一覧ページへのボタンがあることを確認する
     expect(page).to have_content('チャットルーム')
     # ルーム一覧ページに移動する
     visit rooms_path
     # ログインページへ戻されることを確認する
     expect(current_path).to eq(new_user_session_path)
    end
  end
end

RSpec.describe '削除', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @author = FactoryBot.create(:user)
    @room = FactoryBot.create(:room)
  end
  context 'ルーム削除ができるとき' do
    it 'ログインしたユーザーは作成したルームの削除ができる' do
      visit new_user_session_path
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # ルーム一覧ページへのボタンがあることを確認する
      expect(page).to have_content('チャットルーム')
      # ルーム一覧ページに移動する
      visit rooms_path
      # 新規投稿ボタンがあることを確認する
      expect(page).to have_content('チャットルーム作成')
      # 新規投稿ページに移動する
      visit new_room_path
      # フォームに情報を入力する
      fill_in 'room[name]', with: @room.name
      find(:css, "#room_user_ids_#{@author.id}").set(true)
      # 送信するとroomモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Room.count }.by(1)
      # チャットルームのページに遷移することを確認する
      expect(current_path).to eq(room_chat_messages_path(@room.id + 1))
      # チャットルームには削除ボタンが存在することを確認する
      expect(page).to have_content("チャットを削除する")
      # 削除ボタンを押すとroomモデルのカウントが1下がることを確認する
       expect{
        find('.chatroom-end a').click
      }.to change { Room.count }.by(-1)
      # ルーム一覧ページに移動する
      visit rooms_path
      # ルームの名前がないことを確認する
      expect(page).to have_no_link @room.name
    end
  end
  context '時間わり削除ができないとき' do
    it 'ログインしていないと削除ボタンがない' do
      # トップページにいる
      visit root_path
      # ルーム一覧ページへのボタンがあることを確認する
      expect(page).to have_content('チャットルーム')
      # ルーム一覧ページに移動する
      visit rooms_path
      # ログインページへ戻されることを確認する
      expect(current_path).to eq(new_user_session_path)
    end
  end
end

