---
title: "Dataset Schema · Unhead"
meta:
  "og:description": "Use defineDataset() to add Dataset structured data. Make research data discoverable in Google Dataset Search with metadata and download links."
  "og:title": "Dataset Schema · Unhead"
  description: "Use defineDataset() to add Dataset structured data. Make research data discoverable in Google Dataset Search with metadata and download links."
---

**Schema**

# **Dataset Schema**

Copy for LLMs

**On this page **

- [Schema.org Dataset](#schemaorg-dataset)
- [Useful Links](#useful-links)
- [Required properties](#required-properties)
- [Recommended Properties](#recommended-properties)
- [Defaults](#defaults)
- [Examples](#examples)
- [Types](#types)
- [Related Schemas](#related-schemas)

## [Schema.org Dataset](#schemaorg-dataset)

**Type**: `defineDataset(input?: Dataset)`

Describes a research dataset for scientific, academic, or data science purposes.

## [Useful Links](#useful-links)

- **Dataset - Schema.org**
- **Dataset Structured Data - Google Search Central**
- **Google Dataset Search**

## [Required properties](#required-properties)

- **name** `string`The name of the dataset. This is a required field for valid Dataset structured data.
- **description** `string`A short summary describing the dataset. This is a required field for valid Dataset structured data.

## [Recommended Properties](#recommended-properties)

- **creator** `NodeRelations<Person | Organization | string>`The person or organization who created the dataset. Resolves to **Person** or **Organization**.
- **distribution** `NodeRelations<DataDownload>`Information about how to access/download the dataset.
- **temporalCoverage** `string`The time period the dataset covers (ISO 8601 format, e.g., "2020-01-01/2024-12-31").
- **spatialCoverage** `string`The geographic area the dataset covers.
- **keywords** `string[]`Keywords describing the dataset.
- **license** `string`URL or text specifying the dataset's license.

## [Defaults](#defaults)

- **@type**: `Dataset`
- **@id**: `${canonicalUrl}#dataset`
- **description**: `currentRouteMeta.description` _(see: **Schema.org Params**)_
- **url**: `currentRouteMeta.url` _(see: **Schema.org Params**)_
- **dateModified**: `currentRouteMeta.dateModified` _(see: **Schema.org Params**)_
- **datePublished**: `currentRouteMeta.datePublished` _(see: **Schema.org Params**)_

## [Examples](#examples)

### [Minimal](#minimal)

```
defineDataset({
  name: 'Global Temperature Data 2000-2024',
  description: 'Comprehensive global temperature measurements from weather stations worldwide',
})
```

### [Complete](#complete)

```
defineDataset({
  name: 'Global Temperature Data 2000-2024',
  description: 'Comprehensive global temperature measurements from weather stations worldwide, including daily readings and anomaly calculations',
  url: 'https://example.com/datasets/global-temp-2000-2024',
  creator: {
    name: 'Climate Research Institute',
    url: 'https://example.com/about',
  },
  datePublished: new Date(2024, 0, 1),
  dateModified: new Date(2024, 11, 1),
  version: '2.0',
  keywords: ['climate', 'temperature', 'weather', 'global warming'],
  license: 'https://creativecommons.org/licenses/by/4.0/',
  temporalCoverage: '2000-01-01/2024-12-31',
  spatialCoverage: 'Global',
  distribution: {
    contentUrl: 'https://example.com/downloads/global-temp-data.csv',
    encodingFormat: 'CSV',
    contentSize: '125 MB',
  },
  variableMeasured: ['temperature', 'humidity', 'pressure'],
  citation: 'Smith, J. et al. (2024). Global Temperature Dataset. Climate Research Institute.',
  isAccessibleForFree: true,
})
```

## [Types](#types)

```
export interface DataDownload extends Thing {
  '@type'?: 'DataDownload'
  'contentUrl'?: string
  'encodingFormat'?: string
  'contentSize'?: string
}

export interface DataCatalog extends Thing {
  '@type'?: 'DataCatalog'
  'name'?: string
  'url'?: string
}

export interface DatasetSimple extends Thing {
  '@type'?: Arrayable<'Dataset'>
  'name': string
  'description': string
  'url'?: string
  'keywords'?: string[]
  'creator'?: NodeRelations<Identity>
  'citation'?: string | string[]
  'license'?: string
  'temporalCoverage'?: string
  'spatialCoverage'?: string
  'distribution'?: NodeRelations<DataDownload>
  'variableMeasured'?: string | string[]
  'includedInDataCatalog'?: NodeRelation<DataCatalog>
  'isAccessibleForFree'?: boolean
  'datePublished'?: ResolvableDate
  'dateModified'?: ResolvableDate
  'version'?: string | number
  'sameAs'?: string[]
  'identifier'?: string | string[]
}
```

## [Related Schemas](#related-schemas)

- **Organization** - Dataset publisher
- **Person** - Dataset creator

Edit this page

Markdown For LLMs

**Did this page help you? **

**Course Schema** Use defineCourse() to add Course structured data. Enable rich results for educational courses with provider, description, and course details. **Event Schema** Use defineEvent() to add Event structured data to your pages. Enable rich results for concerts, conferences, and meetups with dates, venues, and ticket info.

**On this page **

- [Schema.org Dataset](#schemaorg-dataset)
- [Useful Links](#useful-links)
- [Required properties](#required-properties)
- [Recommended Properties](#recommended-properties)
- [Defaults](#defaults)
- [Examples](#examples)
- [Types](#types)
- [Related Schemas](#related-schemas)