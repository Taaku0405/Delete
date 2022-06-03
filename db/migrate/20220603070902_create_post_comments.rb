class CreatePostComments < ActiveRecord::Migration[6.1]
  def change
    create_table :post_comments do |t|
      
      t.text :comment_content
      t.references :end_user, foreign_key: true
      t.references :post, foreign_key: true
      t.timestamps
    end
  end
end
