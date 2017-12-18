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
      <a class="header">{{ user.nickname }}</a>
    </div>
    <div class="extra content">
      <a>
        <i class="users icon"></i>
        Friends since DATE
      </a>
    </div>
  </div>
    <!-- modal for unfriend confirmation -->
    <!-- <div class="ui basic modal">
      <div class="ui icon header">
        <i class="remove user icon"></i>
        Unfriend {{ user.nickname }}
      </div>
      <div class="ui center aligned content">
        <span class="center aligned">Are you sure you want to unfriend {{ user.nickname }} ?</span>
      </div>
      <div class="actions">
        <div class="ui basic cancel inverted button">
          <i class="remove icon"></i>
          No
        </div>
        <div class="ui red ok inverted button">
          <i class="checkmark icon"></i>
          Yes
        </div>
      </div>
    </div>
  </div> -->
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
  }
}
</script>


<style scoped>
  /* .center {
    text-align: center;
  } */
</style>
