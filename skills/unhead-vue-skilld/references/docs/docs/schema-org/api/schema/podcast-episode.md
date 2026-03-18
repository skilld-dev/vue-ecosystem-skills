---
title: "Podcast Episode Schema · Unhead"
meta:
  "og:description": "Use definePodcastEpisode() to add PodcastEpisode structured data. Enable podcast rich results with episode title, audio, and description."
  "og:title": "Podcast Episode Schema · Unhead"
  description: "Use definePodcastEpisode() to add PodcastEpisode structured data. Enable podcast rich results with episode title, audio, and description."
---

**Schema**

# **Podcast Episode Schema**

Copy for LLMs

## [Schema.org PodcastEpisode](#schemaorg-podcastepisode)

**Type**: `definePodcastEpisode(input?: PodcastEpisode)`

Describes an individual podcast episode.

## [Useful Links](#useful-links)

- **PodcastEpisode - Schema.org**
- **Podcast Structured Data - Google Search Central**

## [Required properties](#required-properties)

- **name** `string`The name/title of the podcast episode.
- **url** `string`The URL of the episode page.

## [Recommended Properties](#recommended-properties)

- **audio** `string`The URL of the audio file for the episode.
- **description** `string`A description of the episode.
- **duration** `string`The duration of the episode in ISO 8601 format (e.g., "PT45M" for 45 minutes).
- **datePublished** `ResolvableDate`The date the episode was published.
- **partOfSeries** `NodeRelation<any>`Reference to the podcast series this episode belongs to.

## [Defaults](#defaults)

- **@type**: `PodcastEpisode`
- **inLanguage**: `options.defaultLanguage` _(see: **Schema.org Params**)_

## [Examples](#examples)

### [Minimal](#minimal)

```
definePodcastEpisode({
  name: 'Episode 1: Getting Started',
  url: 'https://example.com/podcast/episode-1',
  audio: 'https://example.com/podcast/ep1.mp3',
})
```

### [Complete](#complete)

```
definePodcastEpisode({
  name: 'Episode 42: The Answer to Everything',
  description: 'In this episode, we explore the meaning of life, the universe, and everything.',
  url: 'https://example.com/podcast/episode-42',
  audio: 'https://example.com/podcast/ep42.mp3',
  episodeNumber: 42,
  duration: 'PT45M30S', // 45 minutes 30 seconds
  datePublished: new Date(2024, 5, 15),
  image: 'https://example.com/episode-42-cover.jpg',
  transcript: 'https://example.com/podcast/ep42-transcript',
  partOfSeries: {
    name: 'The Example Podcast',
  },
  author: {
    name: 'Jane Doe',
  },
})
```

## [Types](#types)

```
export interface PodcastEpisodeSimple extends Thing {
  name: string
  description?: string
  url?: string
  episodeNumber?: number | string
  partOfSeries?: NodeRelation<any>
  partOfSeason?: NodeRelation<any>
  author?: NodeRelations<Person | Organization | string>
  audio?: NodeRelation<any | string>
  duration?: string
  image?: NodeRelations<string | ImageObject>
  thumbnailUrl?: string
  datePublished?: ResolvableDate
  uploadDate?: ResolvableDate
  transcript?: string
  inLanguage?: string
  aggregateRating?: NodeRelation<AggregateRating>
  review?: NodeRelations<Review>
  keywords?: Arrayable<string>
}
```

## [Related Schemas](#related-schemas)

- **PodcastSeries** - Parent series
- **Person** - Host, guests

Edit this page

Markdown For LLMs

**Did this page help you? **

**Person Schema** Use definePerson() to add Person structured data. Establish author identity for articles and content with name, image, and social profile links. **Podcast Season Schema** Use definePodcastSeason() to add PodcastSeason structured data. Organize podcast episodes by season with episode counts and dates.