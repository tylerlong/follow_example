class CreateFollowships < ActiveRecord::Migration
  def change
    create_table :followships do |t|
      t.references :user
      t.references :followable, polymorphic: true

      t.timestamps
    end
    add_index :followships, :user_id
    add_index :followships, [:user_id, :followable_type]
    add_index :followships, [:followable_id, :followable_type]
    add_index :followships, [:user_id, :followable_id, :followable_type], unique: true,
      name: "index_followships_on_user_id_followable_id_followable_type"
  end
end
