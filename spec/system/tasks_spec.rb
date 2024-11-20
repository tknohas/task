RSpec.describe 'Tasks', type: :system do
  let!(:user) { create(:user, name: 'Alice') }
  let!(:executor) { create(:user, name: 'Bob') }
  # let!(:task) { create(:task, title: 'お茶を買う', executor_id: executor.id) }

  before do
    login(user)
  end

  describe 'タスク登録' do
    context 'フォームの入力値が正常' do
      it '登録成功' do
        visit new_task_path

        fill_in 'task_title', with: '豆腐'
        find("option[value=#{executor.id}]").select_option
        fill_in 'task_memo', with: 'メモです'
        click_button '登録する'

        expect(page).to have_content '登録しました'
        expect(page).to have_css 'h2', text: 'ホーム'
      end
    end

    context 'フォームの入力値が異常' do
      it '登録失敗' do
        visit new_task_path

        fill_in 'task_title', with: ''
        fill_in 'task_memo', with: ''
        click_button '登録する'

        expect(page).to have_css 'h2', text: 'タスク追加'
        expect(page).to have_content 'タイトルを入力してください'
      end
    end
  end
end
