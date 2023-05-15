import DefaultLayout from '@/manage-vue/layouts/DefaultLayout.vue'

const routes = [
    {
        path: '/',
        name: 'home',
        component: DefaultLayout,
    },
    {
        path: '/admins',
        name: 'admins',
        redirect: '/admins/index',
        component: DefaultLayout,
        children: [
            {
                path: 'index',
                // name: 'index',
                component: () => import('../views/admins/index.vue'),
            },
        ]
    },
    {
        path: '/login',
        name: 'login',
        component: () => import('@/manage-vue/layouts/LoginLayout.vue')
    }
]
export default routes