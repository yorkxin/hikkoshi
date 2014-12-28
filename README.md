# Hikkoshi the Blog Moving Tools

A tool for blog migration.

## Currently Supported

| Blog System | Import | Export | Notes |
|-------------|--------|--------|-------|
| Jekyll      | Yes    | Yes    | Only Markdown files are supported. |
| Hexo        | Yes    | Yes    | File names will become date-prefixed. |
| Logdown     | Yes    | No     | All posts will become published. |
| Ghost       | No     | Yes    | Markdown tables will be converted to HTML w/ original Markdown source. |

**Import** means "moving from A", and **export** means "moving to A".

Think as a meta-blog-system that can only do import / export.

## Installation

Install the core functionality:

    $ gem install hikkoshi

And install the extensions of Hikkoshi that you want for blog migration:

    $ gem install hikkoshi-jekyll
    $ gem install hikkoshi-ghost

## Usage

For example, you're currently using Jekyll and want to move to Ghost:

```shell-session
$ hikkoshi -f jekyll -t ghost -i ~/jekyll-blog/_posts/ -o ~/tmp/ghost.json
```

* `-f`: Your current blog system.
* `-t`: Your target blog system.
* `-i`: Location of your current blog posts or backup file.
* `-o`: Location to store the exported file(s).

## Known Issues

* Time zone of posts will become the local time zone of your machine.
* Only single-user blog is supported. All exported posts will belong to one user.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/hikkoshi/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

MIT License. See "LICENSE.txt".
