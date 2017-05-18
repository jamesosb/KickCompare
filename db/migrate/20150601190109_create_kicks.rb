class CreateKicks < ActiveRecord::Migration
  def change
    create_table :kicks do |t|
      t.string :name
      t.string :product_type
      t.string :manufacturer

      t.timestamps null: false
    end
  end
end
