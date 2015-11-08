class CreateGifs < ActiveRecord::Migration
  def change
    create_table :gifs do |t|
      t.text :url

      t.timestamps null: false
    end
  end
end
