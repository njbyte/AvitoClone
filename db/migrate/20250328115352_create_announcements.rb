class CreateAnnouncements < ActiveRecord::Migration[8.0]
  def change
    create_table :announcements do |t|
      t.string :title
      t.text :description
      t.decimal :price
      t.string :currency
      t.string :condition
      t.string :category
      t.string :subcategory
      t.string :city
      t.string :region
      t.string :seller_name
      t.string :phone_number
      t.string :email
      t.string :images
      t.string :video_url
      t.datetime :published_at
      t.datetime :expires_at
      t.integer :views_count
      t.string :status
      t.boolean :is_featured
      t.boolean :is_verified

      t.timestamps
    end
  end
end
