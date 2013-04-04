# Attribeautiful

Dynamically-generated HTML element attribute management methods.
Easily add attributes to an element, or content to an attribute value.

## Installation

Add this line to your application's Gemfile:

    gem 'attribeautiful'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install attribeautiful

## Usage

```ruby
class SectionBlock
  include Attribeautiful

  html_element :header
  html_element :body

  def initialize
    yield self if block_given?
    self
  end
end

sb = SectionBlock.new do |sb|
  sb.header_class_add "important", "slick"

  sb.header_custom_one_add "do-something"
  sb.header_custom_two_add "do-something-else"
  sb.header_custom_two_use_underscores

  sb.body_id_add      "specific-section-id"
  sb.body_style_add   "float:left", "color:blue"
  sb.body_style_add   "position:relative"
  sb.body_style_use_semicolons
end

puts "#{sb.header_class_attr}"        # class="important slick"
puts "#{sb.header_custom_one_attr}"   # custom-one="do-something"
puts "#{sb.header_custom_two_attr}"   # custom_two="do-something-else"
puts "#{sb.body_id_attr}"             # id="specific-section-id"
puts "#{sb.body_class_attr}"          # nothing!
puts "#{sb.body_style_attr}"          # style="float:left;color:blue;position:relative"
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
