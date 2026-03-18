---
title: "Music Album Schema · Unhead"
meta:
  "og:description": "Use defineMusicAlbum() to add MusicAlbum structured data. Display album info with artist, tracks, and release date in search results."
  "og:title": "Music Album Schema · Unhead"
  description: "Use defineMusicAlbum() to add MusicAlbum structured data. Display album info with artist, tracks, and release date in search results."
---

**Schema**

# **Music Album Schema**

Copy for LLMs

## [Schema.org MusicAlbum](#schemaorg-musicalbum)

**Type**: `defineMusicAlbum(input?: MusicAlbum)`

Describes a music album collection.

## [Useful Links](#useful-links)

- **MusicAlbum - Schema.org**

## [Required properties](#required-properties)

- **name** `string`The name of the album.

## [Recommended Properties](#recommended-properties)

- **byArtist** `NodeRelations<Person | MusicGroup | string>`The artist(s) of the album. Resolves to **Person** or **MusicGroup**.
- **albumProductionType** `string`The production type: "StudioAlbum", "LiveAlbum", "CompilationAlbum", "SoundtrackAlbum", etc.
- **albumReleaseType** `string`The release type: "AlbumRelease", "SingleRelease", "EPRelease", etc.
- **track** `NodeRelations<MusicRecording>`Array of music recordings on the album.

## [Defaults](#defaults)

- **@type**: `MusicAlbum`
- **@id**: `${canonicalHost}#music-album`

## [Examples](#examples)

### [Minimal](#minimal)

```
defineMusicAlbum({
  name: 'Abbey Road',
  byArtist: 'The Beatles',
})
```

### [Complete](#complete)

```
defineMusicAlbum({
  name: 'Abbey Road',
  description: 'The eleventh studio album by The Beatles',
  url: 'https://example.com/albums/abbey-road',
  byArtist: {
    name: 'The Beatles',
  },
  albumProductionType: 'StudioAlbum',
  albumReleaseType: 'AlbumRelease',
  datePublished: new Date(1969, 8, 26),
  genre: ['Rock', 'Pop'],
  numTracks: 17,
  image: 'https://example.com/albums/abbey-road-cover.jpg',
  track: [
    { name: 'Come Together' },
    { name: 'Something' },
    // ... more tracks
  ],
})
```

## [Types](#types)

```
export interface MusicAlbumSimple extends Thing {
  name: string
  description?: string
  url?: string
  byArtist?: NodeRelations<Person | MusicGroup | string>
  track?: NodeRelations<string>
  albumProductionType?: string
  albumReleaseType?: string
  datePublished?: ResolvableDate
  genre?: string | string[]
  numTracks?: number
  image?: NodeRelations<string | ImageObject>
  aggregateRating?: NodeRelation<AggregateRating>
  review?: NodeRelations<Review>
}
```

## [Related Schemas](#related-schemas)

- **MusicGroup** - Artist/band
- **MusicRecording** - Album tracks
- **Person** - Artist

Edit this page

Markdown For LLMs

**Did this page help you? **

**Movie Schema** Use defineMovie() to add Movie structured data. Enable rich results with ratings, cast, director, and release date in Google search. **Music Group Schema** Use defineMusicGroup() to add MusicGroup structured data. Display band info with members, genre, and discography in search results.