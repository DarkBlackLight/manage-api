<template>
    <ResourceIndex :resourceConfig="resourceConfig"
                   :listConfig="listConfig"
                   :showConfig="showConfig"
                   :editConfig="editConfig"
                   :newConfig="newConfig"/>
</template>

<script lang="jsx" setup>
import ResourceIndex from "@/manage-vue/components/Resources/ResourceIndex"
import API from "@/api"
import {useAuth} from '@/stores/auth';

const authStore = useAuth();

const resourceConfig = {
    resourceData: 'Admins',
    resourceName: '用户',
}

const listConfig = {
    title: '用户列表',
    filters: [
        {
            prop: 'query_name',
            label: '姓名',
            placeholder: '姓名'
        }
    ],
    columns: [
        {
            prop: 'avatar',
            label: '头像',
            type: 'image'
        },
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
            render: (value, scope) => (
                <el-tag type="success" disable-transitions>
                    {value === 'admin' ? '管理员' : value === 'owner' ? '店主' : value === 'staff' ? '员工' : '超级管理员'}
                </el-tag>
            )
        },
        {
            prop: 'shop.name',
            label: '商店'
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
            prop: 'avatar',
            label: '图片',
            type: 'image'
        },
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
            render: (value, scope) => (
                <el-tag type="success" disable-transitions>
                    {value.role === 'admin' ? '管理员' : value.role === 'owner' ? '店主' : value.role === 'staff' ? '员工' : '超级管理员'}
                </el-tag>
            )
        },
        {
            prop: 'shop.name',
            label: '商店'
        },
        {
            prop: 'created_at',
            label: '创建时间',
            type: 'datetime'
        }
    ]
}

const editConfig = {
    title: '用户编辑',
    columns: [
        {
            prop: 'avatar_id',
            label: '头像',
            type: 'image'
        },
        {
            prop: 'name',
            label: '姓名',
            type: 'text',
        },
        {
            prop: 'role',
            label: '角色',
            type: 'options',
            options: [
                {
                    value: 'superadmin',
                    label: '超级管理员',
                },
                {
                    value: 'admin',
                    label: '管理员',
                },
                {
                    value: 'owner',
                    label: '店主',
                },
                {
                    value: 'staff',
                    label: '员工',
                }
            ],
            condition: (resource) => authStore.user.source.role === 'admin' || authStore.user.source.role === 'superadmin'
        },
        {
            prop: 'shop_id',
            label: '商店',
            type: 'remote_options',
            remote_options: {
                remote: () => API.Shops.all().then(response => response.data),
                value: 'id',
                label: 'name'
            },
            condition: (resource) => authStore.user.source.role === 'admin' || authStore.user.source.role === 'superadmin'
        },
        {
            prop: 'user',
            label: '用户',
            type: 'association',
            columns: [
                {
                    prop: 'email',
                    label: '邮箱',
                    type: 'text',
                }
            ]
        }
    ]
}

const newConfig = {
    title: '用户新建',
    columns: editConfig.columns
}
</script>