require 'rails_helper'
RSpec.describe Task, type: :model do
  describe 'バリデーションのテスト' do
    # タスク名がなければ無効な状態であること
    context 'タスク名が空の場合' do
      it "is invalid without a name" do
        task = Task.new(
          name: nil,
          content: 'タスクの内容サンプル'
        )
        task.valid?
        expect(task.errors[:name]).to include("を入力してください")
      end
    end
    context 'タスクの詳細が空の場合' do
      it 'is invalid without a content' do
        task = Task.new(
          name: 'タスク名サンプル',
          content: nil
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
          content: 'タスクの内容サンプル'
        )
        task.valid?
        expect(task).to be_valid
      end
    end
  end
end
