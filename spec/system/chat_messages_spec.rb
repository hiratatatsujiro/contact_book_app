require 'rails_helper'

RSpec.describe 'Chat_messages', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @author = FactoryBot.create(:user)
    @room = FactoryBot.create(:room)
    @chat_message = FactoryBot.create(:chat_message)
  end

<<<<<<< Updated upstream
  context 'チャットメッセージが投稿できるとき'do
=======
  context 'メッセージが投稿できるとき' do
>>>>>>> Stashed changes
    it 'ログインしたユーザーは新規投稿できる' do
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
        expect(current_path).to eq(room_chat_messages_path(@room.id + 2))
        # チャットルームにはルームが存在することを確認する
        expect(page).to have_content(@room.name)
        # 必要情報を入力する
        image_path = Rails.root.join('public/images/user.png')
        attach_file('chat_message[image]',image_path, make_visible: true)
        fill_in 'chat_message[content]', with: @chat_message.content
        # 送信ボタンを押すとroomモデルのカウントが1上がることを確認する
         expect{
          find('input[name="commit"]').click
        }.to change { ChatMessage.count }.by(1)
        # ルームの名前がないことを確認する
        expect(page).to have_content @chat_message.content
    end
  end

  context 'チャットメッセージ投稿ができないとき'do
    it 'ログインしていないとチャットメッセージ投稿ページに遷移できない' do
     # トップページにいる
     visit root_path
     # 連絡一覧ページへのボタンがあることを確認する
     expect(page).to have_content('日記')
     # 連絡一覧ページに移動する
     visit rooms_path
     # ログインページへ戻されることを確認する
     expect(current_path).to eq(new_user_session_path)
    end
  end
end




