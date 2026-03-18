---
title: "Food Establishment Schema · Unhead"
meta:
  "og:description": "Use defineFoodEstablishment() to add Restaurant structured data. Display menu, reservations, and cuisine info in Google Maps and local search."
  "og:title": "Food Establishment Schema · Unhead"
  description: "Use defineFoodEstablishment() to add Restaurant structured data. Display menu, reservations, and cuisine info in Google Maps and local search."
---

**Schema**

# **Food Establishment Schema**

Copy for LLMs

## [Schema.org FoodEstablishment](#schemaorg-foodestablishment)

**Type**: `defineFoodEstablishment(input?: FoodEstablishment)`

Describes a food-related business.

## [Useful Links](#useful-links)

- **FoodEstablishment - Schema.org**

## [Required properties](#required-properties)

- **name** `string`The name of the business.
- **address** `AddressInput` - **PostalAddress**Physical postal address of the business.

## [Recommended Properties](#recommended-properties)

- **acceptsReservations** `string | boolean`Indicates whether a FoodEstablishment accepts reservations.
- **hasMenu** `string`URL of the menu.
- **openingHoursSpecification** `OpeningHoursInput[]` - **OpeningHoursSpecification**The specification for when the business is open.
- **servesCuisine** `string`The type of cuisine the restaurant serves.

### [Minimal Example](#minimal-example)

```
defineFoodEstablishment({
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

- **@type**: `FoodEstablishment`
- **@id**: `${canonicalHost}#identity`
- **url**: `${canonicalHost}`
- **currenciesAccepted**: `${options.defaultCurrency}` See **global options**

## [Sub-Types](#sub-types)

- `Bakery`
- `BarOrPub`
- `Brewery`
- `Dentist`
- `CafeOrCoffeeShop`
- `Distillery`
- `FastFoodRestaurant`
- `IceCreamShop`
- `Restaurant`
- `Winery`

## [Resolves](#resolves)

See **Global Resolves** for full context.

- `logo` will be resolved from a string into an ImageObject and added to `image`
- `@type` resolve: `Restaurant` -> `['Organization', 'LocalBusiness', 'FoodEstablishment', 'Restaurant']`
- `starRating` will be resolved as a **Rating**

## [Types](#types)

```
type ValidFoodEstablishmentSubTypes = 'Bakery'
  | 'BarOrPub'
  | 'Brewery'
  | 'Dentist'
  | 'CafeOrCoffeeShop'
  | 'Distillery'
  | 'FastFoodRestaurant'
  | 'IceCreamShop'
  | 'Restaurant'
  | 'Winery'

export interface FoodEstablishmentSimple extends Omit<LocalBusiness, '@type'> {
  '@type'?: ['Organization', 'LocalBusiness', 'FoodEstablishment'] | ['Organization', 'LocalBusiness', 'FoodEstablishment', ValidFoodEstablishmentSubTypes] | ValidFoodEstablishmentSubTypes
  /**
   * Indicates whether a FoodEstablishment accepts reservations.
   */
  'acceptsReservations'?: string | boolean
  /**
   * URL of the menu.
   */
  'hasMenu'?: string
  /**
   * Methods of payment accepted.
   */
  'paymentAccepted'?: string
  /**
   * The cuisine of the restaurant.
   */
  'servesCuisine'?: string
  /**
   * An official rating for a lodging business or food establishment
   */
  'starRating'?: NodeRelations<Rating>
}
```

## [Related Schemas](#related-schemas)

- **LocalBusiness** - Parent type
- **Organization** - Parent organization
- **Event** - Restaurant events

Edit this page

Markdown For LLMs

**Did this page help you? **

**Event Schema** Use defineEvent() to add Event structured data to your pages. Enable rich results for concerts, conferences, and meetups with dates, venues, and ticket info. **HowTo** Add HowTo structured data to your site with Unhead. Step-by-step JSON-LD examples, required properties, and Google rich result guidance.