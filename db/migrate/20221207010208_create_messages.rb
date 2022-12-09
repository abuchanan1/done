class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.boolean :automate
      t.string :message
      t.date :due_date
      t.string :task_name
      t.string :phone_number

      t.timestamps
    end
  end
end
