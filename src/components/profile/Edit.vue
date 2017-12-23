<template>
  <div class="ui grid" style="padding-top: 30px">
    <div class="ui two wide column"></div>
    <div class="ui segment twelve wide column">
      <h2 style="text-align: center">Edit Profile</h2>
      <div id="edit-form" class="ui form">
        <div class="profile-picture">
          <div id="profile-picture-dimmer" class="ui dimmer">
            <div class="ui loader" :class="{ 'active': loadingFile, 'disabled': !loadingFile }"></div>
            <div class="content">
              <div class="center">
                <input id="profile-picture-input" @change="fileChange($event)" type="file" accept="image/*">
                <div class="ui inverted orange icon button" @click="clickFile()">
                  <i class="icon upload"></i></div>
              </div>
            </div>
          </div>
          <img class="ui medium circular image" :src="getImageFromUser($auth.user())">
        </div>
        <div class="two fields">
          <div class="field">
            <label for="user-first-name">First Name</label>
            <input id="user-first-name" name="user-first-name" v-model="user.first_name" type="text">
          </div>
          <div class="field">
            <label for="user-last-name">Last Name</label>
            <input id="user-last-name" name="user-last-name" v-model="user.last_name" type="text">
          </div>
        </div>
        <div class="field">
          <label for="user-nickname">Nickname</label>
          <input id="user-nickname" name="user-nickname" v-model="user.nickname" type="text">
        </div>
        <div class="field">
          <label for="user-email">Email</label>
          <input id="user-email" name="user-email" v-model="user.email" type="email">
        </div>
        <div class="field">
          <label>Phone Number(s)</label>
          <select class="ui search select"  multiple id="user-phones" name="user-phones" v-model="phones">
            <option v-for="phone in user.phones" :value="phone">{{ phone }}</option>
          </select>
        </div>
        <div class="inline fields">
          <label>Gender</label>
          <div class="field">
            <label for="gender-male">Male</label>
            <input type="radio" id="gender-male" v-model="user.gender" value="male">
          </div>
          <div class="field">
            <label for="gender-female">Female</label>
            <input type="radio" id="gender-female" v-model="user.gender" value="female">
          </div>
        </div>
        <div class="field">
          <label for="user-birthdate">Birthdate</label>
          <input type="date" id="user-birthdate" name="user-birthdate"  v-model="user.birthdate">
        </div>
        <div class="field">
          <label for="user-marital-status">Marital Status</label>
          <input id="user-marital-status" name="user-marital-status" v-model="user.marital_status" type="text">
        </div>
        <div class="field">
          <label for="user-about">About</label>
          <textarea id="user-about" name="user-about" v-model="user.about_me"></textarea>
        </div>
      </div>
      <div style="text-align: right; margin-top: 20px">
        <div class="ui button icon black" style="float: left" @click="$router.push({ name: 'profile' })">
          <i class="arrow left icon"></i>
          Back
        </div>
        <div class="ui button blue" @click="editUser">
          Confirm
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    watch: {
      user: {
        handler: function () {
          this.validEditForm = $('#user-phones').form('is valid')
        },
        deep: true
      }
    },
    data () {
      return {
        user: null,
        phones: [],
        validEditForm: false,
        file: null,
        file64: null,
        fileReader: null,
        loadingFile: false
      }
    },
    methods: {
      editUser () {
        // TODO send proper edit request
      },
      clickFile () {
        $('#profile-picture-input').click()
      },
      fileChange (event) {
        this.file = event.target.files[0]
        if (this.file) {
          this.loadingFile = true
          this.fileReader.readAsDataURL(this.file)
        }
      },
      initFileReader () {
        this.fileReader = new FileReader()
        this.fileReader.addEventListener('load', () => {
          this.file64 = this.fileReader.result
          this.sendProfilePicture()
        })
      },
      sendProfilePicture () {
        let postData = {
          image: {
            data: this.file64,
            file_name: this.file.name
          }
        }
        this.$http.post('user/image', postData).then(response => {
          this.loadingFile = false
          console.log(response)
          // TODO: set image in user
        })
      }
    },
    created () {
      // clone the user
      this.user = $.extend(true, {}, this.$auth.user())
      this.initFileReader()
    },
    mounted () {
      $('#edit-form').form({
        fields: {
          'user-email': 'email',
          'user-first-name': 'empty',
          'user-last-name': 'empty',
          'user-birthdate': 'empty'
        },
        inline: true
      })
      $('#user-phones').dropdown({
        allowAdditions: true
      })
      $('#profile-picture-dimmer').dimmer({
        on: 'hover'
      })
    }
  }
</script>

<style scoped>
  #edit-form .profile-picture {
    display: block;
    width: 200px;
    margin: 30px auto;
  }
  #profile-picture-dimmer {
    border-radius: 50%;
  }
  #profile-picture-input {
    opacity: 0;
    pointer-events: none;
  }
</style>
