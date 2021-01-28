require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do
  before do
    @user_admin = FactoryBot.create(:user)
    @user_b = FactoryBot.create(:second_user)
    FactoryBot.create(:task, user: @user_admin)
    FactoryBot.create(:second_task, user: @user_b)
    visit tasks_path
  end
  describe 'ユーザ登録のテスト' do
    context 'ユーザがログインしていない状態のとき' do
      before do
        visit '/users/new'
      end
      it 'ユーザの新規登録ができること' do
        fill_in '名前', with: 'user_c'
        fill_in 'メールアドレス', with: 'user3@test.com'
        fill_in 'パスワード', with: 'password'
        fill_in '確認用パスワード', with: 'password'
        click_button '登録する'
        expect(page).to have_content '名前: user_c'
      end
    end
    context 'ユーザがログインせずタスク一覧画面に飛ぼうとしたとき' do
      before do
        visit tasks_path
      end
      it 'ログイン画面に遷移すること' do
        expect(page).to have_content 'ログインしてください'
      end
    end
  end

  describe 'セッション機能のテスト' do
    before do
      visit new_session_path
      fill_in 'Email', with: 'test2@test.com'
      fill_in 'Password', with: 'password'
      click_button 'Log in'
    end
    context 'ユーザがログインしていないとき' do
      it 'ログインができること' do
        expect(page).to have_content 'user_b'
      end
    end
    context 'ユーザがログインしたとき' do
      it '自分の詳細画面(マイページ)に飛べること' do
        expect(page).to have_content 'Users#show'
      end
    end
    context '一般ユーザが他人の詳細画面に飛ぶと' do
      before do
        visit user_path(@user_admin.id)
      end
      it 'タスク一覧画面に遷移すること' do
        visit current_path
        expect(current_path).to eq tasks_path
      end
    end
    context 'ユーザがログインしたとき' do
      it 'ログアウトができること' do
        click_link 'Logout'
        expect(current_path).to eq new_session_path
      end
    end
  end

  describe '管理画面のテスト' do
    context '一般ユーザがログインした状態のとき' do
      before do
        visit new_session_path
        fill_in 'Email', with: 'test2@test.com'
        fill_in 'Password', with: 'password'
        click_button 'Log in'
      end
      it '一般ユーザは管理画面にアクセスできないこと' do
        visit admin_users_path
        expect(current_path).to_not eq admin_users_path
      end
    end
    context '管理ユーザがログインした状態のとき' do
      before do
        visit new_session_path
        fill_in 'Email', with: 'test1@test.com'
        fill_in 'Password', with: 'password'
        click_button 'Log in'
      end
      it '管理ユーザは管理画面にアクセスできること' do
        visit admin_users_path
        expect(current_path).to eq admin_users_path
      end
      it '管理ユーザはユーザの新規登録ができること' do
        visit admin_users_path
        within '.content' do
          click_on '新規登録'
        end
        fill_in '名前', with: 'user_c'
        fill_in 'メールアドレス', with: 'user3@test.com'
        fill_in 'パスワード', with: 'password'
        fill_in '確認用パスワード', with: 'password'
        click_button '登録する'
        expect(page).to have_content 'ユーザー「user_c」を登録しました'
      end
      it '管理ユーザはユーザの詳細画面にアクセスできること' do
        visit admin_user_path(@user_b.id)
        expect(current_path).to eq admin_user_path(@user_b.id)
      end
      it '管理ユーザはユーザの編集画面からユーザを編集できること' do
        visit edit_admin_user_path(@user_b.id)
        fill_in '名前', with: 'user_b_edit'
        click_button '更新する'
        expect(page).to have_content 'ユーザー「user_b_edit」を更新しました'
      end
      it '管理ユーザはユーザの削除をできること' do
        visit admin_users_path
        page.accept_confirm do
          all('tbody tr')[1].click_link '削除'
        end
        expect(page).to have_content 'ユーザー「user_b」を削除しました'
      end
    end
  end
end
