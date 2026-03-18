---
title: "Music Recording Schema · Unhead"
meta:
  "og:description": "Use defineMusicRecording() to add MusicRecording structured data. Display song info with artist, album, and duration in search results."
  "og:title": "Music Recording Schema · Unhead"
  description: "Use defineMusicRecording() to add MusicRecording structured data. Display song info with artist, album, and duration in search results."
---

**Schema**

# **Music Recording Schema**

Copy for LLMs

## [Schema.org MusicRecording](#schemaorg-musicrecording)

**Type**: `defineMusicRecording(input?: MusicRecording)`

Describes an individual music track or song.

## [Useful Links](#useful-links)

- **MusicRecording - Schema.org**

## [Required properties](#required-properties)

- **name** `string`The name of the song/track.
- **url** `string`The URL where the song can be accessed.

## [Recommended Properties](#recommended-properties)

- **byArtist** `NodeRelations<Person | MusicGroup | string>`The artist(s) who performed the song. Resolves to **Person** or **MusicGroup**.
- **inAlbum** `NodeRelation<MusicAlbum>`Reference to the album this recording is part of.
- **duration** `string`The duration of the track in ISO 8601 format (e.g., "PT3M45S" for 3 minutes 45 seconds).
- **isrcCode** `string`International Standard Recording Code for the track.

## [Defaults](#defaults)

- **@type**: `MusicRecording`
- **@id**: `${canonicalHost}#music-recording`

## [Examples](#examples)

### [Minimal](#minimal)

```
defineMusicRecording({
  name: 'Bohemian Rhapsody',
  url: 'https://example.com/tracks/bohemian-rhapsody',
  byArtist: 'Queen',
})
```

### [Complete](#complete)

```
defineMusicRecording({
  name: 'Bohemian Rhapsody',
  url: 'https://example.com/tracks/bohemian-rhapsody',
  audio: 'https://example.com/audio/bohemian-rhapsody.mp3',
  byArtist: {
    name: 'Queen',
  },
  inAlbum: {
    name: 'A Night at the Opera',
  },
  duration: 'PT5M55S', // 5 minutes 55 seconds
  isrcCode: 'GBUM71029604',
  datePublished: new Date(1975, 9, 31),
  genre: 'Progressive Rock',
  image: 'https://example.com/tracks/bohemian-rhapsody-cover.jpg',
})
```

## [Types](#types)

```
export interface MusicRecordingSimple extends Thing {
  name: string
  description?: string
  url?: string
  audio?: string
  byArtist?: NodeRelations<Person | MusicGroup | string>
  inAlbum?: NodeRelation<MusicAlbum>
  inPlaylist?: NodeRelations<string>
  duration?: string
  isrcCode?: string
  recordingOf?: NodeRelation<string>
  datePublished?: ResolvableDate
  genre?: string | string[]
  image?: NodeRelations<string | ImageObject>
  aggregateRating?: NodeRelation<AggregateRating>
}
```

## [Related Schemas](#related-schemas)

- **MusicAlbum** - Album containing track
- **MusicGroup** - Performing artist
- **Person** - Individual artist

Edit this page

Markdown For LLMs

**Did this page help you? **

**Music Playlist Schema** Use defineMusicPlaylist() to add MusicPlaylist structured data. Display playlist info with track count, creator, and song list in search. **Organization** Add Organization structured data with Unhead. JSON-LD examples for company identity, logo, sameAs social profiles, and Google Knowledge Panel setup.