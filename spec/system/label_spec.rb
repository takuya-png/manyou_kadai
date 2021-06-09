require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:user) {FactoryBot.create(:user)}
  before do
    task = FactoryBot.create(:task,user: user)
    second_task = FactoryBot.create(:second_task,user: user)
    third_task = FactoryBot.create(:third_task,user: user)
    label = FactoryBot.create(:label)
    label2 = FactoryBot.create(:label2)
    label3 = FactoryBot.create(:label3)
    FactoryBot.create(:labelling, task_id: task.id, label_id: label.id)
    FactoryBot.create(:labelling, task_id: second_task.id, label_id: label2.id)
    FactoryBot.create(:labelling, task_id: third_task.id, label_id: label3.id)

    visit new_session_path
    fill_in 'session[email]',with: 'takuya@docomo.ne.jp'
    fill_in 'session[password]',with: 'password'
    click_button 'Log in'
    click_link 'タスク作成'
    # binding.irb
    fill_in 'task[title]', with: 'test_task55'
    fill_in 'task[content]', with: 'content_test55'
    select '2020',from: 'task[expired_at(1i)]'

    find("#task_status").find("option[value='着手']").select_option
    find("#task_priority").find("option[value='高']").select_option
    click_button '登録する'

  end
  describe 'ラベル検索がされた場合' do
    context 'label検索をかけた場合' do
      it '指定したlabelが表示される事' do
        # binding.irb
        select '怒'
        click_button '検索'
        # binding.irb
        expect(page).to have_content '怒'
        expect(page).to have_content 'test_content2'
        expect(page).not_to have_content 'test_content1'
      end
    end
    context '新規作成でラベル機能がある' do
      it '指定したラベル要素が表示される' do
        expect(page).to have_content '怒'
        expect(page).to have_content 'test_title'
        expect(page).to have_content 'test_title2'
      end
    end
  end
end 