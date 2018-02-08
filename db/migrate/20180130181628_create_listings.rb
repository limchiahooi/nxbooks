class CreateListings < ActiveRecord::Migration[5.1]
  def change
    create_table :listings do |t|
      t.string :title
      t.string :author
      t.string :publisher
      t.text :review
      t.json :image
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
