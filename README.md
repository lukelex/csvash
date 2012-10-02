# Csvash

Got tired of parsing CSV files to your Models, or exporting into it?
Csvash automates that process for you. It handles your CSV extraction by mapping the document headers with your model properties and automagically creating new filled instances.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'csvash'
```

And then execute:

```
$ bundle
```

Not using Rails? install it yourself with:

```
$ gem install csvash
```

## Usage

First of all you have to require it in your file:

```ruby
require 'csvash'
```

In order to import from a CSV file you can pass the path where the file is allocated and a class:

```ruby
Csvash.modelify_and_import '/path/of/your/file.csv', User
```


However, to export you can pass the desired path and CSV filename. Finally, you can pass a collection of already filled objects from a specific class:

```ruby
Csvash.modelify_and_export '/path/to/file.csv', collection
```

_Where **collection** is an array of User objects, for example_
_* The path and its directories are created automatically_

To get just a collection of hashes containing the csv data you can call:

```ruby
Csvash.hashify '/path/of/your/file.csv'
```

##Options

There are some behavior options that can be changed with its initializer. To create it just type:

```
$ rails generate initializer csvash
```

These are the avaiable options

```ruby
# If set to true it will only retain fields that matches the class to be filled. Default is false.
# config.mass_assignment_safe = true
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request