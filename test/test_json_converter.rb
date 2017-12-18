require 'minitest/autorun'
require 'ludovic/json_converter'
require 'yaml'

class TestJsonConverter < Minitest::Test
  attr_reader :json_converter

  def setup
    @json_converter = Ludovic::JsonConverter.new.load_file('test/fixtures/users.json')
  end

  def test_headers
    expected = [
      "id", "email", "tags", "profiles.facebook.id",
      "profiles.facebook.picture", "profiles.twitter.id",
      "profiles.twitter.picture"
    ]
    assert_equal expected, json_converter.headers
  end

  def test_diggers
    expected = [
      ["id"], ["email"], ["tags"], ["profiles", "facebook", "id"],
      ["profiles", "facebook", "picture"], ["profiles", "twitter", "id"],
      ["profiles", "twitter", "picture"]
    ]
    assert_equal expected, json_converter.diggers
  end

  def test_to_csv
    expected = File.read("test/fixtures/users.csv")
    io = StringIO.new
    json_converter.to_csv(io)
    assert_equal expected, io.string
  end
end
