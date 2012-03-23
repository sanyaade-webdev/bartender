# Bartender [![Build Status](https://secure.travis-ci.org/tristandunn/bartender.png?branch=master)](http://travis-ci.org/tristandunn/bartender) [![Dependency Status](https://gemnasium.com/tristandunn/bartender.png)](https://gemnasium.com/tristandunn/bartender)

A Ruby client for [Open Beer Database](https://github.com/tristandunn/openbeerdatabase).

## Example

~~~ ruby
require "bartender"

puts Bartender::Beer.find(1).inspect
~~~

Check out [bartender-example](https://github.com/tristandunn/bartender-example) for a more advanced example.

## License

Bartender uses the MIT license. See LICENSE for more details.
