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

## Contributing

See the [contributing guide](Contributing.markdown).
