require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
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
      expect(task_list[0]).to have_content 'タスク2'
      expect(task_list[1]).to have_content 'タスク1'
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
        click_button 'Create Task'
      end
      it '作成したタスクが表示される' do
        expect(page).to have_content 'RSpecでテストを書く'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task)
        visit tasks_path
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
