---
total: 103
---

# Docs Index

## 0.nuxt/head/guides/0.get-started (2)

- [Installation](./0.nuxt/head/guides/0.get-started/1.installation.md): Quick Start: Unhead is built into Nuxt 3 - just use useHead(), useSeoMeta(), or useScript() directly in your components. No installation needed!
- [Upgrade Guide](./0.nuxt/head/guides/0.get-started/1.migration.md): As of Nuxt 3.16, Unhead v2 is the default version for Nuxt.

## 0.nuxt/head/guides/1.core-concepts (2)

- [Context & Reactivity](./0.nuxt/head/guides/1.core-concepts/0.reactivity.md): Quick Answer: In Nuxt, pass refs and computed values directly to useHead() or useSeoMeta(). Reactivity is automatic. Use injectHead() when you need...
- [Components](./0.nuxt/head/guides/1.core-concepts/1.components.md): Quick Answer: Nuxt includes built-in <Head>, <Title>, , <Link>, and  components. No imports needed - just use them in your templates.

## 0.nuxt/schema-org/guides/0.get-started (1)

- [Installation](./0.nuxt/schema-org/guides/0.get-started/0.installation.md): To use Unhead Schema.org with Nuxt, you need to install the Nuxt Schema.org module.

## 0.nuxt/schema-org/guides/1.core-concepts (1)

- [Vue Components](./0.nuxt/schema-org/guides/1.core-concepts/5.vue-components.md):  Using the components API is no longer recommended. You should use the composables for better developer experience.

## 0.typescript/head/guides/0.get-started (2)

- [Installation](./0.typescript/head/guides/0.get-started/1.installation.md): Unhead is built for JavaScript applications that need to manage the head of their document in both server and client-rendered environments.
- [Upgrade Guide](./0.typescript/head/guides/0.get-started/1.migration.md): With the release of Unhead v2, we now have first-class support for other frameworks. However, this guide will focus on
the changes that affec TypeS...

## 0.typescript/head/guides/1.core-concepts (1)

- [Wrapping Composables](./0.typescript/head/guides/1.core-concepts/0.wrapping-composables.md): Quick Answer: Create custom composables by wrapping useHead() with your own defaults. Pass the head instance to reuse across your application.

## 0.typescript/schema-org/guides/get-started (1)

- [Installation](./0.typescript/schema-org/guides/get-started/0.installation.md): ::UButton{to="https://stackblitz.com/edit/vitejs-vite-xbb1fa" target="blank" style="margin-right: 10px;"}
Vite SPA
::

## 0.vue/head/guides/0.get-started (2)

- [Installation](./0.vue/head/guides/0.get-started/1.installation.md): Quick Start: Install @unhead/vue, create head with createHead(), and use app.use(head). For SSR, use separate client/server entry points with trans...
- [Upgrade Guide](./0.vue/head/guides/0.get-started/1.migration.md): While Unhead has always been framework-agnostic, the most adoption was by the Vue ecosystem.

## 0.vue/head/guides/1.core-concepts (4)

- [Context & Reactivity](./0.vue/head/guides/1.core-concepts/0.reactivity-and-context.md): Quick Answer: In Vue, pass refs and computed values directly to useHead(). Changes are tracked automatically. Use injectHead() in composables outsi...
- [<Head> Component](./0.vue/head/guides/1.core-concepts/1.components.md): Quick Answer: Use <Head>, <Title>, , <Link>, and  components for template-based head management. Import from @unhead/vue/components.
- [Options API](./0.vue/head/guides/1.core-concepts/3.options-api.md): Quick Answer: Use the head() option in Vue components to define head tags. It receives the component instance as this, allowing access to data and ...
- [Pause DOM Rendering](./0.vue/head/guides/1.core-concepts/4.pausing-dom-rendering.md): Pausing the DOM rendering is useful for when you want to ensure your page is fully loaded before updating tags.

## 0.vue/schema-org/guides/0.get-started (1)

