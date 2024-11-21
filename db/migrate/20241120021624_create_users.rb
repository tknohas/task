class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :line_user_key, null: false

      t.timestamps
    end
  end
end
