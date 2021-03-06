require 'minitest/spec'
require 'minitest/autorun'
require 'csvash'
require "./test/test_helper"

include TestHelper

describe 'Modelifying' do
  describe "import" do
    before :each do
      Csvash.setup do |config|
        config.mass_assignment_safe = false
        config.column_separator = ";"
      end
    end
    it "passing the class" do
      cars_extracted = Csvash.modelify_and_import fetch_fixture_path('example.csv'), Car
      car = Car.new(
        year: '1997',
        make: 'Ford',
        model: 'E350',
        description: 'ac, abs, moon',
        price: '3000.00'
      )
      cars_extracted.first.instance_variables.each do |name|
        cars_extracted.first.instance_variable_get(name).must_equal car.instance_variable_get(name)
      end
    end

    it "Mass assignment Safe Mode ON" do
      Csvash.setup { |config| config.mass_assignment_safe = true }
      cars_extracted = Csvash.modelify_and_import fetch_fixture_path('example_mass_assignment.csv'), Car
    end

    it "Changing default column separator" do
      Csvash.setup { |config| config.column_separator = "," }
      cars_extracted = Csvash.modelify_and_import fetch_fixture_path('example_comma.csv'), Car
    end
  end
  describe "export" do
    before :each do
      Dir.mkdir(fetch_fixture_path('tmp'))
    end
    after :each do
      FileUtils.rm_rf fetch_fixture_path('tmp')
    end

    let(:cars_path) { fetch_fixture_path('tmp/cars.csv') }

    it "passing a collection of Car object" do
      cars = []
      3.times do
        cars << Car.new(
          year: '1997',
          make: 'Ford',
          model: 'E350',
          description: 'ac, abs, moon',
          price: '3000.00'
        )
      end
      cars_exported = Csvash.modelify_and_export cars_path, cars
      File.exists?(cars_path).must_equal true
      File.stat(cars_path).size.must_equal 145
    end
  end

end

class Car
  def initialize(params)
    params.each do |key, value|
      self.public_send("#{key}=", value)
    end
  end
  attr_accessor :year, :make, :model, :description, :price
end