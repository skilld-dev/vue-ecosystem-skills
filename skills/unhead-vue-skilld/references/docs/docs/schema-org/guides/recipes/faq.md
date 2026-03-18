---
title: "FAQ · Unhead"
meta:
  "og:description": "Add FAQPage structured data with defineQuestion(). Enable expandable Q&A rich snippets directly in Google search results."
  "og:title": "FAQ · Unhead"
  description: "Add FAQPage structured data with defineQuestion(). Enable expandable Q&A rich snippets directly in Google search results."
---

**Recipes**

# **FAQ**

Copy for LLMs

Use `defineQuestion()` with `defineWebPage({ '@type': 'FAQPage' })` to mark up FAQ content. Google can display your questions and answers directly in search results as expandable rich snippets.

FAQ structured data enables rich results where users can see and expand your Q&A directly in Google search, increasing visibility and click-through rates.

## [Useful Links](#useful-links)

- **defineQuestion**
- **FAQ Page | Google Search Central**
- **Question Schema | Yoast**

## [How do I mark up FAQs?](#how-do-i-mark-up-faqs)

**defineQuestion** creates Question Schema whilst handling relations for you.

Note: When using a page with the path `/faq`, the page type will be automatically set for you.

Tips:

- The answer may contain HTML content such as links and lists.

```
import { defineQuestion, defineWebPage, useSchemaOrg } from '@unhead/schema-org/typescript'

useSchemaOrg([
  defineWebPage({
    '@type': 'FAQPage',
  }),
  defineQuestion({
    name: 'How long is a piece of string?',
    acceptedAnswer: 'The length of a piece of string is the number of characters in the string.',
  }),
  defineQuestion({
    name: 'How big is a giraffe?',
    acceptedAnswer: 'A giraffe is 12 feet tall',
  }),
])
```

## [How should I structure FAQ content in HTML?](#how-should-i-structure-faq-content-in-html)

For the best user experience, it's good to structure your FAQ content in a way that matches your schema markup:

```
<div>
  <h1>Frequently Asked Questions</h1>

  <div>
    <h2>How long is a piece of string?</h2>
    <div>The length of a piece of string is the number of characters in the string.</div>
  </div>

  <div>
    <h2>How big is a giraffe?</h2>
    <div>A giraffe is 12 feet tall</div>
  </div>

  <div>
    <h2>What is quantum mechanics?</h2>
    <div>
      <p>Quantum mechanics is the study of the nature of matter.</p>
      <p>It is the study of the nature of the interaction between particles and the nature of the universe.</p>
      <p>Particles are the smallest particles in the universe.</p>
      <p>The universe is made up of particles.</p>
      <p>Particles are made up of matter.</p>
      <p>Matter is made up of energy.</p>
    </div>
  </div>
</div>
```

## [Can I use HTML in FAQ answers?](#can-i-use-html-in-faq-answers)

You can include HTML content in your answers to provide a richer experience:

```
import { defineQuestion, defineWebPage, useSchemaOrg } from '@unhead/schema-org/typescript'

useSchemaOrg([
  defineWebPage({
    '@type': 'FAQPage',
  }),
  defineQuestion({
    name: 'What is quantum mechanics?',
    acceptedAnswer: \`
      <p>Quantum mechanics is the study of the nature of matter.</p>
      <p>It is the study of the nature of the interaction between particles and the nature of the universe.</p>
      <p>Particles are the smallest particles in the universe.</p>
      <p>The universe is made up of particles.</p>
      <p>Particles are made up of matter.</p>
      <p>Matter is made up of energy.</p>
    \`,
  }),
])
```

## [Expected JSON-LD Output](#expected-json-ld-output)

```
{
  "@context": "https://schema.org",
  "@graph": [
    {
      "@type": ["WebPage", "FAQPage"],
      "@id": "https://example.com/faq/",
      "name": "FAQ"
    },
    {
      "@type": "Question",
      "name": "How long is a piece of string?",
      "acceptedAnswer": {
        "@type": "Answer",
        "text": "The length of a piece of string is the number of characters."
      }
    }
  ]
}
```

## [Common Issues](#common-issues)

### [FAQ not showing in search results](#faq-not-showing-in-search-results)

Google only shows FAQ rich results for authoritative, high-quality content. Ensure your site has good E-E-A-T signals.

### [Questions not appearing](#questions-not-appearing)

You must include both `defineWebPage({ '@type': 'FAQPage' })` AND `defineQuestion()` calls.

### [HTML in answers stripped](#html-in-answers-stripped)

Only basic HTML (links, lists, paragraphs) is supported. Complex HTML may be sanitized.

## [Related Recipes](#related-recipes)

- **Setting Up Your Identity** - Define your organization/person
- **How-To Guide** - Step-by-step instructions

Edit this page

Markdown For LLMs

**Did this page help you? **

**eCommerce** Add Product structured data with defineProduct(). Enable rich results with prices, ratings, stock status, and reviews in search. **How To** Add HowTo structured data with defineHowTo(). Enable step-by-step rich snippets with images, supplies, and time estimates.