class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :user
      t.string :name

      t.timestamps
    end
    add_index :events, :user_id
  end
end
