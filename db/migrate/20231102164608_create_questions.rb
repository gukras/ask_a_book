class CreateQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :questions do |t|
      t.string :question, limit: 140
      t.string :answer, limit: 1000 #null #Blank
      t.string :context, limit: 140
      t.integer :ask_count, default: 1

      t.timestamps
    end
  end
end
