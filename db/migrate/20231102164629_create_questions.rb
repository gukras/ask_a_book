class CreateQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :questions do |t|
      t.string :question, limit: 1000
      t.string :answer, limit: 1000 
      t.string :context
      t.integer :ask_count, default: 1

      t.timestamps
    end
  end
end
