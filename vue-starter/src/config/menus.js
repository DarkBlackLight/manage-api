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
        children: [
            {
                name: '用户管理',
                path: '/admins',
            }
        ]
    }
]
export default menus