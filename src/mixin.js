export default {
  methods: {
    getImageFromUser (user) {
      if (user.profile_picture) {
        return this.$http.options.root + user.profile_picture
      } else if (user.gender === 'male') {
        return '/static/male.jpg'
      } else {
        return '/static/female.jpg'
      }
    },
    getNicknameFromUser (user) {
      return user.nickname || `${user.first_name} ${user.last_name}`
    },
    getPostIcon (post) {
      if (post.is_public) {
        return 'world'
      } else if (!post.is_public) {
        return 'users'
      }
    },
    goToProfile (user) {
      if (user.id === this.$auth.user().id) {
        this.$router.push({ name: 'my_profile' })
      } else {
        this.$router.push({ name: 'my_profile', params: { id: user.id } })
      }
    }
  }
}
