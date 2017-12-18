# Exploring algorithm
require 'json'
require 'pp'
json = JSON.load(File.read('users.json'))


# TODO :
# Limitation : field can't contain dot in it's name. Throw error in this case.
def get_deep_keys(hsh)
  hsh.each_with_object([]) do |(field, value), acc|
    other_keys = get_deep_keys(hsh[field]) if value.respond_to?(:keys)
    other_keys ? other_keys.each { |k| acc << "#{field}.#{k}" } : acc << field
  end
end

headers = get_deep_keys(json.first)
diggers = headers.map { |v| v.split('.') }

pp headers
pp diggers # TODO : Limitation : Structure dismatch, on empty dig result, throw error.
