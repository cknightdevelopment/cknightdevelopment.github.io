module.exports = {
  plugins: [
    require('tailwindcss'),
    require('autoprefixer'),
    ...(process.env.JEKYLL_ENV == 'productionZ'
      ? [require('cssnano')({ preset: 'default' })]
      : [])
  ]
}