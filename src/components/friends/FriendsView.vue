<template>
  <div class="ui container">
    <h2 class="ui center aligned icon header">
      <i class="circular users icon"></i>
      Your Friends
    </h2>
    <div class="ui four cards special">
        <friend-card v-for='(user, index) in friends'
          :key='user.id' :user='user' :showUnfriend="true" @removeRequest='removeRequest(index)'/>
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
      friends: [],
      toBeDeletedIndex: -1,
      deleteRequest: false
    }
  },
  methods: {
    removeRequest: function (index) {
      this.toBeDeletedIndex = index
      $('#remove-modal').modal('show')
    },
    unfriend: async function () {
      let friend = this.friends[this.toBeDeletedIndex]
      // Delete request to the api to delete this friendship
      let friendId = friend.id
      try {
        await this.$http.delete(`friendships/${friendId}`)
        this.friends.splice(this.toBeDeletedIndex, 1)
        $('#remove-modal').modal('hide')
      } catch (e) {
        console.log(e)
      }
    }
  },
  computed: {
    toBeDeleted: function () {
      return this.friends[this.toBeDeletedIndex] || {}
    }
  },
  beforeCreate: async function () {
    try {
      let response = await this.$http.get('friendships')
      this.friends = response.body
    } catch (e) {
      // TODO: Handle this
      // console.log(e)
    }
  }
}
</script>

<style>

</style>
