<template>
  <div id="main-container">
    <div class="layout ">
      <transition name="fade">
        <div v-show="currentState === loginState.CHOOSE" class="login-choose">
          <h2 class="white-color">Social Network</h2>
          <h6 class="white-color">Don't Sign up, Facebook is better !</h6>
          <div class="">
            <div class="ui inverted white button" @click="currentState = loginState.LOGIN">Login</div>
            <div class="ui inverted blue button" @click="currentState = loginState.SIGNUP">Sign up</div>
          </div>
        </div>
      </transition>
      <transition name="fade">
        <div v-show="currentState === loginState.LOGIN" class="login-login ui blue segment">
          <h2 style="text-align: center">Login</h2>
          <div id="login-form" class="ui form">
            <div class="field">
              <label for="login-email">Email</label>
              <input id="login-email" name="login-email" v-model="login.email" type="email">
            </div>
            <div class="field">
              <label for="login-password">Password</label>
              <input id="login-password" name="login-password" v-model="login.password" type="password">
            </div>
          </div>
          <div style="margin-top: 25px; text-align: right">
            <div class="ui black button" @click="currentState = loginState.CHOOSE">Cancel</div>
            <div class="ui blue button" :class="{ 'disabled': !validLoginForm }">Login</div>
          </div>
        </div>
      </transition>
      <transition name="fade">
        <div v-show="currentState === loginState.SIGNUP" class="login-login ui blue segment">
          <h2 style="text-align: center">Sign up</h2>
          <div id="signup-form" class="ui form">
            <div class="two fields">
              <div class="field">
                <label for="signup-first-name">First Name</label>
                <input id="signup-first-name" name="signup-first-name" v-model="signup.firstName" type="text">
              </div>
              <div class="field">
                <label for="signup-last-name">Last Name</label>
                <input id="signup-last-name" name="signup-last-name" v-model="signup.lastName" type="text">
              </div>
            </div>
            <div class="field">
              <label for="signup-email">Email</label>
              <input id="signup-email" name="signup-email" v-model="signup.email" type="email">
            </div>
            <div class="field">
              <label for="signup-password">Password</label>
              <input id="signup-password" name="signup-email" v-model="signup.password" type="password">
            </div>
            <div class="inline fields">
              <label>Gender</label>
              <div class="field">
                <label for="gender-male">Male</label>
                <input type="radio" id="gender-male" v-model="signup.gender" value="male">
              </div>
              <div class="field">
                <label for="gender-female">Female</label>
                <input type="radio" id="gender-female" v-model="signup.gender" value="female">
              </div>
            </div>
            <div class="field">
              <label for="signup-birthdate">Birthdate</label>
              <input type="date" id="signup-birthdate" name="signup-birthdate"  v-model="signup.birthdate">
            </div>
          </div>
          <div style="margin-top: 25px; text-align: right">
            <div class="ui black button" @click="currentState = loginState.CHOOSE">Cancel</div>
            <div class="ui green button" :class="{ 'disabled': !validLoginForm }">Sign up</div>
          </div>
        </div>
      </transition>
    </div>
  </div>
</template>

<script>
  export default {
    watch: {
      login: {
        handler: function () {
          this.validLoginForm = $('#login-form').form('is valid')
        },
        deep: true
      },
      signup: {
        handler: function () {
          this.validLoginForm = $('#signup-form').form('is valid')
        },
        deep: true
      }
    },
    data () {
      return {
        loginState: {
          CHOOSE: 0,
          LOGIN: 1,
          SIGNUP: 2
        },
        login: {
          email: null,
          password: null
        },
        signup: {
          firstName: null,
          lastName: null,
          gender: 'male',
          birthdate: null,
          email: null,
          password: null
        },
        currentState: 0,
        validLoginForm: false
      }
    },
    mounted () {
      $('#login-form').form({
        fields: {
          'login-email': 'email',
          'login-password': 'minLength[8]'
        },
        inline: true
      })
      $('#signup-form').form({
        fields: {
          'signup-email': 'email',
          'signup-password': 'minLength[8]',
          'signup-first-name': 'empty',
          'signup-last-name': 'empty',
          'signup-birthdate': 'empty'
        },
        inline: true
      })
    }
  }
</script>

<style scoped>
  .fade-enter-active, .fade-leave-active {
    transition: opacity .5s
  }
  .fade-enter, .fade-leave-to /* .fade-leave-active below version 2.1.8 */ {
    opacity: 0
  }
  #main-container {
    width: 100%;
    height: 100vh;
    background: url("/static/login-background.jpg") no-repeat center center;
    background-size: cover;
    position: relative;
  }
  #main-container .layout {
    position: absolute;
    top: 0;
    left: 0;
    bottom: 0;
    right: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
  }
  #main-container .login-choose,  #main-container .login-login {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
  }
  #main-container .login-choose {
    text-align: center;
  }
  #main-container .login-login {
    width: 450px;
  }
  #main-container .login-choose h2 {
    font-size: 5rem;
  }
  #main-container .login-choose h6 {
    font-size: 1.4rem;
    margin: 20px auto;
  }
</style>