- [Installation](./0.vue/schema-org/guides/0.get-started/0.installation.md): Using :Icon{name="logos:nuxt-icon"} Nuxt? Check out nuxt-schema-org.

## 0.vue/schema-org/guides/1.core-concepts (1)

- [Vue Components](./0.vue/schema-org/guides/1.core-concepts/5.vue-components.md):  Using the components API is no longer recommended. You should use the composables for better developer experience.

## head/1.guides/0.get-started (3)

- [Overview](./head/1.guides/0.get-started/0.overview.md): What is Unhead? A framework-agnostic library for managing your HTML <head> - titles, meta tags, scripts, and more. Works with Vue, React, Svelte, S...
- [Introduction to Unhead](./head/1.guides/0.get-started/2.intro-to-unhead.md): Adding tags in your <head>{lang="html"} is one of the fundamental tasks in web development. Whether it be setting a page title using <title>{lang="...
- [Starter Recipes](./head/1.guides/0.get-started/4.starter-recipes.md): Quick Answer: Copy-paste these common head management patterns: basic SEO setup, social sharing meta, favicon configuration, and third-party script...

## head/1.guides/1.core-concepts (7)

- [Titles & Title Templates](./head/1.guides/1.core-concepts/1.titles.md): Page titles are crucial for SEO. They're your primary call-to-action in search results and help users understand your page's content and context.
- [Tag Sorting & Placement](./head/1.guides/1.core-concepts/2.positions.md): Quick Answer: Use tagPosition: 'head' | 'bodyOpen' | 'bodyClose' to control where tags render. Use tagPriority: 'critical' | 'high' | number | 'low...
- [Class & Style Attributes](./head/1.guides/1.core-concepts/3.class-attr.md): Quick Answer: Use htmlAttrs and bodyAttrs to set attributes on <html> and <body>. Classes can be strings, arrays, or objects. Example: htmlAttrs: {...
- [Inline Style & Scripts](./head/1.guides/1.core-concepts/4.inner-content.md): Quick Answer: Use textContent for inline scripts and styles, innerHTML only when you need HTML entities. Example: script: [{ textContent: 'console....
- [Tag Deduplication](./head/1.guides/1.core-concepts/6.handling-duplicates.md): Quick Answer: Unhead automatically deduplicates tags by key attribute. Meta tags dedupe by name or property. Use unique key values when you need mu...
- [Handling DOM Events](./head/1.guides/1.core-concepts/8.dom-event-handling.md): Quick Answer: Use onload and onerror attributes in your useHead() script tags. For advanced event handling, use useScript() with onLoaded() and onE...
- [Script Loading](./head/1.guides/1.core-concepts/9.loading-scripts.md): The useScript composable provides a powerful way to load and manage external scripts in your application. Built on top of useHead(){lang="ts"}, it ...

## head/1.guides/2.advanced (3)

- [Extending Unhead](./head/1.guides/2.advanced/11.extending-unhead.md): Unhead is designed with extensibility in mind, providing lower-level primitives that can be composed to create powerful functionality. This guide e...
- [Bundle Optimizations](./head/1.guides/2.advanced/7.client-only-tags.md): Quick Answer: To reduce bundle size, use import.meta.client to conditionally add tags only on the client. For Vite, use the Unhead Vite plugin to t...
- [Build Optimization Plugins](./head/1.guides/2.advanced/9.vite-plugin.md): Quick Answer: The Unhead Vite plugin enables build-time optimizations like tree-shaking server-only code and transforming useSeoMeta() for smaller ...

## head/1.guides/plugins (4)

- [Template Params Plugin](./head/1.guides/plugins/6.template-params.md): Quick Answer: Template params let you use placeholders like %s and %siteName in your head tags. Configure them with templateParams: { siteName: 'My...
- [Alias Sorting](./head/1.guides/plugins/alias-sorting.md): Quick Answer: The Alias Sorting plugin lets you control head tag order using readable before: and after: prefixes instead of arbitrary numbers. Use...
- [Canonical Plugin](./head/1.guides/plugins/canonical.md): Quick Answer: The Canonical plugin automatically generates <link rel="canonical"> tags and converts relative URLs to absolute URLs in your meta tag...
- [Infer SEO Meta](./head/1.guides/plugins/infer-seo-meta-tags.md): Quick Answer: The Infer SEO Meta plugin automatically generates og:title, og:description, and twitter:card from your existing title and description...

## head/7.api/0.get-started (1)

- [Overview](./head/7.api/0.get-started/overview.md): Quick Reference: The main composables are useHead() for general head management, useSeoMeta() for SEO tags, and useScript() for script loading. All...

## head/7.api/composables (5)

- [useHead()](./head/7.api/composables/0.use-head.md): Quick Start:
- [useHeadSafe()](./head/7.api/composables/1.use-head-safe.md): The useHeadSafe composable is a security-focused wrapper around the useHead composable that restricts input to only allow safe values, providing pr...
- [useSeoMeta()](./head/7.api/composables/3.use-seo-meta.md): The useSeoMeta composable lets you define your site's SEO meta tags as a flat object with full TypeScript support.
- [useScript()](./head/7.api/composables/4.use-script.md): The useScript composable provides an enhanced developer experience for loading third-party scripts with intelligent defaults for performance, secur...
- [useServerHead()](./head/7.api/composables/6.use-server-head.md): ::warning
DEPRECATED: All useServer composables (including useServerHead, useServerSeoMeta, etc.) are deprecated.
Use useHead(){lang="ts"} with imp...

## head/7.api/hooks (15)

- [init](./head/7.api/hooks/01.init.md): The init hook is called when a new Unhead instance is created and initialized. This hook provides a great opportunity to set up any global configur...
- [entries:updated](./head/7.api/hooks/02.entries-updated.md): The entries:updated hook is called whenever the collection of head entries is modified, either by adding new entries, updating existing ones, or re...
- [entries:resolve](./head/7.api/hooks/03.entries-resolve.md): The entries:resolve hook is called when head entries need to be resolved into tags. This hook provides access to both the entries and the tags bein...
- [entries:normalize](./head/7.api/hooks/04.entries-normalize.md): The entries:normalize hook is called for each entry when it's being normalized into tags. This hook gives you access to the tags generated from a s...
- [tag:normalise](./head/7.api/hooks/05.tag-normalise.md): The tag:normalise hook is called for each individual tag during the normalization process. This hook gives you access to a single tag, its parent e...
- [tags:beforeResolve](./head/7.api/hooks/06.tags-before-resolve.md): The tags:beforeResolve hook is called just before the tag resolution process begins. This hook provides access to all tags that have been collected...
- [tags:resolve](./head/7.api/hooks/07.tags-resolve.md): The tags:resolve hook is one of the most important hooks in Unhead, called during the main tag resolution process. This hook provides access to all...
- [tags:afterResolve](./head/7.api/hooks/08.tags-after-resolve.md): The tags:afterResolve hook is called after all tags have been resolved but before they are rendered. This is the final opportunity to modify tags b...
- [dom:beforeRender](./head/7.api/hooks/09.dom-before-render.md): The dom:beforeRender hook is called before tags are rendered to the DOM in client-side environments. This hook allows you to control whether render...
- [dom:renderTag](./head/7.api/hooks/10.dom-render-tag.md): The dom:renderTag hook is called for each individual tag as it's being rendered to the DOM. This hook gives you fine-grained control over how each ...
- [dom:rendered](./head/7.api/hooks/11.dom-rendered.md): The dom:rendered hook is called after all tags have been rendered to the DOM. This hook provides access to the rendered elements and is useful for ...
- [ssr:beforeRender](./head/7.api/hooks/12.ssr-before-render.md): The ssr:beforeRender hook is called before the server-side rendering process begins. This hook allows you to control whether the SSR rendering shou...
- [ssr:render](./head/7.api/hooks/13.ssr-render.md): The ssr:render hook is called during the server-side rendering process after tags have been resolved but before they're converted to HTML strings. ...
- [ssr:rendered](./head/7.api/hooks/14.ssr-rendered.md): The ssr:rendered hook is called after the server-side rendering process has completed and all head tags have been converted to HTML strings. This h...
- [script:updated](./head/7.api/hooks/15.script-updated.md): The script:updated hook is called when a script instance managed by Unhead is updated. This hook is specific to Unhead's script management features...

## schema-org/2.guides/0.get-started (1)

- [Introduction](./schema-org/2.guides/0.get-started/0.overview.md): Unhead Schema.org automatically generates valid JSON-LD structured data for Google Rich Results. Instead of manually writing complex JSON-LD, you u...

## schema-org/2.guides/1.core-concepts (3)

- [Deduping Nodes](./schema-org/2.guides/1.core-concepts/2.deduping-nodes.md): Quick Answer: Schema.org nodes are automatically deduplicated by their @id. Only one node of each type (like WebPage) can exist by default. Later d...
- [Supported Nodes](./schema-org/2.guides/1.core-concepts/2.nodes.md): Quick Answer: Schema.org nodes are created with define functions like defineArticle(), defineProduct(), etc. Each function validates input and outp...
- [Schema.org Params](./schema-org/2.guides/1.core-concepts/3.params.md): Quick Answer: Schema.org params configure site-wide defaults like host, path, currency, and inLanguage. Set them once and they're automatically app...

## schema-org/2.guides/4.recipes (8)

- [Custom Nodes](./schema-org/2.guides/4.recipes/0.custom-nodes.md): Quick Answer: Create custom Schema.org nodes by passing a plain object to useSchemaOrg(). Use @type for the schema type and any valid Schema.org pr...
- [Identity](./schema-org/2.guides/4.recipes/1.identity.md): Quick Answer: Set up your site identity with defineOrganization() or definePerson(). This establishes who owns/creates your content and enables Goo...
- [Blog](./schema-org/2.guides/4.recipes/blog.md): Use defineArticle() with @type: 'BlogPosting' to mark up blog posts. This enables rich snippets showing author, publish date, and article images in...
- [Breadcrumbs](./schema-org/2.guides/4.recipes/breadcrumbs.md): Use defineBreadcrumb() with an array of { name, item } objects to create breadcrumb navigation markup. Google displays this as a clickable path in ...
- [eCommerce](./schema-org/2.guides/4.recipes/e-commerce.md): Use defineProduct() with offers, aggregateRating, and review properties to enable product rich results. Google can display price, availability, rat...
- [FAQ](./schema-org/2.guides/4.recipes/faq.md): Use defineQuestion() with defineWebPage({ '@type': 'FAQPage' }) to mark up FAQ content. Google can display your questions and answers directly in s...
- [How To](./schema-org/2.guides/4.recipes/how-to.md): Creating How-To content is an excellent way to provide valuable instructions to your users. With Schema.org markup, you can help search engines bet...
- [Site Search](./schema-org/2.guides/4.recipes/site-search.md): If your site offers a search function, you may like to define markup to help Google understand it.

## schema-org/5.api/0.composables (1)

- [useSchemaOrg()](./schema-org/5.api/0.composables/0.use-schema-org.md): The useSchemaOrg(){lang="ts"} composable is the primary way to add Schema.org structured data to your pages.

## schema-org/5.api/9.schema (34)

- [Article Schema](./schema-org/5.api/9.schema/article.md): WebPage
- [Book Schema](./schema-org/5.api/9.schema/book.md): ::alert{type="warning"}
 Schema in development
::
- [Breadcrumb Schema](./schema-org/5.api/9.schema/breadcrumb.md): WebPage
- [Comment Schema](./schema-org/5.api/9.schema/comment.md): See the blog recipe for more examples.
- [Course Schema](./schema-org/5.api/9.schema/course.md): ::alert{type="warning"}
 Documentation in progress
::
- [Dataset Schema](./schema-org/5.api/9.schema/dataset.md): Type: defineDataset(input?: Dataset){lang="ts"}
- [Event Schema](./schema-org/5.api/9.schema/event.md): ::alert{type="warning"}
 Documentation in progress
::
- [Food Establishment Schema](./schema-org/5.api/9.schema/food-establishment.md): Type: defineFoodEstablishment(input?: FoodEstablishment){lang="ts"}
- [HowTo Schema](./schema-org/5.api/9.schema/how-to.md)
- [Image Schema](./schema-org/5.api/9.schema/image.md): Describes an individual image (usually in the context of an embedded media object).
- [ItemList Schema](./schema-org/5.api/9.schema/item-list.md): A list of items of any sort. Mainly used for breadcrumbs and carousels.
- [Job Posting Schema](./schema-org/5.api/9.schema/job-posting.md): See Global Resolves for full context.
- [Local Business Schema](./schema-org/5.api/9.schema/local-business.md): Type: defineLocalBusiness(input?: LocalBusiness){lang="ts"}
- [Movie Schema](./schema-org/5.api/9.schema/movie.md): Type: defineMovie(input?: Movie){lang="ts"}
- [Music Album Schema](./schema-org/5.api/9.schema/music-album.md): Type: defineMusicAlbum(input?: MusicAlbum){lang="ts"}
- [Music Group Schema](./schema-org/5.api/9.schema/music-group.md): Type: defineMusicGroup(input?: MusicGroup){lang="ts"}
- [Music Playlist Schema](./schema-org/5.api/9.schema/music-playlist.md): Type: defineMusicPlaylist(input?: MusicPlaylist){lang="ts"}
- [Music Recording Schema](./schema-org/5.api/9.schema/music-recording.md): Type: defineMusicRecording(input?: MusicRecording){lang="ts"}
- [Organization Schema](./schema-org/5.api/9.schema/organization.md): See Global Resolves for full context.
- [Person Schema](./schema-org/5.api/9.schema/person.md): See Global Resolves for full context.
- [Podcast Episode Schema](./schema-org/5.api/9.schema/podcast-episode.md): Type: definePodcastEpisode(input?: PodcastEpisode){lang="ts"}
- [Podcast Season Schema](./schema-org/5.api/9.schema/podcast-season.md): Type: definePodcastSeason(input?: PodcastSeason){lang="ts"}
- [Podcast Series Schema](./schema-org/5.api/9.schema/podcast-series.md): Type: definePodcastSeries(input?: PodcastSeries){lang="ts"}
- [Product Schema](./schema-org/5.api/9.schema/product.md): See Global Resolves for full context.
- [Question Schema](./schema-org/5.api/9.schema/question.md): See Global Resolves for full context.
- [Recipe Schema](./schema-org/5.api/9.schema/recipe.md): See Global Resolves for full context.
- [Service Schema](./schema-org/5.api/9.schema/service.md): Type: defineService(input?: Service){lang="ts"}
- [Software App Schema](./schema-org/5.api/9.schema/software-app.md): ::alert{type="warning"}
 Documentation in development
::
- [TV Episode Schema](./schema-org/5.api/9.schema/tv-episode.md): Type: defineTVEpisode(input?: TVEpisode){lang="ts"}
- [TV Season Schema](./schema-org/5.api/9.schema/tv-season.md): Type: defineTVSeason(input?: TVSeason){lang="ts"}
- [TV Series Schema](./schema-org/5.api/9.schema/tv-series.md): Type: defineTVSeries(input?: TVSeries){lang="ts"}
- [Video Schema](./schema-org/5.api/9.schema/video.md): See Global Resolves for full context.
- [WebPage Schema](./schema-org/5.api/9.schema/webpage.md): Home page only
- [WebSite Schema](./schema-org/5.api/9.schema/website.md)
