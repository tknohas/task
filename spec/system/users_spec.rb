RSpec.describe 'Users', type: :system do
  describe 'ログイン' do
    let!(:user) { create(:user, name: 'Alice', email_address: 'alice@example.com', password: '123456') }

    before do
      visit new_session_path
    end

    context 'フォームの入力値が正常' do
      it 'ログイン成功' do
        fill_in 'email_address', with: 'alice@example.com'
        fill_in 'password', with: '123456'
        click_button 'ログイン'

        expect(page).to have_css 'h2', text: 'ホーム'
      end
    end

    context 'フォームの入力値が異常' do
      it 'ログイン失敗' do
        fill_in 'email_address', with: ''
        fill_in 'password', with: ''
        click_button 'ログイン'

        expect(page).to have_css 'h2', text: 'ログイン'
      end
    end
  end
end
