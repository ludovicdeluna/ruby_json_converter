# Exploring algorithm
require 'json'
require 'pp'
json = JSON.load(File.read('users.json'))


def get_deep_keys(obj)
  obj.map do |k, v|
    other_keys = get_deep_keys(obj[k]) if v.respond_to?(:keys)
    other_keys ? {k => other_keys} : k
  end
end

pp get_deep_keys(json.first)

