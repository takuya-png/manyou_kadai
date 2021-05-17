require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:task) { FactoryBot.create(:task, title:'task')}
  let!(:task2) { FactoryBot.create(:task, title:'task2')}
  before do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task[title]', with: 'test_task'
        # binding.irb
        fill_in 'task[content]', with: 'content_test'
        click_button 'Create Task'
        visit tasks_path
        expect(page).to have_content 'test_task'
        expect(page).to have_content 'content_test'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task,title: 'task',content: 'content')
        task2 = FactoryBot.create(:task,title: 'task2',content: 'content2')
        visit tasks_path
        expect(tasks_path).to eq tasks_path
        expect(page).to have_content 'task'
        expect(page).to have_content 'task2'
        expect(page).to have_content 'content'
        expect(page).to have_content 'content2'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it 'タスクが作成日時の降順に並んでいること' do
        visit tasks_path
        task_list = all('tbody td')
        expect(task_list[0]).to have_content 'task2'
        expect(task_list[1]).to have_content 'task1'
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task,title: 'task_詳細',content: 'content_詳細')
        visit task_path(task.id)
        expect(task).to be_valid
       end
     end
  end
end