Json Converter
==============

Translate an array of objects from JSON to CSV. See [objectives](overview.pdf)
(PDF) for more informations about this funny test.


# Usage

```ruby
require 'ludovic/json_converter'

users_converter = Ludovic::JsonConverter.new
users_converter.data = "[
  {
    "id": 0,
    "email": "colleengriffith@quintity.com",
    "tags": [
      "consectetur",
      "quis"
    ],
    "profiles": {
      "facebook": {
        "id": 0,
        "picture": "//fbcdn.com/a2244bc1-b10c-4d91-9ce8-184337c6b898.jpg"
      },
      "twitter": {
        "id": 0,
        "picture": "//twcdn.com/ad9e8cd3-3133-423e-8bbf-0602e4048c22.jpg"
      }
    }
  }
]"

users_converter.write_csv('path/to/csv')
# => Write to a CSV

users_converter.headers
# => Return array of headers :
# [
#  "id",
#  "email",
#  "tags",
#  "profiles.facebook.id",
#  "profiles.facebook.picture",
#  "profiles.twitter.id",
#  "profiles.twitter.picture"
# ]

users_converter.write_csv('users.csv') # Write a CSV

```

If the json file don't follow principles bellow, calls to any methods will
throw a `Ludovic::JsonConverter::BadInput` error :

- The json file contain an array of objects.
- All the objects follow the same structure.
- There are no dot in the key's names.

See also [limitations](#limitations)


# Installation

This gem is not published on rubygem. Its purpose is only amusement.

If you wish to play with, you have two options. Or you copy
`lib/ludovic/json_converter.rb` in your project, or you install the gem :

```
gem build ludovic-json_converter.gemspec
gem install ./ludovic-json_converter-1.0.0.gem
```

Run test with `rake` and remove the gem with
`gem uninstall ludovic-json_converter`

Require Ruby 2.3 or greater.


Limitations
------------

There are limitations because of exercice context. Be aware of :

- On deeper JSON file, Ruby will throw an error on Stack size due to recursive
  calls.
- This lib don't support an array of objects or array of arrays in the JSON. If
  you use it, you get abdormals results in the CSV.
- Do not use dot into your JSON keys, or you get an error. This is a requirement
  to keep consistency in the CSV.


License
-------
[MIT license](LICENSE)
