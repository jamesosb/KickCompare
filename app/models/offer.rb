class Offer < ActiveRecord::Base
  belongs_to :kick
  belongs_to :retailer
  accepts_nested_attributes_for :kick, :retailer
end
