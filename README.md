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

If you prefer a collection of already filled objects from a specific class you can pass the csv path and the class:

```ruby
Csvash.modelify '/path/of/your/file.csv', User
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request