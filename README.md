# Manage API

## 安装方法

1. 创建项目 project

```bash
$ rails new project --api
```

示例 项目名称为 igogo

```bash
$ rails new igogo --api
```

2. 添加以下内容到.gitignore

```text
.idea
.vscode
```

3. 添加以下内容到Gemfile

```ruby
gem 'jwt'
gem 'bcrypt'
gem 'cancancan'
gem 'kaminari'
gem "rack-cors"
gem "manage-api"

```

4. 运行以下命令

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

示例 Scope 为 Admin

```bash
$ rails generate scope Admin
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
