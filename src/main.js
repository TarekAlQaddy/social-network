// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import VueResource from 'vue-resource'
import VueAuth from '@websanova/vue-auth'

Vue.config.productionTip = false
Vue.use(VueResource)
Vue.http.options.root = 'http://localhost:1112'
Vue.router = router

Vue.use(VueAuth, {
  auth: require('@websanova/vue-auth/drivers/auth/devise'),
  http: require('@websanova/vue-auth/drivers/http/vue-resource.1.x'),
  router: require('@websanova/vue-auth/drivers/router/vue-router.2.x'),
  loginData: { url: 'auth/sign_in', method: 'POST', redirect: '/home' },
  registerData: { url: 'auth', method: 'POST', redirect: '/home', fetchUser: true },
  logoutData: { url: 'auth/sign_out', method: 'DELETE', redirect: '/login', makeRequest: true },
  fetchData: { url: 'auth/validate_token', method: 'GET', enabled: true },
  refreshData: { url: 'auth/validate_token', method: 'GET', enabled: true }
})

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  template: '<App/>',
  components: { App }
})
