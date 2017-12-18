<template>
  <div class="ui container">
    <h2 class="ui center aligned icon header">
      <i class="circular users icon"></i>
      Your Friends
    </h2>
    <div class="ui four cards special">
        <friend-card v-for='(user, index) in friends'
          :key='user.id' :user='user' @remove-request='removeRequest(index)'/>
    </div>
    <confirm-modal v-show="false" :user="toBeDeleted"/>
  </div>
</template>

<script>
import FriendCard from './FriendCard'
import ConfirmModal from './ConfirmModal'

export default {
  components: {
    'friend-card': FriendCard,
    'confirm-modal': ConfirmModal
  },
  data () {
    return {
      friends: [{
        id: 1,
        nickname: '3abfatta7'
      }],
      toBeDeletedIndex: -1
    }
  },
  methods: {
    removeRequest: function (index) {
      alert(index)
      toBeDeletedIndex = index
      // TODO: make model apper
    }
  },
  computed: {
    toBeDeleted: function () {
      return this.friends[this.toBeDeletedIndex] || {}
    }
  },
  beforeCreate: async function () {
    let headers = {
      'access-token': 'D1knepNNt6rqu6Mz-5odpQ',
      'client': 'H3RwHFFkkOaOJU7FkL-LGg',
      'uid': 'test@test.com',
      'token-type': 'Bearer'
    }
    try {
      let response = await this.$http.get('http://localhost:3000/friendships', { headers })
      this.friends = response.body
    } catch (e) {
      // TODO: Handle this
      console.log(e)
    }
  }
}
</script>

<style>

</style>
