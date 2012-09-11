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

Now, Csvash allows manage CSV files through export or import actions.

To import, if you prefer a collection of already filled objects from a specific class you can pass the csv path and the class:

```ruby
Csvash.modelify_and_import '/path/of/your/file.csv', User
```
However, to export csv files from a collection of objects (an ORM objects, whatever) you can pass the path plus the desired filename to the csv file and the collection itself.

```ruby
Csvash.modelify_and_export 'path/to/file.csv', collection
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