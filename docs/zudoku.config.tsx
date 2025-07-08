import type { ZudokuConfig } from "zudoku";

const config: ZudokuConfig = {
  site: {
    title: "Modular Flutter",
    showPoweredBy: false,
  },
  syntaxHighlighting: {
    languages: ['dart', 'json', 'yaml', 'markdown'],
  },
  navigation: [
    {
      type: "category",
      label: "Documentation",
      collapsed: true,
      collapsible: true,
      items: [
        {
          type: "category",
          label: "Getting Started",
          icon: "sparkles",
          items: [
            "/introduction",
            "/quick-start",
            "/installation",
          ],
        },
        {
          type: "category",
          label: "Architecture",
          icon: "building",          
          items: [
            "/architecture/overview",
            "/architecture/modular-core",
            "/architecture/modular-flutter",
            "/architecture/viewmodel",
          ],
        },
        {
          type: "category",
          label: "Guides",
          icon: "book-open",
          collapsed: true,
          collapsible: true,
          items: [
            "/guides/creating-modules",
            "/guides/state-management",
            "/guides/dependency-injection",
            "/guides/routing",
            "/guides/testing",
          ],
        },
        {
          type: "category",
          label: "Examples",
          icon: "code",
          items: [
            "/examples/post-module",
            "/examples/authentication",
            // "/examples/configuration",
          ],
        }
      ],
    },
    {
      type: "link",
      to: "https://github.com/chornthorn/modular-flutter",
      label: "GitHub",
      icon: "github",
    },
  ],
  redirects: [{ from: "/", to: "/introduction" }],
  search: {
    type: "pagefind",
    ranking: {
      termFrequency: 1,
      pageLength: 1,
      termSimilarity: 1,
      termSaturation: 1,
    },
    maxResults: 10,
    maxSubResults: 10,
  },
  theme: {
    registryUrl: "https://tweakcn.com/r/themes/cmcgk2f0i000b04lec6mlaz5w",
    fonts: {
      mono: "IBM Plex Mono"
    }
  }
};

export default config;
