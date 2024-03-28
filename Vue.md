
###  安装Vue
```bash
npm init vue@latest
```

✔ Project name: … 项目名称-admin

✔ Add TypeScript? … No

✔ Add JSX Support? … Yes 

✔ Add Vue Router for Single Page Application development? … Yes

✔ Add Pinia for state management? …  Yes

✔ Add Vitest for Unit Testing? … No 

✔ Add an End-to-End Testing Solution? › No

✔ Add ESLint for code quality? … No

✔ Add Vue DevTools 7 extension for debugging? (experimental) … No

###  删除以下文件
```bash
项目名称-admin/jsconfig.json
项目名称-admin/README.md
项目名称-admin/src/下的所有文件
```

###  创建以下文件
```bash
项目名称-admin/.env
项目名称-admin/.env.development
项目名称-admin/.env.production
项目名称-admin/src/main.js
项目名称-admin/src/api/index.js
项目名称-admin/src/assets/styles/main.scss
项目名称-admin/src/config/i18n.js
项目名称-admin/src/config/menus.js
项目名称-admin/src/config/routes.js
项目名称-admin/src/config/settings.js
项目名称-admin/src/views/dashboard/index.vue
项目名称-admin/src/views/admins/index.vue
```

### 运行以下下命令
```bash
cd src/
git submodule add git@github.com:DarkBlackLight/manage-vue.git
```

### 添加下列代码至 项目名称-admin/.env
```bash
VITE_DEFAULT_LOCALE=zh
```

### 添加下列代码至 项目名称-admin/.env.development
```bash
VITE_API_URL=http://localhost:3000/api/admin
```

### 添加下列代码至 项目名称-admin/.env.production
```bash
VITE_API_URL=/api/admin
```

### 添加下列代码至 项目名称-admin/src/api/index.js
```bash
import {Auth, Storage, Resources, Request} from '@/manage-vue/api/service'

const Dashboard = {
    index: (params) => Request.get('/dashboard/index', params),
}

const Admins = Resources('admins', 'admin')

export default {
    Auth: Auth,
    Storage: Storage,
    Dashboard,
    Admins,
}
```

### 添加下列代码至 项目名称-admin/src/config/i18n.js
```bash
const translations = {}

export default translations
```

### 添加下列代码至 项目名称-admin/src/config/menus.js
```bash
import {markRaw} from 'vue'
import {HomeFilled, UserFilled} from '@element-plus/icons-vue'

const menus = [
    {
        name: '信息总览',
        icon: markRaw(HomeFilled),
        path: '/',
        children: []
    },
    {
        name: '人员管理',
        icon: markRaw(UserFilled),
        path: '/admins',
        children: []
    }
]
export default menus
```

### 添加下列代码至 项目名称-admin/src/config/routes.js
```bash
import DefaultLayout from '@/manage-vue/views/layouts/DefaultLayout.vue'
import AuthLayout from '@/manage-vue/views/layouts/AuthLayout.vue';

const routes = [
    {
        path: '/login',
        name: 'login',
        component: AuthLayout
    },
    {
        path: '/dashboard',
        component: DefaultLayout,
        children: [
            {
                path: '/',
                component: () => import('@/views/dashboard/index.vue'),
            },
        ]
    },
    {
        path: '/admins',
        component: DefaultLayout,
        children: [
            {
                path: '',
                component: () => import('@/views/admins/index.vue'),
            },
        ]
    },
]
export default routes
```


### 添加下列代码至 项目名称-admin/src/config/settings.js
```bash
const settings = {
    logoPath: '/admin/images/logo.png',
    fullTitle: 'XXX系统',
    shortTitle: 'XXX',
    layout: {
        sideMenu: {
            width: '200px'
        }
    }
}

export default settings
```


### 添加下列代码至 项目名称-admin/src/views/dashboard/index.vue
```bash
<h1>Hello World</h1>
```

