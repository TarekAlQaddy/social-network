<template>
  <div class="ui container">
    <h2 class="ui center aligned icon header">
      <i class="circular users icon"></i>
      Your Friends
    </h2>
    <div class="ui four cards special">
        <friend-card v-for='(user, index) in friends'
          :key='user.id' :user='user' @removeRequest='removeRequest(index)'/>
    </div>
    <confirm-modal @confirmDelete='unfriend' :user="toBeDeleted"/>
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
        nickname: '3abfatta7',
        firstName: '3ab',
        lastName: 'Fattah'
      }],
      toBeDeletedIndex: -1,
      deleteRequest: false
    }
  },
  methods: {
    removeRequest: function (index) {
      this.toBeDeletedIndex = index
      $('.ui.modal').modal('show')
    },
    unfriend: async function () {
      let friend = friends[toBeDeletedIndex]
      // Delete request to the api to delete this friendship
      console.log(friend.id)
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
