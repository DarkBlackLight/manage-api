# Manage API

## 安装方法

1. 创建项目

```bash
rails new 项目名称 --api
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
gem "manage-api", '0.1.0', git: 'https://github.com/DarkBlackLight/manage-api'
```

4. 运行以下命令

```bash
bundle
rails active_storage:install
rails manage_api_engine:install:migrations
rails generate manage
```

## 使用方法

### 添加新的Scope路径, 示例为 Admin

```bash
rails generate manage_scope Admin
```

### 为Scope路径验证添加用户表, (示例为 Admin)

1. 运行以下命令

```bash
rails g model admin name:string role:integer --force
```

2. 添加下列代码至 app/models/admin.rb

```ruby
scope :query_name, -> (q) { joins(:user).where('lower(admins.name) like lower(?) or lower(users.username) like lower(?)', "%#{q}%", "%#{q}%") }

enum role: [:superadmin, :admin]

has_one :user, as: :source, dependent: :destroy
accepts_nested_attributes_for :user
```

### 通过resource添加新控制器, (示例为 admin 路径下 admins)
1. 运行以下命令
```bash
rails generate manage_resource admin:admins
rails generate manage_resource admin:dashboard
```

2. 添加下列代码至 app/controllers/api/admin/admins_controller.rb
```bash
def filter_params
  params.slice(:query_name)
end

def resource_params
  params.require(:admin).permit(:name, :role, user_attributes: [:id, :username, :email, :password, :password_confirmation])
end
```

### Bundle Package Gems
```bash
bundle config specific_platform true
bundle lock --add-platform x86_64-linux
bundle package --all --all-platforms
```

### 添加下列代码至 app/models/application_record.rb
```bash
include Rails.application.routes.url_helpers
```

### 添加下列代码至 config/environments/development.rb
```bash
Rails.application.routes.default_url_options[:host] = 'http://localhost:3000'
```

### 添加下列代码至 config/environments/production.rb
```bash
Rails.application.routes.default_url_options[:host] = ENV['HOST']
```

### 项目默认为邮箱登录，修改为用户名登录，添加下列代码至 app/models/user.rb
```bash
def authenticate_method
  'password'
end
```

### 添加下列代码至 db/seeds.rb
```bash
ActiveRecord::Base.transaction do
  Admin.create!(name: 'superadmin', role: :superadmin, user_attributes: { username: 'superadmin', email: 'superadmin@xxxx.com', password: '123456' })
  Admin.create!(name: 'admin', role: :admin, user_attributes: { username: 'admin', email: 'admin@xxxx.com', password: '123456' })
end
```

### 运行以下命令
```bash
rails db:create
rails db:migrate
rails db:seed
```

### 安装vue请看Vue.md

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
