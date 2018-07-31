class CreateIssues < ActiveRecord::Migration[5.1]
  def change
    create_table :issues do |t|
      t.text :summary
      t.string :status
      t.references :reporter
      t.references :assignee
      t.timestamps
    end
  end
end
