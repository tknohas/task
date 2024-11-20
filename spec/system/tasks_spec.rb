RSpec.describe 'Tasks', type: :system do
  let!(:user) { create(:user, name: 'Alice') }
  let!(:executor) { create(:user, name: 'Bob') }
  let!(:task) { create(:task, user:, title: 'お茶を買う', executor_id: executor.id) }

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
        expect(page).to have_css 'h2', text: 'タスク編集'
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

  describe 'タスク編集' do
    context 'フォームの入力値が正常' do
      it '編集成功' do
        visit edit_task_path(task)

        fill_in 'task_title', with: '車両変更'
        find("option[value=#{executor.id}]").select_option
        fill_in 'task_memo', with: '周囲に配慮'
        click_button '変更する'

        expect(page).to have_content '変更しました'
        expect(page).to have_css 'h2', text: 'タスク編集'
      end
    end

    context 'フォームの入力値が異常' do
      it '編集失敗' do
        visit edit_task_path(task)

        fill_in 'task_title', with: ''
        fill_in 'task_memo', with: ''
        click_button '変更する'

        expect(page).to have_css 'h2', text: 'タスク編集'
        expect(page).to have_content 'タイトルを入力してください'
      end
    end
  end
  
  describe 'タスク一覧' do
    it 'タスクの情報が表示される' do
      expect(page).to have_css 'h2', text: 'やること一覧'
      expect(page).to have_content 'お茶を買う'
      expect(page).to have_content 'Alice' # 作成者
      expect(page).to have_content 'Bob'   # 担当者
      expect(page).to have_content '編集'
    end
  end
end
