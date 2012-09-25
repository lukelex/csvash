require 'csvash/version'
require 'csv'

module Csvash
  class << self; attr_accessor :mass_assignment_safe end
  @@mass_assignment_safe = false

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
    self.public_send method, path, klass do |collection, current_line|
      handle_mass_assignment(klass, current_line)
      collection << klass.new(current_line)
    end
  end

  def self.setup
    yield self
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

  # generates a csv file into a given path
  # a path must be given (ex: *path/to/file.csv)
  def self.export(file, collection, &block)
    file = full_path(file)

    unless collection.empty?
      headers = retrieve_headers collection
      begin
        CSV.open(file, 'wb', :col_sep => "\;") do |csv|
          csv << headers
          collection.each do |item|
            csv << retrieve_fields(item, headers)
          end
        end
      rescue Errno::ENOENT => e
        puts e
      end
    end
  end

  def self.handle_mass_assignment(klass, line)
    if mass_assignment_safe
      attr_cols = klass.instance_methods(false)
      line = line.delete_if { |col| !attr_cols.include? col }
    end
  end

  # shifts the method calling towards export() or import()
  # ex: modelify_and_import("path/to/file.csv", collection), modelify_and_export("path/to/custom_filename.csv", collection)
  def self.method_missing(method_name, *args)
    super unless method_name =~ /^modelify_and_(\w+)$/
    Csvash.public_send(:modelify, *args, $1)
  end

  # overriding respond_to method
  def respond_to?(method)
    (method =~ /^modelify_and_\w+$/) || super
  end

  # creates the full path
  def self.full_path(file)
    splitted = file.split("/")
    current_file = file.split("/").last
    current_path = splitted.shift(splitted.size-1)
    current_full_path = current_path.join("/") + "/"

    FileUtils.mkdir_p(current_full_path) unless File.directory? current_full_path
    current_full_path.concat current_file
  end

  def self.retrieve_headers collection
    collection.first.class.instance_methods(false).select { |m| m.to_s !~ /=$/ }
  end

  def self.retrieve_fields item, headers
    headers.map { |attribute| item.public_send(attribute) }
  end
end