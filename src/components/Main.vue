<template>
  <div>
    <!-- <div class="ui visible vertical large inverted menu sidebar">
      <a class="item">
        Item 1
      </a>
      <a class="item">
        Item 2
      </a>
      <a class="item">
        Item 3
      </a>
    </div> -->
    <div class="pusher">
      Your site's actual content
    </div>
    <div class="ui container">
      <friend-card></friend-card>
    </div>
  </div>
</template>

<script>
  import FriendCardComponent from '@/components/friends/FriendCard'
  export default {
    data () {
      return {}
    },
    components: {
      'friend-card': FriendCardComponent
    }
  }
</script>

<style scoped>

</style>
