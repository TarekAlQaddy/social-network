<template>
  <div class="ui card">
    <div class="blurring dimmable image">
      <div class="ui dimmer">
        <div class="content">
          <div class="container">
            <div class="ui inverted button">Profile</div>
            <div class="ui horizontal inverted divider"></div>
            <button v-on:click='unfriendClicked' class="ui red ok inverted button">Unfriend</button>
          </div>
        </div>
      </div>
      <img src="../../assets/F-go7vvI.jpeg">
    </div>
    <div class="content">
      <a class="header">{{ nickname }}</a>
    </div>
    <div class="extra content">
      <a>
        <i class="users icon"></i>
        Friends
      </a>
    </div>
  </div>
</template>

<script>
export default {
  props: ['user'],
  data () {
    return {

    }
  },
  methods: {
    unfriendClicked: function () {
      this.$emit('removeRequest')
    }
  },
  mounted: function () {
    $('.card .image').dimmer({
      on: 'hover'
    })
  },
  computed: {
    nickname: function () {
      return this.user.nickname || `${this.user.firstName} ${this.user.lastName}`
    }
  }
}
</script>


<style scoped>
  /* .center {
    text-align: center;
  } */
</style>
