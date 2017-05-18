class CreateRetailers < ActiveRecord::Migration
  def change
    create_table :retailers do |t|
      t.string :name
      t.text :desc
      t.references :kick, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
