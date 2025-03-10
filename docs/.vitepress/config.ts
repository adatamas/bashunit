import { defineConfig } from 'vitepress'
import pkg from '../../package.json'

// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: 'bashunit - A simple testing library for bash scripts',
  titleTemplate: 'bashunit',
  description: 'Test your bash scripts in the fastest and simplest way, discover the most modern bash testing library.',
  lang: 'en-US',
  cleanUrls: true,
  lastUpdated: true,

  head: [
    ['link', { rel: 'icon', href: '/favicon.ico' }]
  ],

  sitemap: {
    hostname: 'https://bashunit.typeddevs.com'
  },

  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    externalLinkIcon: true,
    siteTitle: false,

    editLink: {
      pattern: 'https://github.com/TypedDevs/bashunit/edit/main/docs/:path'
    },

    logo: {
      light: '/logo_navbar.svg',
      dark: '/logo_navbar_dark.svg',
      alt: 'bashunit'
    },

    sidebar: {
      '/': [{
        text: 'Quickstart',
        link: '/quickstart',
      }, {
        text: 'Installation',
        link: '/installation',
      }, {
        text: 'Command line',
        link: '/command-line'
      }, {
        text: 'Configuration',
        link: '/configuration'
      }, {
        text: 'Test files',
        link: '/test-files',
      }, {
        text: 'Test doubles',
        link: '/test-doubles'
      }, {
        text: 'Assertions',
        link: '/assertions'
      }, {
        text: 'Snapshots',
        link: '/snapshots'
      }, {
        text: 'Skipping/incomplete',
        link: '/skipping-incomplete'
      }, {
        text: 'Examples',
        link: '/examples'
      }, {
        text: 'Support',
        link: '/support',
      }],
      '/blog/': []
    },

    socialLinks: [
      { icon: 'x', link: 'https://x.com/bashunit' },
      { icon: 'github', link: 'https://github.com/TypedDevs/bashunit' }
    ],

    nav: [{
      text: 'Docs',
      link: '/quickstart',
      activeMatch: '^/(?!blog)[^/]'
    }, {
      text: 'Blog',
      link: '/blog/',
      activeMatch: '^/blog/'
    }, {
      text: pkg.version,
      items: [
        {
          text: 'Changelog',
          link: 'https://github.com/TypedDevs/bashunit/blob/main/CHANGELOG.md'
        },
        {
          text: 'Contributing',
          link: 'https://github.com/TypedDevs/bashunit/blob/main/.github/CONTRIBUTING.md'
        }
      ]
    }],

    search: {
      provider: 'local'
    },

    footer: {
      message: 'Released under the MIT License.',
      copyright: 'Copyright © 2023-present TypedDevs'
    }
  },

  srcExclude: [
    'blog/0000-00-00-template.md'
  ]
})
