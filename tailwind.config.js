module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/components/**/*.{rb,html.erb}',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      colors: {
        /* Purple */
        'primary-50': '#eef2ff',
        'primary-100': '#e0e7ff',
        'primary-200': '#c7d2fe',
        'primary-300': '#a5b4fc',
        'primary-400': '#818cf8',
        'primary-500': '#6366f1',
        'primary-600': '#4f46e5',
        'primary-700': '#4338ca',
        'primary-800': '#3730a3',
        'primary-900': '#312e81',
      }
    }
  },
  safelist: [],
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    // require('@tailwindcss/aspect-ratio'),
    require('prettier-plugin-tailwindcss')
  ]
}
