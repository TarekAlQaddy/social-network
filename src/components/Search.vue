<template>
  <div style="padding-top: 30px">
    <div class="ui segment">
      <div class="ui form">
        <h2>Search</h2>
        <div class="two fields">
          <div class="eight wide field">
            <div class="ui input">
              <label for="search-text"></label>
              <input type="text" name="search-text" id="search-text" v-model="search.text">
            </div>
          </div>
          <div class="eight wide field">
            <select name="search-type" id="search-type" class="ui dropdown" v-model="search.type">
              <option value="email">Email</option>
              <option value="name">First, Last name</option>
              <option value="hometown">Hometown</option>
              <option value="caption">Caption</option>
            </select>
          </div>
        </div>
        <div style="text-align: right">
          <div @click="getSearchResults" class="ui button green inverted"
               :class="{ 'disabled': search.text.length === 0 }">Search</div>
        </div>
      </div>
    </div>
    <div class="ui segment" v-if="searchResults.length > 0">
      <h2>Search Results</h2>
      <div class="ui dimmer" :class="{ 'active': fetchingResults }">
        <div class="ui loader"></div>
      </div>
      <div class="ui four cards">
        <FriendCard v-if="lastSearchType !== 'caption'" v-for='(friend, index) in searchResults'
                    :user='friend' :key="friend.id" :showUnfriend="false"/>
      </div>
      <div>
        <Post v-for="post in searchResults" :post="post" :user="post.user" :key="String(post.id) + post.caption" :canRemove="false" />
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    components: {
      FriendCard: require('@/components/friends/FriendCard').default,
      Post: require('@/components/profile/Post').default
    },
    data () {
      return {
        search: {
          text: '',
          type: 'email'
        },
        searchResults: [],
        lastSearchType: null,
        fetchingResults: false
      }
    },
    methods: {
      getSearchResults () {
        this.fetchingResults = true
        this.lastSearchType = this.search.type
        let postParams = {
          search: {
            type: this.search.type,
            value: this.search.text
          }
        }
        this.$http.post('search', postParams).then(response => {
          this.searchResults = response.data
          this.fetchingResults = false
        }).catch(() => {
          this.fetchingResults = false
          alert('Something wrong happened!')
        })
      }
    },
    mounted () {
      $('#search-type').dropdown()
      // this.$http.get('friendships').then(response => {
      //   this.searchResults = response.data
      // })
    }
  }
</script>

<style scoped>

</style>
