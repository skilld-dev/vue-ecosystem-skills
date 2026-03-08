---
title: "Course Schema · Unhead"
meta:
  "og:description": "Use defineCourse() to add Course structured data. Enable rich results for educational courses with provider, description, and course details."
  "og:title": "Course Schema · Unhead"
  description: "Use defineCourse() to add Course structured data. Enable rich results for educational courses with provider, description, and course details."
---

**Schema**

# **Course Schema**

Copy for LLMs

**On this page **

- [Schema.org Course](#schemaorg-course)
- [Useful Links](#useful-links)
- [Examples](#examples)
- [Types](#types)
- [Related Schemas](#related-schemas)

## [Schema.org Course](#schemaorg-course)

- **Type**: `defineCourse(input?: Course)`Describes a Course.

## [Useful Links](#useful-links)

- **Schema.org Course**
- **Course Schema Markup - Google Search Central**

 Documentation in progress

## [Examples](#examples)

```
defineCourse({
  name: 'Introduction to Computer Science and Programming',
  description: 'Introductory CS course laying out the basics.',
  provider: {
    name: 'University of Technology - Eureka',
    sameAs: 'http://www.ut-eureka.edu',
  },
})
```

## [Types](#types)

```
/**
 * A course or class offered by an educational institution.
 */
export interface CourseSimple extends Thing {
  /**
   * The title of the course.
   */
  name: string
  /**
   * A description of the course. Display limit of 60 characters.
   */
  description?: string
  /**
   * The course code or identifier.
   */
  courseCode?: string
  /**
   * The educational level of the course.
   */
  educationalLevel?: string
  /**
   * The duration of the course.
   */
  timeRequired?: string
  /**
   * A reference to an Organization piece, representing the organization offering the course.
   */
  provider?: NodeRelation<Organization>
}
```

 Schema in development

## [Related Schemas](#related-schemas)

- **Organization** - Course provider
- **Person** - Instructor
- **Event** - Course sessions

Edit this page

Markdown For LLMs

**Did this page help you? **

**Comment Schema** Use defineComment() to add Comment structured data. Connect user comments to articles and blog posts with author and date information. **Dataset Schema** Use defineDataset() to add Dataset structured data. Make research data discoverable in Google Dataset Search with metadata and download links.

**On this page **

- [Schema.org Course](#schemaorg-course)
- [Useful Links](#useful-links)
- [Examples](#examples)
- [Types](#types)
- [Related Schemas](#related-schemas)