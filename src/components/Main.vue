<template>
  <div>
    <div id="main-sidebar" class="ui visible labeled icon vertical large inverted menu sidebar">
      <div id="user-image-container" :style="{'background-image': `url(${getImageFromUser($auth.user())})`}">
      </div>
      <router-link :to="{ name: 'home' }">
        <a class="item">
          <i class="home icon"></i>
          Home
        </a>
      </router-link>
      <router-link :to="{ name: 'profile', params: { id: $auth.user().id } }">
        <a class="item">
          <i class="user icon"></i>
          Profile
        </a>
      </router-link>
      <router-link :to="{ name: 'friend_requests' }">
        <a class="item">
          <i class="users icon"></i>
          Friend Requests
        </a>
      </router-link>
      <router-link :to="{ name: 'view_friends' }">
        <a class="item">
          <i class="users icon"></i>
          Friends
        </a>
      </router-link>
      <router-link :to="{ name: 'search' }">
        <a class="item">
          <i class="search icon"></i>
          Search
        </a>
      </router-link>
      <a class="item" @click="$auth.logout()">
        <i class="sign out icon"></i>
        Logout
      </a>
    </div>
    <!--<div style="margin-left: 18rem" class="ui top fixed huge inverted menu">-->
      <!--<div class="item">-->
        <!--Home-->
      <!--</div>-->
    <!--</div>-->
    <div style="margin-left: 18rem">
      <div class="ui container" id="container">
        <router-view/>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    data () {
      return {}
    },
    mounted () {
    }
  }
</script>

<style scoped>
  #user-image-container {
    margin: 35% auto 50px auto;
    width: 15rem;
    height: 15rem;
    border-radius: 50%;
    display: block;
    background: no-repeat center center;
    background-size: cover;
  }
</style>
