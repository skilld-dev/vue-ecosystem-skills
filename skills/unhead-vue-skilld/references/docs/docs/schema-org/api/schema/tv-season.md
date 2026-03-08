---
title: "TV Season Schema · Unhead"
meta:
  "og:description": "Use defineTVSeason() to add TVSeason structured data. Organize TV episodes by season with episode counts, cast, and air dates."
  "og:title": "TV Season Schema · Unhead"
  description: "Use defineTVSeason() to add TVSeason structured data. Organize TV episodes by season with episode counts, cast, and air dates."
---

**Schema**

# **TV Season Schema**

Copy for LLMs

**On this page **

- [Schema.org TVSeason](#schemaorg-tvseason)
- [Useful Links](#useful-links)
- [Recommended Properties](#recommended-properties)
- [Defaults](#defaults)
- [Examples](#examples)
- [Types](#types)
- [Related Schemas](#related-schemas)

## [Schema.org TVSeason](#schemaorg-tvseason)

**Type**: `defineTVSeason(input?: TVSeason)`

Describes a season of a TV series.

## [Useful Links](#useful-links)

- **TVSeason - Schema.org**

## [Recommended Properties](#recommended-properties)

- **name** `string`The name of the season.
- **seasonNumber** `number`The season number.
- **partOfSeries** `NodeRelation<TVSeries>`Reference to the TV series this season belongs to.
- **numberOfEpisodes** `number`The number of episodes in the season.

## [Defaults](#defaults)

- **@type**: `TVSeason`

## [Examples](#examples)

### [Minimal](#minimal)

```
defineTVSeason({
  seasonNumber: 2,
  partOfSeries: {
    name: 'Breaking Bad',
  },
})
```

### [Complete](#complete)

```
defineTVSeason({
  name: 'Season 2',
  seasonNumber: 2,
  description: 'The second season of Breaking Bad',
  numberOfEpisodes: 13,
  partOfSeries: {
    name: 'Breaking Bad',
  },
  image: 'https://example.com/shows/breaking-bad-season-2.jpg',
  datePublished: new Date(2009, 2, 8),
  startDate: new Date(2009, 2, 8),
  endDate: new Date(2009, 4, 31),
})
```

## [Types](#types)

```
export interface TVSeasonSimple extends Thing {
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
  contentRating?: string
  trailer?: NodeRelation<VideoObject | string>
}
```

## [Related Schemas](#related-schemas)

- **TVEpisode** - Season episodes
- **Person** - Director, actors
- **Organization** - Production company

Edit this page

Markdown For LLMs

**Did this page help you? **

**TV Episode Schema** Use defineTVEpisode() to add TVEpisode structured data. Enable rich results for TV episodes with cast, director, and ratings info. **TV Series Schema** Use defineTVSeries() to add TVSeries structured data. Enable rich results for TV shows with cast, creator, ratings, and season info.

**On this page **

- [Schema.org TVSeason](#schemaorg-tvseason)
- [Useful Links](#useful-links)
- [Recommended Properties](#recommended-properties)
- [Defaults](#defaults)
- [Examples](#examples)
- [Types](#types)
- [Related Schemas](#related-schemas)