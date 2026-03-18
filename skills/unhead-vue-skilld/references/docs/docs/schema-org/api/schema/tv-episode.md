---
title: "TV Episode Schema · Unhead"
meta:
  "og:description": "Use defineTVEpisode() to add TVEpisode structured data. Enable rich results for TV episodes with cast, director, and ratings info."
  "og:title": "TV Episode Schema · Unhead"
  description: "Use defineTVEpisode() to add TVEpisode structured data. Enable rich results for TV episodes with cast, director, and ratings info."
---

**Schema**

# **TV Episode Schema**

Copy for LLMs

## [Schema.org TVEpisode](#schemaorg-tvepisode)

**Type**: `defineTVEpisode(input?: TVEpisode)`

Describes an individual TV episode.

## [Useful Links](#useful-links)

- **TVEpisode - Schema.org**
- **Video Structured Data - Google Search Central**

## [Required properties](#required-properties)

- **name** `string`The name/title of the episode.

## [Recommended Properties](#recommended-properties)

- **episodeNumber** `number`The episode number within its season.
- **partOfSeason** `NodeRelation<TVSeason>`Reference to the season this episode belongs to.
- **partOfSeries** `NodeRelation<TVSeries>`Reference to the series this episode belongs to.
- **video** `NodeRelations<VideoObject | string>`Video content for the episode. Resolves to VideoObject.
- **duration** `string`The duration in ISO 8601 format (e.g., "PT45M" for 45 minutes).

## [Defaults](#defaults)

- **@type**: `TVEpisode`

## [Examples](#examples)

### [Minimal](#minimal)

```
defineTVEpisode({
  name: 'Pilot',
  episodeNumber: 1,
})
```

### [Complete](#complete)

```
defineTVEpisode({
  name: 'Pilot',
  description: 'The first episode of Breaking Bad',
  episodeNumber: 1,
  partOfSeason: {
    seasonNumber: 1,
  },
  partOfSeries: {
    name: 'Breaking Bad',
  },
  url: 'https://example.com/shows/breaking-bad/s1/e1',
  duration: 'PT58M',
  datePublished: new Date(2008, 0, 20),
  image: 'https://example.com/shows/breaking-bad-s1e1.jpg',
  video: {
    name: 'Pilot',
    url: 'https://example.com/videos/breaking-bad-s1e1.mp4',
    uploadDate: new Date(2008, 0, 20),
  },
  actor: [
    { name: 'Bryan Cranston' },
    { name: 'Aaron Paul' },
  ],
  director: {
    name: 'Vince Gilligan',
  },
  aggregateRating: {
    ratingValue: 9.0,
    ratingCount: 50000,
  },
})
```

## [Types](#types)

```
export interface TVEpisodeSimple extends Thing {
  name: string
  description?: string
  episodeNumber?: number | string
  partOfSeason?: NodeRelation<any>
  partOfSeries?: NodeRelation<any>
  actor?: NodeRelations<Person | string>
  director?: NodeRelations<Person | string>
  datePublished?: ResolvableDate
  uploadDate?: ResolvableDate
  duration?: string
  video?: NodeRelation<VideoObject | string>
  image?: NodeRelations<string | ImageObject>
  thumbnailUrl?: string
  url?: string
  aggregateRating?: NodeRelation<AggregateRating>
  review?: NodeRelations<Review>
  contentRating?: string
  musicBy?: NodeRelations<Person | string>
}
```

## [Related Schemas](#related-schemas)

- **TVSeason** - Parent season
- **Person** - Director, actors
- **Organization** - Production company

Edit this page

Markdown For LLMs

**Did this page help you? **

**SoftwareApplication** Implement SoftwareApplication structured data with Unhead. JSON-LD examples for app listings, ratings, pricing, and Google rich results. **TV Season Schema** Use defineTVSeason() to add TVSeason structured data. Organize TV episodes by season with episode counts, cast, and air dates.