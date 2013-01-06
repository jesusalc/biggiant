class Parser < ActiveRecord::Base
  attr_accessible :item_description, :item_price, :merchant_address, :merchant_name, :purchase_count, :purchaser_name
  
  def self.revenue_for(parsers)  
    parsers.inject(0) { |sum, parser| sum + (parser.purchase_count * parser.item_price) }
  end
end
