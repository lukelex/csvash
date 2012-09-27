require 'minitest/spec'
require 'minitest/autorun'
require 'csvash'
require "./test/test_helper"

include TestHelper

describe 'Overrides' do
  it "checks for the import and export methods existence" do
    Csvash.respond_to?('modelify_and_import').wont_equal false
    Csvash.respond_to?('modelify_and_export').wont_equal false
  end
end