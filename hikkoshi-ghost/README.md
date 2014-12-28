# Hikkoshi::Ghost

Hikkoshi support for Ghost.

    $ gem install hikkoshi-ghost

## Usage

TODO: Write usage instructions here

## Known Issues

* Ghost does not currently support Table syntax in Markdown. These tables will be downgraded to HTML and the original Markdown source will be embedded below the HTML within HTML comments.
* Although Ghost support multiple-users, only single-user is supported.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/hikkoshi-ghost/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Credits

The concept of this tool was from [evilsocket/octoghost](https://github.com/evilsocket/octoghost). I re-built it in Ruby and added some features for me. Thank you, [Simone Margaritelli](https://github.com/evilsocket)!
