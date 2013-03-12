# Fakie

Ruby [libphonenumber](http://code.google.com/p/libphonenumber) wrapper with [ExecJS](https://github.com/sstephenson/execjs).

## Installation

Add this line to your application's Gemfile:

``` ruby
gem 'fakie'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fakie

## Usage

``` ruby
> phone = Fakie.parse('415-555-0123', default_country: 'US')
#=> <Fakie::PhoneNumber @country_code=1, @national_number=4155550123, @raw_input="415-555-0123", @country_code_source=20, @preferred_domestic_carrier_code="", @is_possible=true, @is_valid=true, @region_code="US", @type="FIXED_LINE_OR_MOBILE">
> phone.e164
=> "+14155550123"
> phone.country_code
> 1
> phone.local_format
=> "(415) 555-0123"
> phone.internation_format
=> "+1 415-555-0123"
> phone.country_name
=> "United States"
```

## Supported Ruby Versions

Fakie is tested under 1.8.7, 1.9.2, 1.9.3, 2.0.0, JRuby 1.7.2 (1.9 mode), and Rubinius 2.0.0 (1.9 mode).

[![Build Status](https://travis-ci.org/seesawco/fakie.png?branch=master)](https://travis-ci.org/seesawco/fakie)

## Contributing

See the [contributing guide](Contributing.markdown).

To update libphonenumber, simply run `rake import`. It will download and build the neccessary files. You'll need closure-compiler installed to do it.
