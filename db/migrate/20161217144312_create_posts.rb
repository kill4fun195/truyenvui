class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :content
      t.integer :view, default: 0
      t.integer :like, default: 0
      t.integer :comment, default: 0
      t.integer :crontab_count, default: 0
      t.string :source
      t.integer :post_type
      t.integer :status, default: 2
      t.string :slug
      t.datetime :publish, default: Time.zone.now
      t.belongs_to :user, index: true
      t.belongs_to :category, index: true
      t.timestamps null: false
    end
    add_index  :posts, :slug, unique: true
  end
end
