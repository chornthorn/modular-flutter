import type { ZudokuConfig } from "zudoku";
import PreviewBanner from "./src/PreviewBanner";

const config: ZudokuConfig = {
  // basePath: "/modular-flutter",
  canonicalUrlOrigin: "https://chornthorn.github.io/modular-flutter",
  site: {
    title: "Modular Flutter",
    showPoweredBy: false,
    banner: {
      message: <PreviewBanner />,
      dismissible: true,
    },
    footer: {
      social: [
        { icon: "github", href: "https://github.com/chornthorn/modular-flutter" },
      ],
      copyright: `© ${new Date().getFullYear()} Modular Flutter. All rights reserved.`,
    }
  },
  syntaxHighlighting: {
    languages: ['dart', 'json', 'yaml', 'markdown', 'typescript'],
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
  },
};

export default config;
