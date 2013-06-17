class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :img_url
      t.string :caption
      t.references :user, index: true
      t.references :channel, index: true

      t.timestamps
    end
  end
end
