require 'csv'

class FileParser

  def self.process(file_traveling)
    new(file_traveling)
  end

  attr_reader :parsers

  def initialize(file_traveling)
    
    @parsers = []

    CSV.foreach(file_traveling, :col_sep => "\t", :skip_blanks => true, :headers => true) do |row|
      upload_row(row)
    end
  end

  private

  def upload_row(row)
    
    parser = Parser.new(
      :purchaser_name   => row["purchaser name"],
      :item_description => row["item description"],
      :item_price       => row["item price"].to_f,
      :purchase_count   => row["purchase count"].to_i,
      :merchant_address => row["merchant address"],
      :merchant_name    => row["merchant name"]
    )

    if parser.save
      @parsers << parser
	 else
      @logger.warn "[Failed to load file] [#{Time.now}] #{row.inspect}"
    end
  end
end
