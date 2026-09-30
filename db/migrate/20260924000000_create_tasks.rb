class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.text :notes
      t.string :priority, null: false, default: "medium"
      t.date :due_date
      t.boolean :completed, null: false, default: false
      t.datetime :completed_at

      t.timestamps
    end

    add_index :tasks, :completed
    add_index :tasks, :due_date
  end
end
