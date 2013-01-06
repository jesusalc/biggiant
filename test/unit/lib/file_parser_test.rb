require 'test_helper'

class FileParserTest < ActiveSupport::TestCase
  def setup
    @file_traveling = File.open( File.join(Rails.root, "test", "fixtures", "example_input.tab") )
  end

  test "each row is uploaded" do
    assert_difference("Parser.count", 2) do
      FileParser.process(@file_traveling)
    end
  end

  test "all columns are uploaded" do
    upload = FileParser.process(@file_traveling)
    parser  = upload.parsers.first

    assert_equal "Snake Plissken"      , parser.purchaser_name   , 'uploads purchaser name'
    assert_equal "$10 off $20 of food" , parser.item_description , 'uploads item description'
    assert_equal 10.0                  , parser.item_price       , 'uploads item price'
    assert_equal 2                     , parser.purchase_count   , 'uploads puchase count'
    assert_equal "987 Fake St"         , parser.merchant_address , 'uploads merchant address'
    assert_equal "Bob's Pizza"         , parser.merchant_name    , 'uploads merchant name'
  end
end
