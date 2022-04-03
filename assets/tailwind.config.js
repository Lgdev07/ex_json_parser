// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration
module.exports = {
  content: [
    './js/**/*.js',
    '../lib/*_web.ex',
    '../lib/*_web/**/*.*ex'
  ],
  theme: {
    extend: {
      animation: {
        fade: 'fadein 1s ease-in-out',
      },
      keyframes: () => ({
        fadein: {
          '0%': { opacity: 0 },
          '100%': { opacity: 1 },
        },
      }),
    },
    fontFamily: {
      'calamity-bold': ['Calamity-Bold', 'sans-serif', 'system-ui'],
    }
  },
  plugins: [
    require('@tailwindcss/forms')
  ]
}
