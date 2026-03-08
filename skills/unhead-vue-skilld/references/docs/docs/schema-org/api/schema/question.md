---
title: "Question Schema · Unhead"
meta:
  "og:description": "Use defineQuestion() to add FAQ structured data. Enable FAQ rich snippets with expandable Q&A directly in Google search results."
  "og:title": "Question Schema · Unhead"
  description: "Use defineQuestion() to add FAQ structured data. Enable FAQ rich snippets with expandable Q&A directly in Google search results."
---

**Schema**

# **Question Schema**

Copy for LLMs

**On this page **

- [Schema.org Question](#schemaorg-question)
- [Useful Links](#useful-links)
- [Required properties](#required-properties)
- [Examples](#examples)
- [Defaults](#defaults)
- [Resolves](#resolves)
- [Relation Transforms](#relation-transforms)
- [Types](#types)
- [Related Schemas](#related-schemas)

## [Schema.org Question](#schemaorg-question)

- **Type**: `defineQuestion(input?: Question)`Describes an individual question. Most commonly used for creating an FAQ type page.

## [Useful Links](#useful-links)

- **Schema.org Question**
- **Recipe: FAQ**

## [Required properties](#required-properties)

- **name** `string`The text content of the question.
- **acceptedAnswer** `string|Answer`The text content of the answer.

## [Examples](#examples)

### [Minimal](#minimal)

```
defineQuestion({
  name: 'What is the meaning of life?',
  acceptedAnswer: '42',
})
```

## [Defaults](#defaults)

- **@type**: `Question`
- **@id**: `${canonicalUrl}#/schema/question/${questionId}`
- **inLanguage**: `options.defaultLanguage` _(see: **user Config**)_

## [Resolves](#resolves)

See **Global Resolves** for full context.

- will convert a string answer to an **Answer** object.
- `@id` is resolved using a hash of the question name if not provided

## [Relation Transforms](#relation-transforms)

**WebPage**

- Each question will append an entry on to `mainEntity`

## [Types](#types)

```
/**
 * A specific question - e.g. from a user seeking answers online, or collected in a Frequently Asked Questions (FAQ) document.
 */
export interface QuestionSimple extends Thing {
  /**
   * The text content of the question.
   */
  name: string
  /**
   * An answer object, with a text property which contains the answer to the question.
   */
  acceptedAnswer: NodeRelation<Answer | string>
  /**
   * The language code for the question; e.g., en-GB.
   */
  inLanguage?: string
  /**
   * The number of answers provided for this question.
   */
  answerCount?: number
  /**
   * The date and time the question was created.
   */
  dateCreated?: string
  /**
   * Alias for \`name\`
   */
  question?: string
  /**
   * Alias for \`acceptedAnswer\`
   */
  answer?: string
}

/**
 * An answer offered to a question; perhaps correct, perhaps opinionated or wrong.
 */
export interface Answer extends Optional<Thing, '@id'> {
  text: string
}
```

## [Related Schemas](#related-schemas)

- **Person** - Question author
- **Article** - Related article

Edit this page

Markdown For LLMs

**Did this page help you? **

**Product Schema** Use defineProduct() to add Product structured data for e-commerce. Enable rich snippets with pricing, reviews, and availability in Google search results. **Recipe Schema** Use defineRecipe() to add Recipe structured data. Enable rich snippets with cooking time, ingredients, nutrition, and step-by-step instructions in search.

**On this page **

- [Schema.org Question](#schemaorg-question)
- [Useful Links](#useful-links)
- [Required properties](#required-properties)
- [Examples](#examples)
- [Defaults](#defaults)
- [Resolves](#resolves)
- [Relation Transforms](#relation-transforms)
- [Types](#types)
- [Related Schemas](#related-schemas)