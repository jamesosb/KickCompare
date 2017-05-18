class Retailer < ActiveRecord::Base
  has_many :offers
  has_many :kicks, :through => :offers
  accepts_nested_attributes_for :offers, :kicks
end
