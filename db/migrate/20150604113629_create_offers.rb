class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.string :name
      t.text :desc
      t.references :kick, index: true, foreign_key: true
      t.references :retailer, index: true, foreign_key: true
      t.decimal :price, :precision => 8, :scale => 2


      t.timestamps null: false
    end
  end
end
