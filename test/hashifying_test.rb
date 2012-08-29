require 'minitest/spec'
require 'minitest/autorun'
require 'csvash'
require "./test/test_helper"

include TestHelper

describe 'Hashifiyng' do
  it "checking columns" do
    hash = Csvash.hashify fetch_fixture_path('example.csv')
    hash.first.keys.size.must_equal 5
    hash.first.keys.must_equal [:year, :make, :model, :description, :price]
  end

  it "checking values" do
    hash = Csvash.hashify fetch_fixture_path('example.csv')
    txt = File.read fetch_fixture_path('example_values.txt')
    hash.map(&:values).must_equal eval(txt)
  end
end