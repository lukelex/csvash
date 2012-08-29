require "csvash/version"
require 'csv'

module Csvash
  def self.import_from_path(path)
    hashify path
  end

  def self.hashify(path)
    import path do |collection, current_line|
      collection << current_line
    end
  end

  def self.modelify(path, klass)
    klass = klass.to_s.classify.constantize if klass.is_a?(String) || klass.is_a?(Symbol)
    params = import path do |collection, current_line|
      collection << klass.new(current_line)
    end
  end

private
  def self.import(path, &block)
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

      block.call(collection, current_line)
    end
    collection
  end
end