class Kick < ActiveRecord::Base
  searchkick merge_mappings: true, suggest: ["name"], word_start: [:name] , mappings: {
                                  kick: {
                                      properties:{
                                          lowest_price: {type: "float", analyzer: "keyword"},
                                          highest_price: {type: "float", analyzer: "keyword"}
                                                 }
                                        }
                                  }

  #TODO fix indexing of prices

 def search_data
   prices = offers.price.sort_by{|v| v.last}.first
   attributes.merge(
       lowest_price: offers.map(&prices)
   )
 end


  has_many :offers
  has_many :retailers, :through => :offers

  accepts_nested_attributes_for :offers, :retailers

end
