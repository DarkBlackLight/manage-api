# Manage API

Short description and motivation.

## 安装方法

1. 添加以下内容到Gemfile

```ruby
gem 'jwt'
gem 'bcrypt'
gem 'cancancan'
gem 'kaminari'
gem "rack-cors"
gem "manage-api"

```

2. 运行以下命令

```bash
$ bundle
$ rails manage_api_engine:install:migrations
$ rails manage_api:install
```

3. 添加以下代码至 app/models/application_record.rb

```ruby
  include Filterable
```

## Contributing

Contribution directions go here.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
