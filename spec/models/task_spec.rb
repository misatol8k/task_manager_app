require 'rails_helper'
RSpec.describe Task, type: :model do
  before do
    @user_a = FactoryBot.create(:user)
  end
  describe 'バリデーションのテスト' do
    # タスク名がなければ無効な状態であること
    context 'タスク名が空の場合' do
      it "is invalid without a name" do
        task = Task.new(
          name: nil,
          content: 'タスクの内容サンプル',
          end_date: '2021-01-16',
          status: '未着手',
          priority: '低',
          user: @user_a
        )
        task.valid?
        expect(task.errors[:name]).to include("を入力してください")
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'is invalid without a content' do
        task = Task.new(
          name: 'タスク名サンプル',
          content: nil,
          end_date: '2021-01-16',
          status: '未着手',
          priority: '低',
          user: @user_a
        )
        task.valid?
        expect(task.errors[:content]).to include("を入力してください")
      end
    end
    # タスク名があれば有効な状態であること
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it "is valid with a name, content" do
        task = Task.new(
          name: 'タスク名サンプル',
          content: 'タスクの内容サンプル',
          end_date: '2021-01-16',
          status: '未着手',
          priority: '低',
          user: @user_a
        )
        task.valid?
        expect(task).to be_valid
      end
    end
  end
  describe '検索機能' do
    let!(:task) { FactoryBot.create(:task, user: @user_a) }
    let!(:second_task) { FactoryBot.create(:second_task, user: @user_a) }
    let!(:third_task) { FactoryBot.create(:third_task, user: @user_a) }
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        expect(Task.search_name('タスク1')).to include(task)
        expect(Task.search_name('タスク1')).not_to include(second_task)
        expect(Task.search_name('タスク1')).not_to include(third_task)
        expect(Task.search_name('タスク1').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.search_status('着手中')).not_to include(task)
        expect(Task.search_status('着手中')).to include(second_task)
        expect(Task.search_status('着手中')).not_to include(third_task)
        expect(Task.search_status('着手中').count).to eq 1
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.search_name('タスク2').search_status('未着手')).not_to include(task)
        expect(Task.search_name('タスク2').search_status('未着手')).not_to  include(second_task)
        expect(Task.search_name('タスク2').search_status('未着手')).to include(third_task)
        expect(Task.search_name('タスク2').search_status('未着手').count).to eq 1
      end
    end
  end
end
