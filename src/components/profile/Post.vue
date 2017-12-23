<template>
  <div>
    <div class="ui fluid card" v-if="user">
      <div class="content">
        <i class="right floated icon" :class="getPostIcon(post)"></i>
        <img class="right floated mini ui image"
             :src="getImageFromUser(user)">
        <div class="header link" style="cursor: pointer"
             @click="goToProfile(user.id)">{{ getNicknameFromUser(user) }}</div>
        <div class="meta">{{ post.created_at | moment('LLL') }}</div>
        <div class="description">
          <div class="image" v-if="hasImage">
            <img style="max-height: 300px" :src="post.photo_url">
          </div>
          {{ post.caption }}
        </div>
      </div>
      <div v-if="canRemove" class="ui bottom attached red button" @click="showRemoveModal(post.id)">
        <i class="remove icon"></i>
        Remove Post
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    props: ['post', 'user', 'canRemove'],
    data () {
      return {
        toBeRemovedId: null
      }
    },
    computed: {
      hasImage () {
        return this.post.photo_url && this.post.photo_url !== '/photos/original/missing.png'
      }
    },
    methods: {
      showRemoveModal (id) {
        this.$emit('showRemoveModal', id)
      }
    }
  }
</script>

<style scoped>
  .fluid.card {
    margin: 15px 0;
  }
</style>
