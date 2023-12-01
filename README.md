# Manage API

## 安装方法

1. 创建项目

```bash
$ rails new 项目名称 --api
```

2. 添加以下内容到.gitignore

```text
.idea
```

3. 添加以下内容到Gemfile

```ruby
gem 'jwt'
gem 'bcrypt'
gem 'cancancan'
gem 'kaminari'
gem "rack-cors"
gem "manage-api", git: 'https://github.com/DarkBlackLight/manage-api'
```

4. 运行以下命令

```bash
$ bundle
$ rails active_storage:install
$ rails manage_api_engine:install:migrations
$ rails generate manage
```

## 使用方法

### 添加新的Scope路径, 示例为 Admin

```bash
$ rails generate manage_scope Admin
```

### 为Scope路径验证添加用户表, (示例为 Admin)

1. 运行以下命令

```bash
$ rails g model admin name:string role:integer --force
```

2. 添加下列代码至 app/models/admin.rb

```ruby
has_one :user, as: :source, dependent: :destroy
accepts_nested_attributes_for :user
```

### 通过resource添加新控制器, (示例为 admin 路径下 admins)

```bash
$ rails generate manage_resource admin:admins
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
