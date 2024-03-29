const path = require('path')

module.exports = function (context) {
  return {
    name: 'docusaurus-plugin-ory-web-script',

    // https://docusaurus.io/docs/api/plugin-methods/lifecycle-apis#injectHtmlTags
    injectHtmlTags({ content }) {
      if (process.env.NODE_ENV !== 'production') return {}

      return {
        postBodyTags: [
          '<script src="https://www.ory.sh/scripts.js" async></script>'
        ]
      }
    }
  }
}
