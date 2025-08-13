class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.string :title
      t.string :platform
      t.string :status
      t.date :release_date
      t.integer :rating
      t.text :description
      t.string :cover_url

      t.timestamps
    end
  end
end
