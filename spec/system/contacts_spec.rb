require 'rails_helper'

RSpec.describe 'Contacts', type: :system do
  before do
    @contact = FactoryBot.create(:contact)
    author = @contact.user
    @user = FactoryBot.create(:user, grade_id: author.grade_id, classroom_id: author.classroom_id)
  end

  context '連絡投稿ができるとき'do
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
    # 新規連絡ページに移動する
    visit new_contact_path
    # フォームに情報を入力する
    select @contact.condition.name, from: 'contact[condition_id]'
    fill_in 'contact[reason]', with: @contact.reason
    select @contact.pool_marathon.name, from: 'contact[pool_marathon_id]'
    fill_in 'contact[contact]', with: @contact.contact

    # 送信するとcontactモデルのカウントが1上がることを確認する
    expect{
      find('input[name="commit"]').click
    }.to change { Contact.count }.by(1)
    # 連絡一覧ページに遷移することを確認する
    expect(current_path).to eq(contacts_path)
    # トップページには先ほど投稿した内容の連絡が存在することを確認する（日付）
    expect(page).to have_content(@contact.created_at.strftime('%Y/%m/%d %H:%M'))
  end
  end

  context '連絡投稿ができないとき'do
  it 'ログインしていないと新規投稿ページに遷移できない' do
    # トップページに遷移する
    visit contacts_path
    # 新規投稿ページへのボタンがないことを確認する
    expect(current_path).to eq new_user_session_path
  end
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
      # 新規投稿ボタンがあることを確認する
      expect(page).to have_link @contact.created_at.strftime('%Y/%m/%d %H:%M'), href: contact_path(@contact)
      # 新規連絡ページに移動する
      visit contact_path(@contact)
      # ツイート1に「編集」へのリンクがあることを確認する
      expect(page).to have_link '編集', href: edit_contact_path(@contact)
      # 編集ページへ遷移する
      visit edit_contact_path(@contact)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(
        find('#condition').value
      ).to eq(@contact.condition.id.to_i)
      expect(
        find('#reason').value
      ).to eq(@contact.reason)
      expect(
        find('#pool_marathon').value
      ).to eq(@contact.pool_marathon.id.to_i)
      expect(
        find('#contact').value
      ).to eq(@contact.contact)
      # 投稿内容を編集する
      fill_in 'tweet_image', with: "#{@tweet1.image}+編集した画像URL"
      fill_in 'tweet_text', with: "#{@tweet1.text}+編集したテキスト"
      # 編集してもTweetモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Tweet.count }.by(0)
      # 編集完了画面に遷移したことを確認する
      expect(current_path).to eq(tweet_path(@tweet1))
      # 「更新が完了しました」の文字があることを確認する
      expect(page).to have_content('更新が完了しました。')
      # トップページに遷移する
      visit root_path
      # トップページには先ほど変更した内容のツイートが存在することを確認する（画像）
      expect(page).to have_selector ".content_post[style='background-image: url(#{@tweet1.image}+編集した画像URL);']"
      # トップページには先ほど変更した内容のツイートが存在することを確認する（テキスト）
      expect(page).to have_content("#{@tweet1.text}+編集したテキスト")
    end
  end
end
