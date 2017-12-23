import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/login',
      name: 'login',
      component: require('@/components/Login').default
    },
    {
      path: '/',
      name: 'main',
      component: require('@/components/Main').default,
      redirect: '/home',
      meta: { auth: true },
      children: [
        {
          path: 'home',
          name: 'home',
          component: require('@/components/Home').default
        },
        {
          path: 'friends',
          name: 'view_friends',
          component: require('@/components/friends/FriendsView').default
        },
        {
          path: 'friend_requests',
          name: 'friend_requests',
          component: require('@/components/FriendRequests').default
        },
        {
          path: 'profile/edit',
          name: 'profile_edit',
          component: require('@/components/profile/Edit').default
        },
        {
          path: 'profile/:id',
          name: 'user_profile',
          component: require('@/components/profile/Profile').default
        },
        {
          path: 'profile',
          name: 'my_profile',
          component: require('@/components/profile/Profile').default
        },
        {
          path: 'search',
          name: 'search',
          component: require('@/components/Search').default
        }
      ]
    }
  ]
})