### 添加下列代码至 项目名称-admin/src/views/admins/index.vue
```bash
<template>
  <ResourceIndex :resourceConfig="resourceConfig"
                 :listConfig="listConfig"
                 :showConfig="showConfig"
                 :editConfig="editConfig"
                 :newConfig="newConfig"/>
</template>

<script lang="jsx" setup>
import ResourceIndex from "@/manage-vue/components/Resources/ResourceIndex"
import {useAuth} from '@/manage-vue/stores/auth';

const authStore = useAuth();

const resourceConfig = {
  resourceData: 'Admins',
  resourceName: '管理员',
}

const listConfig = {
  title: '管理员列表',
  actions: ['show', 'new', 'edit', 'delete'],
  filters: [
    {
      prop: 'query_name',
      label: '姓名',
      props: {
        placeholder: '姓名'
      },
    },
    {
      prop: 'query_email',
      label: '邮箱',
      props: {
        placeholder: '邮箱'
      },
    },
    {
      prop: 'query_role',
      label: '角色',
      type: 'options',
      props: {
        placeholder: '角色'
      },
      options: [
        {
          value: 'admin',
          label: '管理员',
        },
        {
          value: 'superadmin',
          label: '超级管理员',
        }
      ],
    },
  ],
  columns: [
    {
      prop: 'name',
      label: '姓名'
    },
    {
      prop: 'user.email',
      label: '邮件',
      type: 'text'
    },
    {
      prop: 'role',
      label: '角色',
      render: (r) => (
        <el-tag type="success" disable-transitions>
          {r.role === 'admin' ? '管理员' : '超级管理员'}
        </el-tag>
      )
    },
    {
      prop: 'created_at',
      label: '创建时间',
      type: 'datetime'
    }
  ]
}

const showConfig = {
  title: '用户详情',
  columns: [
    {
      prop: 'name',
      label: '姓名'
    },
    {
      prop: 'user.email',
      label: '邮件',
      type: 'text'
    },
    {
      prop: 'role',
      label: '角色',
      render: (r) => (
        <el-tag type="success" disable-transitions>
          {r.role === 'admin' ? '管理员' : '超级管理员'}
        </el-tag>
      )
    },
    {
      prop: 'created_at',
      label: '创建时间',
      type: 'datetime'
    }
  ]
}

const formConfig = [
  {
    prop: 'name',
    label: '姓名',
    type: 'text',
    span: 18
  },

  {
    prop: 'role',
    label: '角色',
    type: 'options',
    span: 18,
    options: [
      {
        value: 'admin',
        label: '管理员',
      },
      {
        value: 'superadmin',
        label: '超级管理员',
      }
    ],
  },

]

const editConfig = {
  title: '用户编辑',
  columns: [
    ...formConfig,
    ...[
      {
        prop: 'user',
        label: '用户',
        type: 'association',
        columns: [
          {
            prop: 'email',
            label: '邮箱',
            type: 'text',
            span: 18
          },
        ]
      },
    ]
  ]
}

const newConfig = {
  title: '用户新建',
  columns: [
    ...formConfig,
    ...[
      {
        prop: 'user',
        label: '用户',
        type: 'association',
        columns: [
          {
            prop: 'email',
            label: '邮箱',
            type: 'text',
            span: 18
          },
          {
            prop: 'password',
            label: '密码',
            type: 'password',
            span: 18
          },
          {
            prop: 'password_confirmation',
            label: '确定密码',
            type: 'password',
            span: 18
          }
        ]
      },
    ]
  ]
}
</script>
```

### 添加下列代码至 项目名称-admin/package.json 里的dependencies对象下
```bash
"axios": "^1.4.0",
"element-plus": "^2.3.7",
"moment": "^2.29.4",
"pinia-plugin-persistedstate": "^3.1.0",
"sass": "^1.63.6",
"sortablejs": "^1.15.0",
"vue-i18n": "^9.2.2",
```

### 运行以下命令
```bash
npm install
npm run dev
```