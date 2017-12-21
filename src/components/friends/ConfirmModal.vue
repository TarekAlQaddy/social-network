<template>
  <div class="ui basic modal" id="remove-modal">
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
      <div @click='confirmed' class="ui red ok inverted button">
        <i class="checkmark icon"></i>
        Yes
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ['user'],
  methods: {
    confirmed: function () {
      this.$emit('confirmDelete')
    }
  }
}
</script>

<style scoped>

</style>
