---
title: "TV Series Schema · Unhead"
meta:
  "og:description": "Use defineTVSeries() to add TVSeries structured data. Enable rich results for TV shows with cast, creator, ratings, and season info."
  "og:title": "TV Series Schema · Unhead"
  description: "Use defineTVSeries() to add TVSeries structured data. Enable rich results for TV shows with cast, creator, ratings, and season info."
---

**Schema**

# **TV Series Schema**

Copy for LLMs

## [Schema.org TVSeries](#schemaorg-tvseries)

**Type**: `defineTVSeries(input?: TVSeries)`

Describes a TV show series.

## [Useful Links](#useful-links)

- **TVSeries - Schema.org**
- **Video Structured Data - Google Search Central**

## [Required properties](#required-properties)

- **name** `string`The name of the TV series.

## [Recommended Properties](#recommended-properties)

- **actor** `NodeRelations<Person | string>`Array of actors in the series. Resolves to **Person**.
- **director** `NodeRelations<Person | string>`Array of directors of the series. Resolves to **Person**.
- **creator** `NodeRelations<Person | Organization | string>`The creator of the series. Resolves to **Person** or **Organization**.
- **numberOfSeasons** `number`The total number of seasons.
- **numberOfEpisodes** `number`The total number of episodes.

## [Defaults](#defaults)

- **@type**: `TVSeries`
- **@id**: `${canonicalHost}#tv-series`

## [Examples](#examples)

### [Minimal](#minimal)

```
defineTVSeries({
  name: 'Breaking Bad',
})
```

### [Complete](#complete)

```
defineTVSeries({
  name: 'Breaking Bad',
  description: 'A chemistry teacher diagnosed with cancer turns to manufacturing meth',
  url: 'https://example.com/shows/breaking-bad',
  image: 'https://example.com/shows/breaking-bad-poster.jpg',
  numberOfSeasons: 5,
  numberOfEpisodes: 62,
  genre: ['Crime', 'Drama', 'Thriller'],
  actor: [
    { name: 'Bryan Cranston' },
    { name: 'Aaron Paul' },
  ],
  director: [
    { name: 'Vince Gilligan' },
  ],
  creator: {
    name: 'Vince Gilligan',
  },
  productionCompany: {
    name: 'AMC Studios',
  },
  datePublished: new Date(2008, 0, 20),
  aggregateRating: {
    ratingValue: 9.5,
    ratingCount: 1500000,
  },
})
```

## [Types](#types)

```
export interface TVSeriesSimple extends Thing {
  name: string
  description?: string
  url?: string
  image?: NodeRelations<string | ImageObject>
  actor?: NodeRelations<Person | string>
  director?: NodeRelations<Person | string>
  creator?: NodeRelations<Person | Organization | string>
  numberOfSeasons?: number
  numberOfEpisodes?: number
  containsSeason?: NodeRelations<any>
  episode?: NodeRelations<any>
  genre?: string | string[]
  datePublished?: ResolvableDate
  startDate?: ResolvableDate
  endDate?: ResolvableDate
  productionCompany?: NodeRelation<Organization | string>
  aggregateRating?: NodeRelation<AggregateRating>
  countryOfOrigin?: string
  trailer?: NodeRelation<VideoObject | string>
  contentRating?: string
}
```

Edit this page

Markdown For LLMs

**Did this page help you? **

**TV Season Schema** Use defineTVSeason() to add TVSeason structured data. Organize TV episodes by season with episode counts, cast, and air dates. **Video Schema** Use defineVideo() to add VideoObject structured data. Enable video rich snippets with thumbnails, duration, and upload date in Google search results.