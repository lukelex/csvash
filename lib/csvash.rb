require 'csvash/version'
require 'csv'
require 'fileutils'

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

  # <b>DEPRECATED:</b> Please use <tt>modelify_and_export</tt> or <tt>modelify_and_import</tt> instead.
  def self.modelify(path, klass, *args)
    klass = klass.to_s.classify.constantize if klass.is_a?(String) || klass.is_a?(Symbol)
    method = args.first
    # rejecting attributes
    unless method.is_a?Hash
      self.public_send method , path, klass do |collection, current_line|
        handle_mass_assignment(klass, current_line)
        collection << klass.new(current_line)
      end
    else
    end
  end


private
  
  def self.import(path, *optionals, &block)
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
  # creates the path if necessary (ex: *tmp/desired/path - where *tmp holds the upcoming directories)  
  def self.export(file, klass, reject=[], &block)
    rows = []
    file = self.full_path(file)
    # retrieving instance method names (getters)
    klass.instance_methods(false).delete_if {|m| rows << m unless m.to_s.include?"=" }
    #gotta find an way to find the records by attributes
    #lines = klass.find
    begin
      csv_return = nil
      CSV.open(file, 'wb') do |csv|  
        csv << rows
        csv_return = csv
      end
      csv_return
    rescue Errno::ENOENT => e
      puts e
    end
  end

  # shifts the method calling towards export() or import()
  # ex: modelify_and_import("path/to/file.csv", User), modelify_and_export("path/to/custom_filename.csv", User)
  def self.method_missing(method_name, *args)
    super unless method_name =~ /^modelify_and_(\w+)$/
    Csvash.public_send(:modelify, *args, $1)
  end

  # overriding respond_to method
  def respond_to?(method)
    (method =~ /^modelify_and_(\w+)$/) || super
  end

  # creates a tmp file
  def self.full_path(file)
    path = "tmp/"
    if File.directory?(path)
      (path).concat(file)
    else
      FileUtils.mkdir_p(path)
      (path).concat(file)
    end
  end

end