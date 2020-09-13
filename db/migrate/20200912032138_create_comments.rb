class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.string :user_id
      t.text :body

      t.timestamps
    end
  end
end
