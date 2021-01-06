class CreateBugUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :bug_users do |t|
      t.date :deadline
      t.references :user
      t.references :bug

      t.timestamps
    end
  end
end
