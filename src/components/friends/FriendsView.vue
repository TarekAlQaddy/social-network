<template>
  <div class="ui container">
    <h2 class="ui center aligned icon header">
      <i class="circular users icon"></i>
      Your Friends
    </h2>
    <div class="row">
      <div class="column">
        <friend-card />
      </div>
      <div class="column">
        <friend-card />
      </div>
      <div class="column">
        <friend-card />
      </div>
      <div class="column">
        <friend-card />
      </div>
    </div>
  </div>
</template>

<script>
import FriendCard from './FriendCard'

export default {
  components: {
    'friend-card': FriendCard
  }
}
</script>

<style>

</style>
