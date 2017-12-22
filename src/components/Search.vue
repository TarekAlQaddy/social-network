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
              <option value="email">Email</option>
            </select>
          </div>
        </div>
        <div style="text-align: right">
          <div @click="getSearchResults" class="ui button green inverted" :class="{ 'disabled': search.text.length === 0 }">Search</div>
        </div>
      </div>
    </div>
    <div class="ui segment">
      <h2>Search Results</h2>
      <div class="ui four cards">
        <FriendCard v-for='(friend, index) in searchResults'
                    :key='friend.id' :user='friend' :showUnfriend="false"/>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    components: {
      FriendCard: require('@/components/friends/FriendCard').default
    },
    data () {
      return {
        search: {
          text: '',
          type: 'email'
        },
        searchResults: []
      }
    },
    methods: {
      getSearchResults () {
        // TODO: send search request
      }
    },
    mounted () {
      $('#search-type').dropdown()
      // TODO remove below
      this.$http.get('friendships').then(response => {
        this.searchResults = response.data
      })
    }
  }
</script>

<style scoped>

</style>
