class AddReviewIdToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :review_id, :integer
  end
end
