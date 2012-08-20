class CreateRecommendations < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
      t.integer :river_id
      t.text :intigi_url
      t.text :intigi_title
      t.text :intigi_excerpt
      t.datetime :intigi_found_at
      t.string :intigi_host_name
      t.integer :intigi_popularity
      t.integer :intigi_word_count
      t.integer :topsy_trackback_total
      t.boolean :show_in_river, :default => false
      t.boolean :is_manually_hidden, :default => false
      t.boolean :is_manually_starred, :default => false
      t.timestamps
    end
  end
end
