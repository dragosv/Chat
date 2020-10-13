class CreateConversations < ActiveRecord::Migration[6.0]
  def change
    create_table :conversations do |t|

      t.references :from, index: true, foreign_key: {to_table: :users}
      t.references :to, index: true, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
