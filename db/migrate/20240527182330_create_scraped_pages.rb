class CreateScrapedPages < ActiveRecord::Migration[7.1]
  def change
    create_table :scraped_pages do |t|
      t.string :url
      t.text :body

      t.timestamps
    end

    add_index :scraped_pages, :url, unique: true
  end
end
