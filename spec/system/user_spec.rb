require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do
  before do
    FactoryBot.create(:user)
    FactoryBot.create(:user2)
  end
  describe 'ユーザー新規作成' do
    context 'ユーザーを新規作成した場合' do
      it '作成したユーザーが表示される' do
        visit new_user_path
        expect(new_user_path).to eq new_user_path
        fill_in 'user[name]',with: 'たくや'
        fill_in 'user[email]',with: 'taku@docomo.ne.jp'
        fill_in 'user[password]',with: 'password'
        fill_in 'user[password_confirmation]',with: 'password'
        click_button 'アカウント作成'
        expect(page).to have_content 'たくや'
        expect(page).to have_content 'taku@docomo.ne.jp'
      end
    end
    context 'ログインせずに一覧ページに飛んだ場合' do
      it '遷移せずログインページに戻されること' do
        visit tasks_path
        expect(page).to have_content "Login"
        expect(page).to have_content "Email"
        expect(page).to have_content "Password"
        expect(current_path).to have_content "/sessions/new"
    end
   end
  end
  describe 'ログイン機能' do 
    context 'ログインした場合' do
      it 'ログインができること' do
        visit new_session_path
        expect(current_path).to have_content "/sessions/new"
        fill_in 'session[email]', with: 'takuya@docomo.ne.jp'
        fill_in 'session[password]', with: 'password'

        click_button 'Log in'
        expect(page).to have_content "タスク一覧"
        expect(current_path).to have_content "/tasks"

        click_link 'Profile' # ログインしたuserのshow画面に移動してみる(本当に任意のuserでログインできているか確認するため) 

        expect(page).to have_content "takuya@docomo.ne.jp"
        # binding.irb

      end
    end
    context 'ログアウトした場合' do 
      it 'ログアウトができること' do
        visit new_session_path
        expect(current_path).to have_content "/sessions/new"
        fill_in 'session[email]', with: 'takuya@docomo.ne.jp'
        fill_in 'session[password]', with: 'password'
        click_button 'Log in'
        expect(page).to have_content "タスク一覧"
        expect(current_path).to have_content "/tasks"
        click_link 'Logout'
        expect(page).to have_content 'ログインしました'
      end
    end

  end
  describe 'ユーザー詳細機能' do
    context '自分の詳細ページボタンを押した場合' do 
      it '自分の詳細ページに遷移すること' do
        visit new_user_path
        expect(new_user_path).to eq new_user_path
        fill_in 'user[name]',with: 'たくや'
        fill_in 'user[email]',with: 'taku@docomo.ne.jp'
        fill_in 'user[password]',with: 'password'
        fill_in 'user[password_confirmation]',with: 'password'
        click_button 'アカウント作成'
        expect(page).to have_content 'たくや'
        expect(page).to have_content 'taku@docomo.ne.jp'
        # binding.irb
        click_link '戻る'
        click_link 'Profile'
        expect(page).to have_content 'taku@docomo.ne.jp'
      end
    end
  end
  describe '管理画面テスト' do
    context '管理者が管理画面にアクセスした場合' do
      it '管理画面に遷移されること' do
        visit new_session_path
        fill_in 'session[email]',with: 'takuya@docomo.ne.jp'
        fill_in 'session[password]',with: 'password'
        click_button 'Log in'
        click_button '管理者画面へ'
        expect(page).to have_content '管理者画面'
        expect(current_path).to have_content "/admin/users"
      end
      it '管理者は新規ユーザーを作成できること' do
        visit new_session_path
        fill_in 'session[email]',with: 'takuya@docomo.ne.jp'
        fill_in 'session[password]',with: 'password'
        click_button 'Log in'
        click_button '管理者画面へ'
        click_button '新たな管理者を作成する'
        fill_in 'user[name]',with: 'たく2'
        fill_in 'user[email]',with: 'taku@docomo2.ne.jp'
        fill_in 'user[password]',with: 'password2'
        fill_in 'user[password_confirmation]',with: 'password2'
        click_button '管理者作成'
        expect(page).to have_content 'たく2'
        expect(current_path).to have_content "/admin/users"
      end
      it '管理ユーザーは他人の詳細ページが確認できること' do
        visit new_session_path
        fill_in 'session[email]',with: 'takuya@docomo.ne.jp'
        fill_in 'session[password]',with: 'password'
        click_button 'Log in'
        click_button '管理者画面へ'
        first('tr td:nth-child(3)').click
        # binding.irb
        expect(page).to have_content '鶴野のMyページ'
      end
      it '管理者は他の人を編集できる' do
        visit new_session_path
        fill_in 'session[email]',with: 'takuya@docomo.ne.jp'
        fill_in 'session[password]',with: 'password'
        click_button 'Log in'
        click_button '管理者画面へ'
        # binding.irb
        first('tr td:nth-child(4)').click
        fill_in 'user[name]',with: 'たく変更しました'
        fill_in 'user[email]',with: 'takuya@docomo.ne.jp'
        fill_in 'user[password]',with: 'password'
        fill_in 'user[password_confirmation]',with: 'password'
        click_button '編集する'
        expect(page).to have_content 'たく変更しました'
      end
    end
    it '管理者は他のユーザーを消去できる' do
      visit new_session_path
      fill_in 'session[email]',with: 'takuya@docomo.ne.jp'
      fill_in 'session[password]',with: 'password'
      click_button 'Log in'
      click_button '管理者画面へ'
      first('tr:nth-child(3) td:nth-child(5)').click
      page.driver.browser.switch_to.alert.accept
    end
  end
    context '一般ユーザーがアクセスした場合' do
      it '一般ユーザーが入れないこと' do
        visit new_session_path
        fill_in 'session[email]',with: 'takuya2@docomo.ne.jp'
        fill_in 'session[password]',with: 'password2'
        click_button 'Log in'
        click_button '管理者画面へ'
        expect(page).to have_content 'takuyaのページ'
      end
    end

end