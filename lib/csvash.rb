require "csvash/version"
require 'csv'

module Csvash
  def self.import_from_path(path)
    transactions = []

    cols = nil
    first_line = true
    collection = []

    CSV.foreach(path, :encoding => "ISO-8859-1:UTF-8", :col_sep => "\;") do |line|
      if first_line
        # getting colum names and turning them into symbols
        cols = line.map! { |c| c.downcase.to_sym }
        first_line = false
        next
      end

      # map the csv columns with the current line values
      current_line = Hash[cols.zip(line.flatten)]
      # storing the final line result
      collection << current_line
    end
    collection
  end
end