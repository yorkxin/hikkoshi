# Hikkoshi::Logdown

Hikkoshi support for Logdown.

Extended from Jekyll because there are some trolls in Logdown's export files and they're not Jekyll-compatible.

## Installation

    $ gem install hikkoshi-logdown

## Usage

TODO: Write usage instructions here

## Known Issues

* All posts will become "published". There is no draft / published flag in Logdown's export file.
* All files will become "posts". A "static page" in Logdown is still marked as `layout: post` in export file.
* If you export to Jekyll, the Mathjax syntax from Logdown will bite you. Simply remove those <code>\`\`\`mathjax</code> snippets from all Markdown files and Jekyll will be happy.
* If you got YAML parse error, check whether there is any markdown file contains the following front-matter:

        title: 'Santa's travel'

  This is obviously an syntax error in YAML. Logdown does not escape these cases properly. The workarounds may be replacing the apostrophe `'` (U+0027) by a real single quote `’` (U+2019), or simply removing the outer quotes.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/hikkoshi-logdown/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
