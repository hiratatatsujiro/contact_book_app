require 'rails_helper'

RSpec.describe "Likes", type: :system do
    before do
      @user_teacher = FactoryBot.create(:user, number_id: 52)
      @class_communication = FactoryBot.create(:class_communication, user_id: @user_teacher.id)
      @user_child = FactoryBot.create(:user, grade_id: @user_teacher.grade_id, classroom_id: @user_teacher.classroom_id)
    end

    describe '#create,#destroy' do
      it 'ユーザーが他の投稿をいいね、いいね解除できる' do
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
        expect(page).to have_link @class_communication.title
        # 学級通信詳細ページに移動する
        visit class_communication_path(@class_communication)
        # 編集ボタンがあることを確認する
        expect(page).to have_content 'いいね'
        # いいねをするボタンを押す
        find('.nice-btn a').click
        expect(@class_communication.likes.count).to eq(0)
        # いいねを解除する
        find('.nice-btn a').click
        expect(@class_communication.likes.count).to eq(1)
        end
     end
end
