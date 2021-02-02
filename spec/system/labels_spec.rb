require 'rails_helper'
RSpec.describe 'ラベル機能', type: :system do
  before do
    @user_a = FactoryBot.create(:user)
    # ラベルa bを設定したタスクを作成
    @task = FactoryBot.create(:task, user: @user_a)
    # ラベルb cを設定したタスクを作成
    @second_task = FactoryBot.create(:second_task, user: @user_a)
    # ラベルcを設定したタスクを作成
    @third_task = FactoryBot.create(:third_task, user: @user_a)
    visit new_session_path
    fill_in 'Email', with: 'test1@test.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
  end
  describe 'ラベル検索機能' do
    before do
      visit tasks_path
    end
    context 'ラベル検索をした場合' do
      before do
        find_by_id('task_label_id').click
        select 'ラベルa', from: 'task_label_id'
        click_on 'Search'
      end
      it "ラベルに一致するタスクが絞り込まれる" do
        expect(page).to have_selector 'td', text: 'タスク1'
        expect(page).not_to have_selector 'td', text: 'タスク2-1'
        expect(page).not_to have_selector 'td', text: 'タスク2-2'
      end
    end
    context 'ラベル検索とステータス検索をした場合' do
      it "ラベルとステータスに一致するタスクが絞り込まれる" do
        select '未着手', from: 'ステータス'
        select 'ラベルb', from: 'task_label_id'
        click_on 'Search'
        expect(page).to have_content 'タスク1'
        expect(page).not_to have_content 'タスク2-1'
        expect(page).not_to have_content 'タスク2-2'
      end
    end
    context 'タイトルのあいまい検索とラベル検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        fill_in 'タスク名', with: 'タスク2'
        select 'ラベルb', from: 'task_label_id'
        click_on 'Search'
        expect(page).not_to have_content 'タスク1'
        expect(page).to have_content 'タスク2-1'
        expect(page).not_to have_content 'タスク2-2'
      end
    end
  end
end

RSpec.describe 'ラベル登録機能', type: :system do
  before do
    @user_a = FactoryBot.create(:user)
    @label = FactoryBot.create(:label)
    @second_label = FactoryBot.create(:second_label)
    FactoryBot.create(:third_label)
    visit new_session_path
    fill_in 'Email', with: 'test1@test.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      before do
        visit new_task_path
        fill_in 'タスク名', with: 'テストを書く'
        fill_in '内容', with: 'RSpecでテストを書く'
        select '着手中', from: 'ステータス'
        # ラベルa bを設定したタスクを作成
        find_by_id("task_label_ids_#{@label.id}").set(true)
        find_by_id("task_label_ids_#{@second_label.id}").set(true)
        click_on '登録する'
      end
      it '作成時に設定した複数のラベルが表示される' do
        expect(page).to have_content 'ラベルa'
        expect(page).to have_content 'ラベルb'
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       before do
         # ラベルa bを設定したタスクを作成
         task = FactoryBot.create(:task, user: @user_a)
         visit tasks_path
         click_on '詳細'
       end
       it '該当タスクのラベルの内容が表示される' do
         expect(page).to have_content 'ラベルa'
         expect(page).to have_content 'ラベルb'
       end
     end
  end
end
