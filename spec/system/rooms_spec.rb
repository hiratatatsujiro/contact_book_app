require 'rails_helper'

RSpec.describe 'Rooms', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @author = FactoryBot.create(:user)
    @room = FactoryBot.create(:room)
    @room_user = FactoryBot.create(:room_user)
  end

  context '連絡投稿ができるとき'do
    it 'ログインしたユーザーは新規ルーム作成できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 時間わり一覧ページへのボタンがあることを確認する
      expect(page).to have_content('チャットルーム')
      # 時間わり一覧ページに移動する
      visit rooms_path
      # 新規投稿ボタンがあることを確認する
      expect(page).to have_content('チャットルーム作成')
      # 新規投稿ページに移動する
      visit new_room_path
      # フォームに情報を入力する
      fill_in 'room[name]', with: @room.name
      check "room_user_ids"
      # 送信するとtimetableモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Room.count }.by(1)
      # 時間わり一覧ページに遷移することを確認する
      expect(current_path).to eq(room_chat_messages_path(@room))
      # トップページには先ほど投稿した内容の連絡が存在することを確認する（日付）
      expect(page).to have_content(@room.name)
    end
  end

  context '時間わり投稿ができないとき'do
    it 'ログインしていないと時間わり投稿ページに遷移できない' do
     # トップページにいる
     visit root_path
     # 時間わり一覧ページへのボタンがあることを確認する
     expect(page).to have_content('チャットルーム')
     # 時間わり一覧ページに移動する
     visit rooms_path
     # ログインページへ戻されることを確認する
     expect(current_path).to eq(new_user_session_path)
    end
  end
end

RSpec.describe '削除', type: :system do
  @user = FactoryBot.create(:user)
    @author = FactoryBot.create(:user)
    @room = FactoryBot.create(:room)
    @room_user = FactoryBot.create(:room_user)
  context 'ルーム削除ができるとき' do
    it 'ログインしたユーザーは作成したルームの削除ができる' do
      #ログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @timetable.user.email
      fill_in 'user[password]', with: @timetable.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
       # 時間わり一覧ページへのボタンがあることを確認する
       expect(page).to have_content('時間わり')
       # 時間わり一覧ページに移動する
       visit timetables_path
       # 新規投稿ボタンがあることを確認する
       expect(page).to have_link @timetable.next_day
       # 新規投稿ページに移動する
       visit timetable_path(@timetable)
       # 時間わりに「削除」のリンクがあることを確認する
       expect(page).to have_link '削除', href: timetable_path(@timetable)
       # 投稿を削除するとレコードの数が1減ることを確認する
       expect{
       (page).find_link('削除', href: timetable_path(@timetable)).click
       }.to change { Timetable.count }.by(-1)
       # 時間わり一覧画面へ遷移する
       visit timetables_path
       # トップページには時間わりの内容が存在しないことを確認する
       expect(page).to have_no_link @timetable.next_day
    end
  end
  context '時間わり削除ができないとき' do
    it 'ログインしていないと削除ボタンがない' do
      # トップページにいる
      visit root_path
      # 時間わり一覧ページへのボタンがあることを確認する
      expect(page).to have_content('時間わり')
      # 時間わり一覧ページに移動する
      visit timetables_path
      # ログインページへ戻されることを確認する
      expect(current_path).to eq(new_user_session_path)
    end
  end
end

