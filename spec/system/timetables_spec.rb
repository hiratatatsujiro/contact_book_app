require 'rails_helper'

RSpec.describe 'Timetables', type: :system do
  before do
    @timetable = FactoryBot.create(:timetable)
  end

  context '連絡投稿ができるとき' do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
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
      expect(page).to have_content('時間わり作成')
      # 新規投稿ページに移動する
      visit new_timetable_path
      # フォームに情報を入力する
      select 2021, from: 'timetable[next_day(1i)]'
      select 4, from: 'timetable[next_day(2i)]'
      select 4, from: 'timetable[next_day(3i)]'
      select @timetable.first_class.name, from: 'timetable[first_class_id]'
      select @timetable.second_class.name, from: 'timetable[second_class_id]'
      select @timetable.third_class.name, from: 'timetable[third_class_id]'
      select @timetable.fourth_class.name, from: 'timetable[fourth_class_id]'
      select @timetable.fifth_class.name, from: 'timetable[fifth_class_id]'
      select @timetable.sixth_class.name, from: 'timetable[sixth_class_id]'
      fill_in 'timetable[leave_time]', with: @timetable.leave_time
      fill_in 'timetable[homework]', with: @timetable.homework
      fill_in 'timetable[preparation]', with: @timetable.preparation
      fill_in 'timetable[notice]', with: @timetable.notice
      # 送信するとtimetableモデルのカウントが1上がることを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Timetable.count }.by(1)
      # 時間わり一覧ページに遷移することを確認する
      expect(current_path).to eq(timetables_path)
      # トップページには先ほど投稿した内容の連絡が存在することを確認する（日付）
      expect(page).to have_content(@timetable.next_day)
    end
  end

  context '時間わり投稿ができないとき' do
    it 'ログインしていないと時間わり投稿ページに遷移できない' do
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

RSpec.describe '時間わり編集', type: :system do
  before do
    @timetable = FactoryBot.create(:timetable, next_day: '2021-05-04')
  end

  context '連絡編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿した連絡の編集ができる' do
      # ログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @timetable.user.email
      fill_in 'user[password]', with: @timetable.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 時間わり一覧ページへのボタンがあることを確認する
      expect(page).to have_content('時間わり')
      # 時間わり一覧ページに移動する
      visit timetables_path
      # 時間わり詳細ボタンがあることを確認する
      expect(page).to have_link @timetable.next_day, href: timetable_path(@timetable)
      # 時間わり詳細ページに移動する
      visit timetable_path(@timetable)
      # 時間わりに「編集」へのリンクがあることを確認する
      expect(page).to have_link '編集', href: edit_timetable_path(@timetable)
      # 編集ページへ遷移する
      visit edit_timetable_path(@timetable)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(
        find('#timetable_next_day_1i').value
      ).to eq('2021')
      expect(
        find('#timetable_next_day_2i').value
      ).to eq('5')
      expect(
        find('#timetable_next_day_3i').value
      ).to eq('4')
      expect(
        find('#timetable-first-class').value
      ).to eq(@timetable.first_class.id.to_s)
      expect(
        find('#timetable-second-class').value
      ).to eq(@timetable.second_class.id.to_s)
      expect(
        find('#timetable-third-class').value
      ).to eq(@timetable.third_class.id.to_s)
      expect(
        find('#timetable-fourth-class').value
      ).to eq(@timetable.fourth_class.id.to_s)
      expect(
        find('#timetable-fifth-class').value
      ).to eq(@timetable.fifth_class.id.to_s)
      expect(
        find('#timetable-sixth-class').value
      ).to eq(@timetable.sixth_class.id.to_s)
      expect(
        find('#leave_time').value
      ).to eq(@timetable.leave_time)
      expect(
        find('#homework').value
      ).to eq(@timetable.homework)
      expect(
        find('#preparation').value
      ).to eq(@timetable.preparation)
      expect(
        find('#notice').value
      ).to eq(@timetable.notice)
      # 連絡内容を編集する
      select 2022, from: 'timetable[next_day(1i)]'
      select 5, from: 'timetable[next_day(2i)]'
      select 15, from: 'timetable[next_day(3i)]'
      select '国語', from: 'timetable[first_class_id]'
      select '国語', from: 'timetable[second_class_id]'
      select '国語', from: 'timetable[third_class_id]'
      select '国語', from: 'timetable[fourth_class_id]'
      select '国語', from: 'timetable[fifth_class_id]'
      select '国語', from: 'timetable[sixth_class_id]'
      fill_in 'timetable[leave_time]', with: @timetable.leave_time + '編集したテキスト'
      fill_in 'timetable[homework]', with: @timetable.homework + '編集したテキスト'
      fill_in 'timetable[preparation]', with: @timetable.preparation + '編集したテキスト'
      fill_in 'timetable[notice]', with: @timetable.notice + '編集したテキスト'
      # 編集してもtimetableモデルのカウントは変わらないことを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Timetable.count }.by(0)
      # 時間わり一覧ページに遷移することを確認する
      expect(current_path).to eq(timetable_path(@timetable))
      # トップページには先ほど編集した内容の時間わりが存在することを確認する（日付）
      expect(page).to have_content(@timetable.homework)
    end
  end

  context '時間わり編集ができないとき' do
    it 'ログインしていないとツイートの編集画面には遷移できない' do
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

RSpec.describe '削除', type: :system do
  before do
    @timetable = FactoryBot.create(:timetable)
  end
  context '時間わり削除ができるとき' do
    it 'ログインしたユーザーは投稿した連絡の削除ができる' do
      # ログインする
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
      expect do
        page.find_link('削除', href: timetable_path(@timetable)).click
      end.to change { Timetable.count }.by(-1)
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

RSpec.describe '時間わり詳細', type: :system do
  before do
    @timetable = FactoryBot.create(:timetable)
  end
  it 'ログインしたユーザーは詳細ページに遷移して編集ボタンが表示される' do
    # ログインする
    visit new_user_session_path
    fill_in 'user[email]', with: @timetable.user.email
    fill_in 'user[password]', with: @timetable.user.password
    find('input[name="commit"]').click
    expect(current_path).to eq(root_path)
    # 時間わり一覧ページへのボタンがあることを確認する
    expect(page).to have_content('時間わり')
    # 時間わり一覧ページに移動する
    visit timetables_path
    # 時間わり詳細ボタンがあることを確認する
    expect(page).to have_link @timetable.next_day
    # 詳細ページに遷移する
    visit timetable_path(@timetable)
    # ページに情報が存在する
    expect(page).to have_content('編集する')
  end
  it 'ログインしていない状態で連絡詳細ページに遷移できない' do
    # トップページに移動する
    visit root_path
    # 時間わり一覧ページへのボタンがあることを確認する
    expect(page).to have_content('時間わり')
    # 時間わり一覧ページに移動する
    visit timetables_path
    # ログインページへ戻されることを確認する
    expect(current_path).to eq(new_user_session_path)
  end
end
