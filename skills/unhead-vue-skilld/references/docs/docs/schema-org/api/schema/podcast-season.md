---
title: "Podcast Season Schema · Unhead"
meta:
  "og:description": "Use definePodcastSeason() to add PodcastSeason structured data. Organize podcast episodes by season with episode counts and dates."
  "og:title": "Podcast Season Schema · Unhead"
  description: "Use definePodcastSeason() to add PodcastSeason structured data. Organize podcast episodes by season with episode counts and dates."
---

**Schema**

# **Podcast Season Schema**

Copy for LLMs

## [Schema.org PodcastSeason](#schemaorg-podcastseason)

**Type**: `definePodcastSeason(input?: PodcastSeason)`

Describes a season of a podcast series.

## [Useful Links](#useful-links)

- **PodcastSeason - Schema.org**
- **Podcast Structured Data - Google Search Central**

## [Recommended Properties](#recommended-properties)

- **name** `string`The name of the season.
- **seasonNumber** `number`The season number.
- **partOfSeries** `NodeRelation<any>`Reference to the podcast series this season belongs to.
- **numberOfEpisodes** `number`The number of episodes in the season.

## [Defaults](#defaults)

- **@type**: `PodcastSeason`

## [Examples](#examples)

### [Minimal](#minimal)

```
definePodcastSeason({
  seasonNumber: 2,
  partOfSeries: {
    name: 'The Example Podcast',
  },
})
```

### [Complete](#complete)

```
definePodcastSeason({
  name: 'Season 2: Advanced Topics',
  seasonNumber: 2,
  description: 'In season 2, we dive deeper into advanced concepts',
  numberOfEpisodes: 12,
  partOfSeries: {
    name: 'The Example Podcast',
  },
  image: 'https://example.com/season-2-cover.jpg',
  datePublished: new Date(2024, 0, 1),
  startDate: new Date(2024, 0, 1),
  endDate: new Date(2024, 5, 30),
})
```

## [Types](#types)

```
export interface PodcastSeasonSimple extends Thing {
  name?: string
  description?: string
  seasonNumber?: number
  numberOfEpisodes?: number
  partOfSeries?: NodeRelation<any>
  episode?: NodeRelations<any>
  datePublished?: ResolvableDate
  startDate?: ResolvableDate
  endDate?: ResolvableDate
  image?: NodeRelations<string | ImageObject>
  url?: string
  actor?: NodeRelations<Person | string>
  director?: NodeRelations<Person | string>
  productionCompany?: NodeRelation<Organization | string>
  aggregateRating?: NodeRelation<AggregateRating>
}
```

Edit this page

Markdown For LLMs

**Did this page help you? **

**Podcast Episode Schema** Use definePodcastEpisode() to add PodcastEpisode structured data. Enable podcast rich results with episode title, audio, and description. **Podcast Series Schema** Use definePodcastSeries() to add PodcastSeries structured data. Enable podcast rich results with show info, host, and RSS feed link.