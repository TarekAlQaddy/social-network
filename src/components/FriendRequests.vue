<template>
  <div style="padding-top: 30px">
    <div class="ui segment" id="requests-tab">
      <div class="ui top attached tabular menu">
        <a class="active item" data-tab="recieved">Recieved</a>
        <a class="item" data-tab="sent">Sent</a>
      </div>
      <div class="ui bottom attached active tab segment" data-tab="recieved">
        <div class="ui four cards">
          <div class="card" v-for="request in recievedFriendRequests">
            <div class="content">
              <img class="right floated mini ui image" :src="getImageFromUser(request.requester)">
              <div class="header">
                {{ getNicknameFromUser(request.requester) }}
              </div>
              <div class="meta">
                {{ request.created_at | moment('LLL') }}
              </div>
            </div>
            <div class="extra content">
              <div class="ui buttons">
                <div class="ui inverted green button" @click="friendRequestAction(request, 'accept')">Approve</div>
                <div style="margin-left: 10px" class="ui inverted red button"
                     @click="friendRequestAction(request, 'reject')">Decline</div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="ui bottom attached tab segment" data-tab="sent">
        <div class="ui four cards">
          <div class="card" v-for="request in sentFriendRequests">
            <div class="content">
              <img class="right floated mini ui image" :src="getImageFromUser(request.requester)">
              <div class="header">
                {{ getNicknameFromUser(request.requester) }}
              </div>
              <div class="meta">
                {{ request.created_at | moment('LLL') }}
              </div>
            </div>
            <div class="extra content">
              <div class="ui inverted fluid red button" @click="cancelRequest(request)">Cancel</div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    data () {
      return {
        recievedFriendRequests: [],
        sentFriendRequests: []
      }
    },
    methods: {
      friendRequestAction (request, action) {
        this.$http.post(`friend_requests/${action}/${request.id}`).then(() => {
          this.fetchRecievedRequests()
        }).catch(error => {
          alert('Something wrong happened!')
          console.log(error)
        })
      },
      cancelRequest (request) {
        this.$http.delete(`friend_requests/${request.id}`).then(() => {
          this.fetchSentRequests()
        }).catch(error => {
          alert('Something wrong happened!')
          console.log(error)
        })
      },
      fetchRecievedRequests () {
        this.$http.get('friend_requests').then(response => {
          this.recievedFriendRequests = response.data
        }).catch(error => {
          alert('Something wrong happened!')
          console.log(error)
        })
      },
      fetchSentRequests () {
        this.$http.get('friend_requests/sent').then(response => {
          this.sentFriendRequests = response.data
        }).catch(error => {
          alert('Something wrong happened!')
          console.log(error)
        })
      }
    },
    created () {
      this.fetchRecievedRequests()
      this.fetchSentRequests()
    },
    mounted () {
      $('#requests-tab .item').tab()
    }
  }
</script>

<style scoped>

</style>
