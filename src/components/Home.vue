<template>
  <div>
    <div class="ui fluid card">
      <div class="content">
        <div class="header">Elliot Fu</div>
        <div class="meta">Friend</div>
        <div class="description">
          <div class="image">
            <img style="height: 150px" src="static/js.svg" alt="">
          </div>
          {{ $auth.user() }}
          Elliot Fu is a film-maker from New York.
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'home',
    mounted () {
      // console.log(this.$auth.user())
    }
  }
</script>

<style scoped>

</style>
