require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
    visit tasks_path
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content 'RSpecでテストを書く'
      end
    end
  end
  context 'タスクが作成日時の降順に並んでいる場合' do
    it '新しいタスクが一番上に表示される' do
      task_list = all('.task_row')
      expect(task_list[0]).to have_content 'タスク2-2'
      expect(task_list[1]).to have_content 'タスク2-1'
      expect(task_list[2]).to have_content 'タスク1'
    end
  end
  context 'タスクを終了期限の降順でソートした場合' do
    before do
      click_link '終了期限でソートする'
    end
    it '終了期限の新しいタスクが一番上に表示される' do
      task_list = all('.task_end_date')
      expect(task_list[0]).to have_content '2021-01-16'
      expect(task_list[1]).to have_content '2021-01-15'
      expect(task_list[2]).to have_content '2021-01-14'
    end
  end
  describe '検索機能' do
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        fill_in 'タスク名', with: 'スク1'
        select '', from: 'ステータス'
        click_button 'Search'
        expect(page).to have_content 'タスク1'
        expect(page).not_to have_content 'タスク2-1'
        expect(page).not_to have_content 'タスク2-2'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        select '着手中', from: 'ステータス'
        click_button 'Search'
        expect(page).not_to have_content 'タスク1'
        expect(page).to have_content 'タスク2-1'
        expect(page).not_to have_content 'タスク2-2'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        fill_in 'タスク名', with: 'タスク2'
        select '未着手', from: 'ステータス'
        click_button 'Search'
        expect(page).not_to have_content 'タスク1'
        expect(page).not_to have_content 'タスク2-1'
        expect(page).to have_content 'タスク2-2'
      end
    end
  end
end

RSpec.describe 'タスク作成機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      before do
        visit new_task_path
        fill_in 'task_name', with: 'テストを書く'
        fill_in 'task_content', with: 'RSpecでテストを書く'
        select '着手中', from: 'ステータス'
        click_button '登録する'
      end
      it '作成したタスクが表示される' do
        expect(page).to have_content 'RSpecでテストを書く'
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       before do
         task = FactoryBot.create(:task)
         visit tasks_path
         click_link '詳細'
       end
       it '該当タスクの内容が表示される' do
         expect(page).to have_content 'タスク詳細'
       end
     end
  end
end
