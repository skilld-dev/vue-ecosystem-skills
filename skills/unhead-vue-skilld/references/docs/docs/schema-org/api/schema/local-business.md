---
title: "LocalBusiness Schema - JSON-LD Guide & Examples · Unhead"
meta:
  "og:description": "Implement LocalBusiness structured data with Unhead. JSON-LD examples, required properties, subtypes (Dentist, Restaurant, Store), and Google rich result setup."
  "og:title": "LocalBusiness Schema - JSON-LD Guide & Examples · Unhead"
  description: "Implement LocalBusiness structured data with Unhead. JSON-LD examples, required properties, subtypes (Dentist, Restaurant, Store), and Google rich result setup."
---

**Schema**

# **LocalBusiness Schema - JSON-LD Guide & Examples**

Copy for LLMs

LocalBusiness schema tells search engines about a physical business location — its name, address, opening hours, and services. It powers Google's local business panels, Maps listings, and "near me" search results.

For better visibility, use a specific subtype like `Dentist`, `Restaurant`, or `ProfessionalService` rather than the generic `LocalBusiness` type.

### [JSON-LD Example](#json-ld-example)

```
{
  "@context": "https://schema.org",
  "@type": "LocalBusiness",
  "name": "Dave's Steak House",
  "address": {
    "@type": "PostalAddress",
    "streetAddress": "148 W 51st St",
    "addressLocality": "New York",
    "addressRegion": "NY",
    "postalCode": "10019",
    "addressCountry": "US"
  },
  "telephone": "+12122459600",
  "openingHoursSpecification": [
    {
      "@type": "OpeningHoursSpecification",
      "dayOfWeek": ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"],
      "opens": "11:30",
      "closes": "23:00"
    }
  ]
}
```

With Unhead, generate this using the `defineLocalBusiness()` composable — see the [**API reference**](#schema-org-localbusiness) below.

Use the **Schema.org Generator** to build your structured data visually.

## [Schema.org LocalBusiness](#schemaorg-localbusiness)

**Type**: `defineLocalBusiness(input?: LocalBusiness)`

Describes a business which allows public visitation. Typically used to represent the business 'behind' the website, or on a page about a specific business.

## [Useful Links](#useful-links)

- **LocalBusiness - Schema.org**
- **Local Business Schema Markup - Google Search Central**
- **LocalBusiness - Yoast**
- **Choose an Identity - Local Business**

## [Required properties](#required-properties)

- **name** `string`The name of the business.
- **address** `AddressInput` - **PostalAddress**Physical postal address of the business.

## [Recommended Properties](#recommended-properties)

- **openingHoursSpecification** `OpeningHoursInput[]` - **OpeningHoursSpecification**The specification for when the business is open.
- **paymentAccepted** `string`The methods of payment accepted by the business.

### [Minimal Example](#minimal-example)

```
defineLocalBusiness({
  name: 'test',
  logo: '/logo.png',
  address: {
    addressCountry: 'Australia',
    postalCode: '2000',
    streetAddress: '123 st',
  },
  openingHoursSpecification: [
    {
      dayOfWeek: 'Saturday',
      opens: '09:30',
      closes: '13:30',
    },
    {
      dayOfWeek: ['Monday', 'Tuesday'],
      opens: '10:30',
      closes: '15:30',
    },
  ]
})
```

## [Defaults](#defaults)

- **@type**: `['Organization', 'LocalBusiness']`
- **@id**: `${canonicalHost}#identity`
- **url**: `${canonicalHost}`
- **currenciesAccepted**: `${options.defaultCurrency}` See **global options**

## [Sub-Types](#sub-types)

- `AnimalShelter`
- `ArchiveOrganization`
- `AutomotiveBusiness`
- `ChildCare`
- `Dentist`
- `DryCleaningOrLaundry`
- `EmergencyService`
- `EmploymentAgency`
- `EntertainmentBusiness`
- `FinancialService`
- `FoodEstablishment`
- `GovernmentOffice`
- `HealthAndBeautyBusiness`
- `HomeAndConstructionBusiness`
- `InternetCafe`
- `LegalService`
- `Library`
- `LodgingBusiness`
- `MedicalBusiness`
- `ProfessionalService`
- `RadioStation`
- `RealEstateAgent`
- `RecyclingCenter`
- `SelfStorage`
- `ShoppingCenter`
- `SportsActivityLocation`
- `Store`
- `TelevisionStation`
- `TouristInformationCenter`
- `TravelAgency`

## [Resolves](#resolves)

See **Global Resolves** for full context.

- `logo` will be resolved from a string into an ImageObject and added to `image`
- `@type` resolve: `Dentist` -> `['Organization', 'LocalBusiness', 'Dentist']`

## [Types](#types)

```
type ValidLocalBusinessSubTypes = 'AnimalShelter'
  | 'ArchiveOrganization'
  | 'AutomotiveBusiness'
  | 'ChildCare'
  | 'Dentist'
  | 'DryCleaningOrLaundry'
  | 'EmergencyService'
  | 'EmploymentAgency'
  | 'EntertainmentBusiness'
  | 'FinancialService'
  | 'FoodEstablishment'
  | 'GovernmentOffice'
  | 'HealthAndBeautyBusiness'
  | 'HomeAndConstructionBusiness'
  | 'InternetCafe'
  | 'LegalService'
  | 'Library'
  | 'LodgingBusiness'
  | 'MedicalBusiness'
  | 'ProfessionalService'
  | 'RadioStation'
  | 'RealEstateAgent'
  | 'RecyclingCenter'
  | 'SelfStorage'
  | 'ShoppingCenter'
  | 'SportsActivityLocation'
  | 'Store'
  | 'TelevisionStation'
  | 'TouristInformationCenter'
  | 'TravelAgency'

export interface LocalBusinessSimple extends Organization {
  '@type'?: ['Organization', 'LocalBusiness'] | ['Organization', 'LocalBusiness', ValidLocalBusinessSubTypes] | ValidLocalBusinessSubTypes
  /**
   * The primary public telephone number of the business.
   */
  'telephone'?: string
  /**
   * The primary public email address of the business.
   */
  'email'?: string
  /**
   * The primary public fax number of the business.
   */
  'faxNumber'?: string
  /**
   * The price range of the business, represented by a string of dollar symbols (e.g., $, $$, or $$$ ).
   */
  'priceRange'?: string
  /**
   * An array of GeoShape, Place or string definitions.
   */
  'areaServed'?: unknown
  /**
   * A GeoCoordinates object.
   */
  'geo'?: unknown
  /**
   * The VAT ID of the business.
   */
  'vatID'?: string
  /**
   * The tax ID of the business.
   */
  'taxID'?: string
  /**
   * The currency accepted.
   */
  'currenciesAccepted'?: string
  /**
   * The methods of payment accepted by the business.
   */
  'paymentAccepted'?: string
  /**
   * The operating hours of the business.
   */
  'openingHoursSpecification'?: NodeRelations<OpeningHoursSpecification>
}
```

## [Related Schemas](#related-schemas)

- **Organization** - Parent organization
- **Event** - Business events
- **Product** - Products/services offered

Edit this page

Markdown For LLMs

**Did this page help you? **

**JobPosting** Implement JobPosting structured data with Unhead. JSON-LD examples, required fields for Google Jobs, salary markup, and validation tips. **Movie Schema** Use defineMovie() to add Movie structured data. Enable rich results with ratings, cast, director, and release date in Google search.