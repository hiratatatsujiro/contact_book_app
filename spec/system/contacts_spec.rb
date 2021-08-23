require 'rails_helper'

RSpec.describe 'Contacts', type: :system do
  before do
    @contact = FactoryBot.create(:contact)
    author = @contact.user
    @user = FactoryBot.create(:user, grade_id: author.grade_id, classroom_id: author.classroom_id)
  end

  context '連絡投稿ができるとき' do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 連絡一覧ページへのボタンがあることを確認する
      expect(page).to have_content('連絡する')
      # 連絡一覧ページに移動する
      visit contacts_path
      # 新規投稿ボタンがあることを確認する
      expect(page).to have_content('連絡する')
      # 新規投稿ページに移動する
      visit new_contact_path
      # フォームに情報を入力する
      select @contact.condition.name, from: 'contact[condition_id]'
      fill_in 'contact[reason]', with: @contact.reason
      select @contact.pool_marathon.name, from: 'contact[pool_marathon_id]'
      fill_in 'contact[contact]', with: @contact.contact
      # 送信するとcontactモデルのカウントが1上がることを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Contact.count }.by(1)
      # 連絡一覧ページに遷移することを確認する
      expect(current_path).to eq(contacts_path)
      # トップページには先ほど投稿した内容の連絡が存在することを確認する（日付）
      expect(page).to have_content(@contact.created_at.strftime('%Y/%m/%d %H:%M'))
    end
  end

  context '連絡投稿ができないとき' do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページにいる
      visit root_path
      # 連絡一覧ページへのボタンがあることを確認する
      expect(page).to have_content('連絡する')
      # 連絡一覧ページに移動する
      visit contacts_path
      # ログインページへ戻されることを確認する
      expect(current_path).to eq(new_user_session_path)
    end
  end
end

RSpec.describe '連絡編集', type: :system do
  before do
    @contact = FactoryBot.create(:contact)
    author = @contact.user
    @user2 = FactoryBot.create(:user, grade_id: author.grade_id, classroom_id: author.classroom_id, number_id: 52)
  end

  context '連絡編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿した連絡の編集ができる' do
      # 連絡を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @contact.user.email
      fill_in 'user[password]', with: @contact.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 連絡一覧ページへのボタンがあることを確認する
      expect(page).to have_content('連絡する')
      # 連絡一覧ページに移動する
      visit contacts_path
      # 連絡詳細ボタンがあることを確認する
      expect(page).to have_link @contact.created_at.strftime('%Y/%m/%d %H:%M'), href: contact_path(@contact)
      # 連絡詳細ページに移動する
      visit contact_path(@contact)
      # 連絡に「編集」へのリンクがあることを確認する
      expect(page).to have_link '編集', href: edit_contact_path(@contact)
      # 編集ページへ遷移する
      visit edit_contact_path(@contact)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(
        find('#condition').value
      ).to eq(@contact.condition.id.to_s)
      expect(
        find('#reason').value
      ).to eq(@contact.reason)
      expect(
        find('#pool_marathon').value
      ).to eq(@contact.pool_marathon.id.to_s)
      expect(
        find('#contact').value
      ).to eq(@contact.contact)
      # 連絡内容を編集する
      select 'お休みします', from: 'contact[condition_id]'
      fill_in 'contact[reason]', with: @contact.reason + '編集したテキスト'
      select 'できます', from: 'contact[pool_marathon_id]'
      fill_in 'contact[contact]', with: @contact.contact + '編集したテキスト'
      # 編集してもTweetモデルのカウントは変わらないことを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { Contact.count }.by(0)
      # 連絡一覧ページに遷移することを確認する
      expect(current_path).to eq(contacts_path)
      # トップページには先ほど編集した内容の連絡が存在することを確認する（日付）
      expect(page).to have_content(@contact.created_at.strftime('%Y/%m/%d %H:%M'))
    end
  end

  context '連絡編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したツイートの編集画面には遷移できない' do
      # 別ユーザーでログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @user2.email
      fill_in 'user[password]', with: @user2.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 連絡一覧ページへのボタンがあることを確認する
      expect(page).to have_content('連絡する')
      # 連絡一覧ページに移動する
      visit contacts_path
      # 新規投稿ボタンがあることを確認する
      expect(page).to have_link @contact.created_at.strftime('%Y/%m/%d %H:%M'), href: contact_path(@contact)
      # 連絡編集ページに移動する
      visit contact_path(@contact)
      # 連絡に「編集」へのリンクがないことを確認する
      expect(page).to have_no_link '編集', href: edit_contact_path(@contact)
    end
    it 'ログインしていないとツイートの編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # 連絡一覧ページへのボタンがあることを確認する
      expect(page).to have_content('連絡する')
      # 連絡一覧ページに移動する
      visit contacts_path
      # ログインページへ戻されることを確認する
      expect(current_path).to eq(new_user_session_path)
    end
  end
