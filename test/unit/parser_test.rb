require 'test_helper'

class ParserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def create_parser(attributes)
    Parser.create({
      :purchaser_name   => "John Doe",
      :item_description => "Some awesome product!",
      :item_price       => 2.00,
      :purchase_count   => 1,
      :merchant_address => "123 Fake st",
      :merchant_name    => "Joe's Bakery"
    }.merge(attributes))
  end

  def setup
    @parsers = [
      create_parser(:item_price => 10.0,  :purchase_count => 2),
      create_parser(:item_price => 12.50, :purchase_count => 4)
    ]
  end

  test "Parser.revenue_for(parsers) returns gross revenue of given parsers" do
    assert_equal 70.0, Parser.revenue_for(@parsers), '10x2 + 12.50x4 = 70'
  end
end
