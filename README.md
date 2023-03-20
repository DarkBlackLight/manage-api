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

### 添加新的Scope路径, 示例为 Admin

```bash
$ rails generate scope Admin
```

### 为Scope路径验证添加用户表, (示例为 admin)

1. 运行以下命令

```bash
$ rails g model admin name:string
```

2. 添加下列代码至 app/models/admin.rb

```ruby
has_one :user, as: :source, dependent: :destroy
accepts_nested_attributes_for :user
```

3. 添加下列代码至app/controllers/admin_controller.rb

```ruby

def config_source_type
  ['admin']
end
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
