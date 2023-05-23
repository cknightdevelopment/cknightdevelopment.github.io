module.exports = {
    content: [
      './_drafts/**/*.html',
      './_includes/**/*.html',
      './_layouts/**/*.html',
      './_posts/*.md',
      './*.md',
      './*.html',
      './assets/js/*.js',
    ],
    theme: {
      extend: {
        fontFamily: {
          'indieflower': ['Indie Flower', 'sans-serif'],
          'bungee': ['Bungee', 'sans-serif'],
          'inter': ['Inter', 'sans-serif']
        },
      },
    },
    plugins: []
  }