end

RSpec.describe '削除', type: :system do
  before do
    @contact1 = FactoryBot.create(:contact)
    @contact2 = FactoryBot.create(:contact)
  end
  context '連絡削除ができるとき' do
    it 'ログインしたユーザーは自らが投稿した連絡の削除ができる' do
      # contact1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @contact1.user.email
      fill_in 'user[password]', with: @contact1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 連絡一覧ページへのボタンがあることを確認する
      expect(page).to have_content('連絡する')
      # 連絡一覧ページに移動する
      visit contacts_path
      # 新規投稿ボタンがあることを確認する
      expect(page).to have_link @contact1.created_at.strftime('%Y/%m/%d %H:%M')
      # 新規投稿ページに移動する
      visit contact_path(@contact1)
      # 連絡1に「削除」のリンクがあることを確認する
      expect(page).to have_link '削除', href: contact_path(@contact1)
      # 投稿を削除するとレコードの数が1減ることを確認する
      expect do
        page.find_link('削除', href: contact_path(@contact1)).click
      end.to change { Contact.count }.by(-1)
      # 連絡一覧画面へ遷移する
      visit contacts_path
      # トップページには連絡1の内容が存在しないことを確認する
      expect(page).to have_no_link @contact1.created_at.strftime('%Y/%m/%d %H:%M'), href: contact_path(@contact1)
    end
  end
  context '連絡削除ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿した連絡の削除ができない' do
      # 連絡1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'user[email]', with: @contact1.user.email
      fill_in 'user[password]', with: @contact1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 連絡一覧ページへのボタンがあることを確認する
      expect(page).to have_content('連絡する')
      # 連絡一覧ページに移動する
      visit contacts_path
      # 連絡詳細ボタンがないことを確認する
      expect(page).to have_no_link @contact2.created_at.strftime('%Y/%m/%d %H:%M'), href: contact_path(@contact2)
    end

    it 'ログインしていないと連絡削除ボタンがない' do
      # トップページにいる
      visit root_path
      # 連絡一覧ページへのボタンがあることを確認する
      expect(page).to have_content('連絡する')
      # 連絡一覧ページに移動する
      visit contacts_path
      # ログインページへ戻されることを確認する
      expect(current_path).to eq(new_user_session_path)
    end
  end
end

RSpec.describe '連絡詳細', type: :system do
  before do
    @contact = FactoryBot.create(:contact)
  end
  it 'ログインしたユーザーはツイート詳細ページに遷移してコメント投稿欄が表示される' do
    # ログインする
    visit new_user_session_path
    fill_in 'user[email]', with: @contact.user.email
    fill_in 'user[password]', with: @contact.user.password
    find('input[name="commit"]').click
    expect(current_path).to eq(root_path)
    # 連絡一覧ページへのボタンがあることを確認する
    expect(page).to have_content('連絡する')
    # 連絡一覧ページに移動する
    visit contacts_path
    # 連絡詳細ボタンがあることを確認する
    expect(page).to have_link @contact.created_at.strftime('%Y/%m/%d %H:%M')
    # 詳細ページに遷移する
    visit contact_path(@contact)
    # ページに情報が存在する
    expect(page).to have_content(@contact.condition.name.to_s)
    expect(page).to have_content(@contact.reason.to_s)
    expect(page).to have_content(@contact.pool_marathon.name.to_s)
    expect(page).to have_content(@contact.contact.to_s)
  end
  it 'ログインしていない状態で連絡詳細ページに遷移できない' do
    # トップページに移動する
    visit root_path
    # 連絡一覧ページへのボタンがあることを確認する
    expect(page).to have_content('連絡する')
    # 連絡一覧ページに移動する
    visit contacts_path
    # ログインページへ戻されることを確認する
    expect(current_path).to eq(new_user_session_path)
  end
end
