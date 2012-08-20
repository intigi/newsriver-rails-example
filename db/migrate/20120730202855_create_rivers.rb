class CreateRivers < ActiveRecord::Migration
  def change
    create_table :rivers do |t|
      t.string :title
      t.text :body
      t.string :intigi_recommendations_url
      t.integer :intigi_popularity_threshold
      t.integer :topsy_popularity_threshold
      t.boolean :is_featured, :boolean, :default => false
      t.timestamps
    end
  end
end
