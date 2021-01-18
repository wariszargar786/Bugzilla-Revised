class CreateProjectUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :project_users do |t|
      t.references :project
      t.references :user
      t.timestamps
    end
  end
end
