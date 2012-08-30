require 'csvash/version'
require 'csv'

module Csvash
  class << self; attr_accessor :mass_assignment_safe end

  # <b>DEPRECATED:</b> Please use <tt>hashify</tt> instead.
  def self.import_from_path(path)
    warn "[DEPRECATION] `import_from_path` is deprecated. Please use `hashify` instead."
    hashify path
  end

  def self.hashify(path)
    import path do |collection, current_line|
      collection << current_line
    end
  end
  
  def self.modelify(path, klass)
    klass = klass.to_s.classify.constantize if klass.is_a?(String) || klass.is_a?(Symbol)
    import path do |collection, current_line|
      handle_mass_assignment(klass, current_line)
      collection << klass.new(current_line)
    end
  end

private
  def self.import(path, &block)
    cols = nil
    collection = []
    first_line = true

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

  def self.handle_mass_assignment(klass, line)
    if mass_assignment_safe
      attr_cols = klass.instance_methods(false)
      line = line.delete_if {|col| !attr_cols.include? col}
    end
  end
  
  # generates a csv file into a given path
  # creates the path if necessary (ex: *tmp/klass/desired/path - where *tmp holds the upcoming directories)  
  def self.export(file, klass, &block)
  
  end
  
  # shifts the method calling towards export() or import()
  def method_missing(method, *args)
  end
  
end