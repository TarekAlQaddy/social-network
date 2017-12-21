<template>
  <div style="padding-top: 30px;">
    <div id="new-post" class="ui segment">
      <div class="ui loader" :class="{ 'active': posting }"></div>
      <h2>New Post</h2>
      <textarea v-model="post.text" name="new-post-text" id="new-post-text" cols="30" rows="10"></textarea>
      <div class="remaining-chars">{{ remainingChars }}/200</div>
      <div style="text-align: right">
        <div class="image-upload">
          <span>{{ fileName }}</span>
          <input @change="fileChange($event)" type="file" accept="image/*">
          <div class="ui loader" :class="{ 'active': loadingFile }"></div>
          <i style="color: #aaa" class="file image outline icon"></i>
        </div>
        <div class="ui button inverted blue" :class="{ 'disabled': post.text.length === 0 }">Post</div>
      </div>
    </div>
    <div class="ui fluid card" v-for="post in posts">
      <div class="content">
        <div class="header">{{ post.id }}</div>
        <div class="meta">{{ post.created_at | moment('LLL') }}</div>
        <div class="description">
          <div class="image" v-if="post.photo_file_name">
            <img style="max-height: 300px" :src="post.photo_file_name">
          </div>
          {{ post.caption }}
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'home',
    watch: {
      'post.text': {
        handler: function (to) {
          if (to.length > 200) {
            this.post.text = this.post.text.slice(0, 200)
          }
        }
      }
    },
    data () {
      return {
        post: {
          text: ''
        },
        posts: [{
          id: 5,
          created_at: new Date(),
          caption: 'Hello thereee !!'
        }],
        file: null,
        loadingFile: false,
        fileReader: null,
        posting: false
      }
    },
    methods: {
      fileChange (event) {
        this.file = event.target.files[0]
        if (this.file) {
          this.fileReader.readAsDataURL(this.file)
          this.loadingFile = true
        }
      },
      initFileReader () {
        this.fileReader = new FileReader()
        this.fileReader.addEventListener('load', () => {
          this.loadingFile = false
          console.log(this.fileReader.result)
        })
      },
      fetchPosts () {
        this.$http.get('posts').then(response => {
          this.posts = response.data
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
    cursor: pointer;
    position: relative;
  }
  #new-post .image-upload input {
    position: absolute;
    top: 0;
    left: 0;
    bottom: 0;
    right: 0;
    opacity: 0;
    width: 100%;
  }
</style>
