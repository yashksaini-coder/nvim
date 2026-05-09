import { defineConfig } from 'vitepress'

export default defineConfig({
  title: 'yks.nvim',
  description: 'Personal Neovim distribution — IDE-grade for systems languages',
  base: '/nvim/',
  cleanUrls: true,
  lastUpdated: true,
  themeConfig: {
    siteTitle: 'yks.nvim',
    nav: [
      { text: 'Getting Started', link: '/getting-started' },
      { text: 'Keymaps', link: '/keymaps' },
      { text: 'Plugins', link: '/plugins' },
      { text: 'Languages', link: '/languages' },
      { text: 'AI', link: '/ai' },
    ],
    sidebar: [
      {
        text: 'Overview',
        items: [
          { text: 'Home', link: '/' },
          { text: 'Getting Started', link: '/getting-started' },
        ],
      },
      {
        text: 'Reference',
        items: [
          { text: 'Keymaps', link: '/keymaps' },
          { text: 'Plugins', link: '/plugins' },
          { text: 'Language support', link: '/languages' },
          { text: 'AI assistants', link: '/ai' },
        ],
      },
    ],
    socialLinks: [
      { icon: 'github', link: 'https://github.com/yashksaini-coder/nvim' },
    ],
    search: { provider: 'local' },
    editLink: {
      pattern: 'https://github.com/yashksaini-coder/nvim/edit/dev/docs-site/:path',
    },
    outline: { level: [2, 3] },
  },
})
