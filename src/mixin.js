export default {
  data () {
    return {
      API_END_POINT: process.env.API_END_POINT
    }
  },
  methods: {
    getImageFromUser (user) {
      if (user.profile_picture && user.profile_picture !== '/profile_pictures/medium/missing.png') {
        return `${this.API_END_POINT}/${user.profile_picture}`
      } else if (user.profile_picture_file_name &&
        user.profile_picture_file_name !== '/profile_pictures/medium/missing.png') {
        return `${this.API_END_POINT}/${user.profile_picture_file_name}`
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
    goToProfile (userId) {
      this.$router.push({ name: 'profile', params: { id: userId } })
    }
  }
}
