class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :executor, foreign_key: { to_table: :users }
      t.string :title, null: false
      t.datetime :completed_at
      t.text :memo, null: false

      t.timestamps
    end
  end
end
