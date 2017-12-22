<template>
  <div>
    <div class="ui segment">
      <div id="profile-picture-container">
        <div class="upper-half">
          <div class="image-container">
            <img :src="getImageSrc()">
            <h1>{{ getNicknameFromUser(user) }}</h1>
          </div>
        </div>
      </div>
    </div>
    <div style="margin-top: 50px" class="ui grid">
      <div class="six wide column">
        <div class="ui segment">
          <h2 style="text-align: center">About</h2>
          <table class="ui very basic collapsing celled table" style="width: 100%">
            <thead>
              <tr>
                <th style="width: 30%"></th>
                <th style="width: 70%"></th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td class="bold">First Name</td>
                <td>{{ user.first_name }}</td>
              </tr>
              <tr>
                <td class="bold">Last Name</td>
                <td>{{ user.last_name }}</td>
              </tr>
              <tr>
                <td class="bold">Nickname</td>
                <td>{{ getNicknameFromUser(user) }}</td>
              </tr>
              <tr>
                <td class="bold">Email</td>
                <td>{{ user.email }}</td>
              </tr>
              <tr>
                <td class="bold">Phone Number(s)</td>
                <td><span v-for="phone in user.phones">{{ phone }}</span></td>
              </tr>
              <tr>
                <td class="bold">Gender</td>
                <td>{{ user.gender }}</td>
              </tr>
              <tr>
                <td class="bold">Hometown</td>
                <td>{{ user.hometown }}</td>
              </tr>
              <tr>
                <td class="bold">Birthdate</td>
                <td>{{ user.birthdate }}</td>
              </tr>
              <tr>
                <td class="bold">Marital Status</td>
                <td>{{ user.marital_status }}</td>
              </tr>
              <tr>
                <td class="bold">About me</td>
                <td>{{ user.about_me }}</td>
              </tr>
            </tbody>
          </table>
          <div class="ui button fluid blue" @click="$router.push({ name: 'profile_edit' })">Edit</div>
        </div>
      </div>
      <div class="one wide column"></div>
      <div class="nine wide column">
        <Posts v-for="post in posts" :key="post.id" :post="post" :user="$auth.user()" :canRemove="true" @showRemoveModal="showRemoveModal" />
      </div>
    </div>
    <div class="ui basic modal" id="remove-post-modal">
      <div class="ui icon header">
        <i class="archive icon"></i>
        Delete Post
      </div>
      <div class="content">
        <p>Are you sure you want to delete this post?</p>
      </div>
      <div class="actions">
        <div class="ui red basic cancel inverted button">
          <i class="remove icon"></i>
          No
        </div>
        <div class="ui green ok inverted button" @click="removePost(toBeRemovedId)">
          <i class="checkmark icon"></i>
          Yes
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    components: {
      Posts: require('@/components/profile/Post').default
    },
    data () {
      return {
        posts: [],
        toBeRemovedId: null
      }
    },
    computed: {
      user () {
        return this.$auth.user()
      }
    },
    methods: {
      getPosts () {
        this.$http.get('profile').then(response => {
          this.posts = response.data
        }).catch(error => {
          console.log(error)
          alert('Something wrong happened !')
        })
      },
      getImageSrc () {
        if (this.user.profile_picture_file_name) {
          return this.user.profile_picture_file_name
        } else if (this.user.gender === 'male') {
          return '/static/male.jpg'
        } else return '/static/female.jpg'
      },
      removePost (id) {
        this.$http.delete(`posts/${id}`).then(() => {
          alert('post deleted successfully')
          this.getPosts()
          $('#remove-post-modal').modal('hide')
        }).catch(error => {
          console.log(error)
          alert('Something wrong happened !')
          $('#remove-post-modal').modal('hide')
        })
      },
      showRemoveModal (id) {
        this.toBeRemovedId = id
        $('#remove-post-modal').modal('show')
      }
    },
    created () {
      this.getPosts()
    }
  }
</script>

<style scoped>
  #profile-picture-container {
    width: 100%;
    height: 400px;
  }
  #profile-picture-container .upper-half {
    width: 100%;
    height: 200px;
    background: url("/static/profile-background.jpg") no-repeat center center;
    background-size: cover;
    position: relative;
  }
  #profile-picture-container .image-container {
    position: absolute;
    left: 50%;
    bottom: 0;
    transform: translate(-50%, 50%);
    text-align: center;
  }
  #profile-picture-container .image-container h1 {
    margin-top: 0;
    text-align: center;
  }
  #profile-picture-container img {
    width: 200px;
    height: 200px;
    border-radius: 50%;
    border: 5px solid #fff;
  }
</style>
