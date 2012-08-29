require 'minitest/spec'
require 'minitest/autorun'
require 'csvash'
require "./test/test_helper"

include TestHelper

describe 'Modelifying' do
  it "passing the class" do
    cars_extracted = Csvash.modelify fetch_fixture_path('example.csv'), Car
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
end

class Car
  def initialize(params)
    self.year = params[:year]
    self.make = params[:make]
    self.model = params[:model]
    self.description = params[:description]
    self.price = params[:price]
  end
  attr_accessor :year, :make, :model, :description, :price
end