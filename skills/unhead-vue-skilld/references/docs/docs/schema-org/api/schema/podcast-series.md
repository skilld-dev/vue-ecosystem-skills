---
title: "Podcast Series Schema · Unhead"
meta:
  "og:description": "Use definePodcastSeries() to add PodcastSeries structured data. Enable podcast rich results with show info, host, and RSS feed link."
  "og:title": "Podcast Series Schema · Unhead"
  description: "Use definePodcastSeries() to add PodcastSeries structured data. Enable podcast rich results with show info, host, and RSS feed link."
---

**Schema**

# **Podcast Series Schema**

Copy for LLMs

## [Schema.org PodcastSeries](#schemaorg-podcastseries)

**Type**: `definePodcastSeries(input?: PodcastSeries)`

Describes a podcast series - the main podcast show.

## [Useful Links](#useful-links)

- **PodcastSeries - Schema.org**
- **Podcast Structured Data - Google Search Central**

## [Required properties](#required-properties)

- **name** `string`The name of the podcast series.

## [Recommended Properties](#recommended-properties)

- **webFeed** `string`The URL of the podcast RSS feed.
- **author** `NodeRelations<Person | Organization | string>`The author/creator/host of the podcast. Resolves to **Person** or **Organization**.
- **image** `NodeRelations<string | ImageObject>`The podcast cover art.
- **description** `string`A description of the podcast.
- **genre** `string | string[]`The genre(s) of the podcast (e.g., "Technology", "Education", "Comedy").

## [Defaults](#defaults)

- **@type**: `PodcastSeries`
- **@id**: `${canonicalUrl}#podcast-series`

## [Examples](#examples)

### [Minimal](#minimal)

```
definePodcastSeries({
  name: 'The Example Podcast',
  webFeed: 'https://example.com/podcast/feed.rss',
})
```

### [Complete](#complete)

```
definePodcastSeries({
  name: 'The Example Podcast',
  description: 'A podcast about interesting topics in technology and science',
  url: 'https://example.com/podcast',
  webFeed: 'https://example.com/podcast/feed.rss',
  image: 'https://example.com/podcast-cover.jpg',
  author: {
    name: 'Jane Doe',
    url: 'https://janedoe.com',
  },
  numberOfEpisodes: 42,
  numberOfSeasons: 3,
  genre: ['Technology', 'Science', 'Education'],
  datePublished: new Date(2023, 0, 1),
})
```

## [Types](#types)

```
export interface PodcastSeriesSimple extends Thing {
  name: string
  description?: string
  image?: NodeRelations<string | ImageObject>
  url?: string
  author?: NodeRelations<Person | Organization | string>
  webFeed?: string
  episode?: NodeRelations<any>
  containsSeason?: NodeRelations<any>
  numberOfEpisodes?: number
  numberOfSeasons?: number
  genre?: string | string[]
  datePublished?: ResolvableDate
  startDate?: ResolvableDate
  endDate?: ResolvableDate
  aggregateRating?: NodeRelation<AggregateRating>
  inLanguage?: string
  keywords?: Arrayable<string>
}
```

## [Related Schemas](#related-schemas)

- **PodcastEpisode** - Episodes
- **Person** - Host
- **Organization** - Publisher

Edit this page

Markdown For LLMs

**Did this page help you? **

**Podcast Season Schema** Use definePodcastSeason() to add PodcastSeason structured data. Organize podcast episodes by season with episode counts and dates. **Product Schema** Use defineProduct() to add Product structured data for e-commerce. Enable rich snippets with pricing, reviews, and availability in Google search results.