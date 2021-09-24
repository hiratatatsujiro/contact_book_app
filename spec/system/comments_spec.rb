require 'rails_helper'

RSpec.describe 'コメント投稿', type: :system, js: true do
  let!(:comment){FactoryBot.create(:comment)}
  let!(:diary){FactoryBot.create(:diary)}

  it 'ログインしたユーザーは日記詳細ページでコメント投稿できる' do
    # ログインする
    visit new_user_session_path
    fill_in 'user[email]', with: diary.user.email
    fill_in 'user[password]', with: diary.user.password
    find('input[name="commit"]').click
    expect(current_path).to eq(root_path)
    # 日記一覧ページに遷移する
    visit diaries_path
    # 日記詳細ボタンが存在する
    expect(page).to have_link diary.diary_day, href: diary_path(diary)
    # 日記詳細ページに遷移する
    visit diary_path(diary)
    # フォームに情報を入力する
    fill_in "comment[comment]", with: comment.comment
    # コメントを送信すると、Commentモデルのカウントが1上がることを確認する
    expect{
      find('input[name="commit"]').click
      wait_for_ajax
    }.to change { Comment.count }.by(1)
    # 詳細ページにリダイレクトされることを確認する
    expect(current_path).to eq diary_path(diary)
    # 詳細ページ上に先ほどのコメント内容が含まれていることを確認する
    expect(page).to have_content(comment.comment)
  end
end

