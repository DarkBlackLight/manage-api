# Manage API

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
$ rails generate manage
```

## 使用方法

定义 Scope, 并运行以下命令

```bash
$ rails generate scope Scope
```

如 Scope 为 Admin

```bash
$ rails generate scope Admin
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
