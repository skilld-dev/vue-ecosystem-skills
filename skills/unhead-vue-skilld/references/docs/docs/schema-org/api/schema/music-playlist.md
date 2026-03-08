---
title: "Music Playlist Schema · Unhead"
meta:
  "og:description": "Use defineMusicPlaylist() to add MusicPlaylist structured data. Display playlist info with track count, creator, and song list in search."
  "og:title": "Music Playlist Schema · Unhead"
  description: "Use defineMusicPlaylist() to add MusicPlaylist structured data. Display playlist info with track count, creator, and song list in search."
---

**Schema**

# **Music Playlist Schema**

Copy for LLMs

**On this page **

- [Schema.org MusicPlaylist](#schemaorg-musicplaylist)
- [Useful Links](#useful-links)
- [Required properties](#required-properties)
- [Recommended Properties](#recommended-properties)
- [Defaults](#defaults)
- [Examples](#examples)
- [Types](#types)
- [Related Schemas](#related-schemas)

## [Schema.org MusicPlaylist](#schemaorg-musicplaylist)

**Type**: `defineMusicPlaylist(input?: MusicPlaylist)`

Describes a curated music playlist.

## [Useful Links](#useful-links)

- **MusicPlaylist - Schema.org**

## [Required properties](#required-properties)

- **name** `string`The name of the playlist.

## [Recommended Properties](#recommended-properties)

- **track** `NodeRelations<MusicRecording>`Array of music recordings in the playlist.
- **creator** `NodeRelations<Person | MusicGroup | string>`The person or group who created the playlist. Resolves to **Person** or **MusicGroup**.
- **numTracks** `number`The number of tracks in the playlist.

## [Defaults](#defaults)

- **@type**: `MusicPlaylist`
- **@id**: `${canonicalHost}#music-playlist`

## [Examples](#examples)

### [Minimal](#minimal)

```
defineMusicPlaylist({
  name: 'Best of Rock 2024',
  numTracks: 25,
})
```

### [Complete](#complete)

```
defineMusicPlaylist({
  name: 'Best of Rock 2024',
  description: 'A curated collection of the best rock songs from 2024',
  url: 'https://example.com/playlists/best-of-rock-2024',
  creator: {
    name: 'Jane Doe',
  },
  numTracks: 25,
  track: [
    { name: 'Song Title 1', byArtist: 'Artist 1' },
    { name: 'Song Title 2', byArtist: 'Artist 2' },
  ],
  datePublished: new Date(2024, 0, 1),
  dateModified: new Date(2024, 11, 31),
  image: 'https://example.com/playlists/best-of-rock-2024-cover.jpg',
})
```

## [Types](#types)

```
export interface MusicPlaylistSimple extends Thing {
  name: string
  description?: string
  url?: string
  numTracks?: number
  track?: NodeRelations<string>
  creator?: NodeRelation<Person | string>
  datePublished?: ResolvableDate
  dateModified?: ResolvableDate
  image?: NodeRelations<string | ImageObject>
  aggregateRating?: NodeRelation<AggregateRating>
}
```

## [Related Schemas](#related-schemas)

- **MusicRecording** - Playlist tracks
- **Person** - Playlist creator

Edit this page

Markdown For LLMs

**Did this page help you? **

**Music Group Schema** Use defineMusicGroup() to add MusicGroup structured data. Display band info with members, genre, and discography in search results. **Music Recording Schema** Use defineMusicRecording() to add MusicRecording structured data. Display song info with artist, album, and duration in search results.

**On this page **

- [Schema.org MusicPlaylist](#schemaorg-musicplaylist)
- [Useful Links](#useful-links)
- [Required properties](#required-properties)
- [Recommended Properties](#recommended-properties)
- [Defaults](#defaults)
- [Examples](#examples)
- [Types](#types)
- [Related Schemas](#related-schemas)