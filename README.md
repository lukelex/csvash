# Csvash

[![Build Status](https://secure.travis-ci.org/lukasalexandre/csvash.png)](http://travis-ci.org/lukasalexandre/csvash) [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/lukasalexandre/csvash)

Csvash automates your CSV extraction by mapping its headers with the columns contents and turning them into hashes that can be easily converted into ruby models.

## Installation

Add this line to your application's Gemfile:

    gem 'csvash'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install csvash

## Usage

    Csvash.import_from_path '/path/of/your/file.csv'

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
