---
title: "Music Group Schema · Unhead"
meta:
  "og:description": "Use defineMusicGroup() to add MusicGroup structured data. Display band info with members, genre, and discography in search results."
  "og:title": "Music Group Schema · Unhead"
  description: "Use defineMusicGroup() to add MusicGroup structured data. Display band info with members, genre, and discography in search results."
---

**Schema**

# **Music Group Schema**

Copy for LLMs

## [Schema.org MusicGroup](#schemaorg-musicgroup)

**Type**: `defineMusicGroup(input?: MusicGroup)`

Describes a band or musical group.

## [Useful Links](#useful-links)

- **MusicGroup - Schema.org**

## [Required properties](#required-properties)

- **name** `string`The name of the band/musical group.

## [Recommended Properties](#recommended-properties)

- **member** `NodeRelations<Person | string>`Array of band members. Resolves to **Person**.
- **genre** `string | string[]`The genre(s) of music the group performs.
- **album** `NodeRelations<MusicAlbum>`Array of albums by the group.

## [Defaults](#defaults)

- **@type**: `MusicGroup`
- **@id**: `${canonicalHost}#music-group`
- **url**: `options.canonicalHost`

## [Examples](#examples)

### [Minimal](#minimal)

```
defineMusicGroup({
  name: 'The Beatles',
})
```

### [Complete](#complete)

```
defineMusicGroup({
  name: 'The Beatles',
  description: 'English rock band formed in Liverpool in 1960',
  url: 'https://example.com/artists/the-beatles',
  genre: ['Rock', 'Pop'],
  member: [
    { name: 'John Lennon' },
    { name: 'Paul McCartney' },
    { name: 'George Harrison' },
    { name: 'Ringo Starr' },
  ],
  foundingDate: new Date(1960, 7, 1),
  dissolutionDate: new Date(1970, 3, 10),
  album: [
    { name: 'Abbey Road' },
    { name: 'Sgt. Pepper\'s Lonely Hearts Club Band' },
  ],
  image: 'https://example.com/artists/the-beatles.jpg',
  sameAs: [
    'https://www.facebook.com/thebeatles',
    'https://twitter.com/thebeatles',
  ],
})
```

## [Types](#types)

```
export interface MusicGroupSimple extends Thing {
  name: string
  description?: string
  url?: string
  genre?: string | string[]
  member?: NodeRelations<Person | string>
  foundingDate?: ResolvableDate
  dissolutionDate?: ResolvableDate
  album?: NodeRelations<string>
  track?: NodeRelations<string>
  image?: NodeRelations<string | ImageObject>
  sameAs?: Arrayable<string>
}
```

## [Related Schemas](#related-schemas)

- **Person** - Band members
- **MusicAlbum** - Discography
- **MusicRecording** - Songs
- **Event** - Concerts

Edit this page

Markdown For LLMs

**Did this page help you? **

**Music Album Schema** Use defineMusicAlbum() to add MusicAlbum structured data. Display album info with artist, tracks, and release date in search results. **Music Playlist Schema** Use defineMusicPlaylist() to add MusicPlaylist structured data. Display playlist info with track count, creator, and song list in search.