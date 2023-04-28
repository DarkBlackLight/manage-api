import {Auth, Storage, Resources, Request} from '@/manage-vue/api/service'

const Admins = Resources('admins', 'admin')

export default {
    Auth: Auth,
    Storage: Storage,
    Admins,
}
