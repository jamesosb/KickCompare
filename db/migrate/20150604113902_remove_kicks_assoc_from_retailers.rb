class RemoveKicksAssocFromRetailers < ActiveRecord::Migration
  def change
    remove_column :retailers, :kick_id, :string
  end
end
