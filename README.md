# Csvash

Csvash automates your CSV extraction by mapping its headers with the columns contents and turning them into hashes that can be easily converted into ruby models.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'csvash'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install csvash
```

## Usage

First of all you have to require it in your file:

```ruby
require 'csvash'
```

To get a collection of hashes containing the csv data you can call:

```ruby
Csvash.hashify '/path/of/your/file.csv'
```

Note: You can use `modelify_and_export` or `modelify_and_import` methods to generate or parse csv files respectively.

In order to export, you can pass the desired path and CSV filename. Finally, you can pass a collection of already filled objects from a specific class you can pass the array:

```ruby
Csvash.modelify_and_export '/path/to/file.csv', collection
```

_Where **collection** is an array of User objects, for example_

However, to import from a csv file you can pass the path where the file is allocated and a class, as usual:

```ruby
Csvash.modelify_and_import '/path/of/your/file.csv', User
```

_* The path and its directories are created automatically_

##Options

There are some behavior options that can be changed with its initializer. To create it just type:

```
$ rails generate initializer csvash
```

These are the avaiable options

```ruby
# If set to true it will only retain fields that matches the class to be filled. Default is false.
# Csvash.mass_assignment_safe = true
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request