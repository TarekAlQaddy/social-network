<template>
  <div style="padding-top: 60px;" class="ui centered grid">
    <div style="margin-left: 18rem" class="ui top fixed huge inverted menu">
      <div id="popup-activate" class="item">
        Friends Requests
        <a class="ui circular blue label" v-if="friendRequests.length > 0">{{ friendRequests.length }}</a>
      </div>
    </div>


    <div id="friend-requests-popup"
         style="height: 150px; overflow-y: scroll"
         class="ui grid popup top left transition hidden">
      <div class="ui one cards">
        <div class="card" v-for="request in friendRequests">
          <div class="content">
            <img class="right floated mini ui image" :src="getImageFromUser(request.requester)">
            <div class="header">
              {{ getNicknameFromUser(request.requester) }}
            </div>
            <div class="meta">
              {{ request.created_at | moment('LLL') }}
            </div>
          </div>
          <div class="extra content">
            <div class="ui buttons">
              <div class="ui inverted green button" @click="friendRequestAction(request, 'accept')">Approve</div>
              <div style="margin-left: 10px" class="ui inverted red button"
                   @click="friendRequestAction(request, 'reject')">Decline</div>
            </div>
          </div>
        </div>
      </div>
    </div>


    <div class="twelve wide column">
      <div id="new-post" class="ui segment">
        <div class="ui loader" :class="{ 'active': posting }"></div>
        <div>
          <h2 style="float: left">New Post</h2>
          <div style="float: right" id="is-public-dropdown" class="ui floating dropdown teal labeled icon button">
            <i class="icon" :class="getPostIcon(post)"></i>
            <span class="text">{{ post.is_public ? 'Public' : 'Private' }}</span>
            <div class="menu">
              <div class="item">Public</div>
              <div class="item">Private</div>
            </div>
          </div>
        </div>
        <textarea maxlength="200" v-model="post.text" name="new-post-text" id="new-post-text" cols="30" rows="10"></textarea>
        <div class="remaining-chars">{{ remainingChars }}/200</div>
        <div style="text-align: right">
          <div class="image-upload">
            <input id="file-input" @change="fileChange($event)" type="file" accept="image/*">
            <span @click="getImage()">{{ fileName }}</span>
            <div class="ui loader" :class="{ 'active': loadingFile }"></div>
            <i @click="getImage()" style="color: #aaa" class="file image outline icon"></i>
          </div>
          <div
            class="ui button inverted blue"
            :class="{ 'disabled': post.text.length === 0 && !file }"
            @click="sendPost()">
            Post
          </div>
        </div>
      </div>
      <Post v-for="post in posts" :key="post.id" :post="post" :user="post.user" :canRemove="false"/>
    </div>
  </div>
</template>

<script>
  export default {
    components: {
      Post: require('@/components/profile/Post').default
    },
    data () {
      return {
        post: {
          text: '',
          is_public: true
        },
        posts: [],
        file: null,
        file64: null,
        loadingFile: false,
        fileReader: null,
        posting: false,
        friendRequests: []
      }
    },
    methods: {
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
          this.loadingFile = false
        })
      },
      getImage () {
        document.getElementById('file-input').click()
      },
      fetchPosts () {
        this.$http.get('posts').then(response => {
          this.posts = response.data
        })
      },
      fetchFriendRequests () {
        this.$http.get('friend_requests').then(response => {
          this.friendRequests = response.data
        })
      },
      sendPost () {
        let postData = {
          post: {
            caption: this.post.text,
            is_public: this.post.is_public,
            file: this.file,
            photo: {
              data: this.file64,
              file_name: this.file.name
            }
          }
        }
        this.$http.post('posts', postData).then(() => {
          this.fetchPosts()
        }).catch(error => {
          console.log(error)
        })
      },
      friendRequestAction (request, action) {
        let self = this
        this.$http.post(`friend_requests/${action}/${request.id}`).then(response => {
          self.fetchFriendRequests()
        }).catch(error => {
          console.log(error)
        })
      }
    },
    computed: {
      remainingChars () {
        return 200 - this.post.text.length
      },
      fileName () {
        return this.file ? this.file.name : ''
      }
    },
    created () {
      this.initFileReader()
      this.fetchPosts()
      this.fetchFriendRequests()
    },
    mounted () {
      let self = this
      $('#is-public-dropdown').dropdown({
        onChange (value) {
          if (value === 'public') {
            self.post.is_public = true
          } else if (value === 'private') {
            self.post.is_public = false
          }
        }
      })
      $('#popup-activate').popup({
        popup: $('#friend-requests-popup'),
        // position: 'top left',
        // context: $('#container'),
        // boundary: $('#container'),
        // movePopup: false,
        // onShow: function () {
        //   if (self.friendRequests.length === 0) {
        //     return false
        //   } else {
        //     return true
        //   }
        // },
        hoverable: true
      })
    }
  }
</script>

<style scoped>
  #new-post-text {
    width: 100%;
    resize: none;
  }
  #new-post .remaining-chars {
    color: #aaa
  }
  #new-post .image-upload {
    display: inline-block;
    margin-right: 20px;
    position: relative;
  }
  #new-post .image-upload input {
    opacity: 0;
    pointer-events: none;
  }
  #new-post .image-upload span, #new-post .image-upload i {
    cursor: pointer;
  }
</style>
