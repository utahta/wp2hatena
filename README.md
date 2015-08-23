# Wp2hatena

[WIP]
WordPressエクスポートデータから画像を抽出して、はてなフォトライフにアップロードし、aタグをはてな記法に置換するライブラリ

## Installation

Add this line to your application's Gemfile:

```bash
$ git clone https://github.com/utahta/wp2hatena.git
$ cd wp2hatena
$ bundle
```

## Usage

```bash
$ ./bin/wp2hatena_oauth
```

access to `http://localhost:4567`

```bash
$ ./bin/wp2hatena
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/utahta/wp2hatena. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

