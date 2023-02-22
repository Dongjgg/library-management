import Vue from 'vue'
import VueRouter from 'vue-router'
import Layout from '../views/Layout.vue'
import Cookies from "js-cookie"

Vue.use(VueRouter)

const routes = [
  //==== 登录页面 =====
  {
    path: '/login',
    name: '登录页面',
    component: ()=> import('@/views/login/login')
  },
    //==== 主页 =====
  {
    path: '/',
    name: 'Layout',
    component: Layout,
    redirect: '/home',
    children: [ //子路由
      {
        path: 'home',
        name: 'Home',
        component: ()=>import('@/views/home/HomeView'),
      },
      //==== User =====
      {
        path: 'userList',
        name: '会员列表',
        component: () => import('@/views/user/user')
      },
      {
        path: 'addUser',
        name: '会员添加',
        component: ()=> import('@/views/user/addUser')
      },
      {
        path: 'editUser',
        name: '编辑会员',
        component: ()=> import('@/views/user/editUser')
      },
      // ==== Admin ====
      {
        path: 'adminList',
        name: '管理员列表',
        component: () => import('@/views/admin/list')
      },
      {
        path: 'addAdmin',
        name: '管理员添加',
        component: ()=> import('@/views/admin/add')
      },
      {
        path: 'editAdmin',
        name: '编辑管理员',
        component: ()=> import('@/views/admin/edit')
      },
        //==== Category ====
      {
        path: 'categoryList',
        name: '分类列表',
        component: () => import('@/views/category/list')
      },
      {
        path: 'addCategory',
        name: '分类添加',
        component: ()=> import('@/views/category/add')
      },
      {
        path: 'editCategory',
        name: '编辑分类',
        component: ()=> import('@/views/category/edit')
      },
      //==== Book ====
      { path: 'bookList', name: 'BookList', component: () => import('@/views/book/List.vue') },
      { path: 'addBook', name: 'AddBook', component: () => import('@/views/book/Add.vue') },
      { path: 'editBook', name: 'EditBook', component: () => import('@/views/book/Edit.vue') },
      //  ====  Borrow  ====
      { path: 'borrowList', name: 'BorrowList', component: () => import('@/views/borrow/List.vue') },
      { path: 'addBorrow', name: 'AddBorrow', component: () => import('@/views/borrow/Add.vue') },
      { path: 'editBorrow', name: 'EditBorrow', component: () => import('@/views/borrow/Edit.vue') },
      //  ====  Return  ====
      { path: 'returList', name: 'returList', component: () => import('@/views/retur/List.vue') }
    ]
  },
    //错误页面，上面的路由都没有就会走到这里
  {
    path: "*",
    component: ()=> import('@/views/404')
  }

]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

//路由守卫
router.beforeEach((to, from, next) => {
  if (to.path === '/login') next()
  const admin = Cookies.get("admin")
  if (!admin && to.path !== '/login') return next("/login")  // 强制退回到登录页面
  // 访问 /home 的时候，并且cookie里面存在数据，这个时候我就直接放行
  next()
})

export default router
