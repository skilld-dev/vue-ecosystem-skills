---
number: 171
title: Unhead v1.1.28
category: General
created: 2023-07-01
url: "https://github.com/unjs/unhead/discussions/171"
upvotes: 1
comments: 3
answered: false
---

# Unhead v1.1.28

Hi i think that there's a little bug with new themeColor array feature because now by passing a string like this:

```
// to catch the first request in SSR
useServerSeoMeta({
  themeColor: () => theme.value?.hexPrimary,
  msapplicationTileColor: () => theme.value?.hexPrimary,
  ogLocale: () => useLocaleSanitizer(locale.value as CountryCode),
})

useSeoMeta({
  themeColor: () => theme.value?.hexPrimary,
  msapplicationTileColor: () => theme.value?.hexPrimary,
  ogLocale: () => useLocaleSanitizer(locale.value as CountryCode),
})
```

It creates an element like this:


---

## Top Comments

**@harlan-zw** [maintainer]:

Thanks! Have just pushed up a fix in `1.1.29`

**@LorenzoRottigni** (+1):

Hi, using v1.1.30 it works as expected, thanks :)

**@LorenzoRottigni**:

Thanks @harlan-zw ! 
For completeness i report you that to make it working i had to define it as:
themeColor: () => ({ content: theme.value?.hexPrimary }),
By using the example described in there https://github.com/unjs/unhead/releases/tag/v1.1.28: 
 [
    { content: 'cyan', media: '(prefers-color-scheme: light)' },
    { content: 'black', media: '(prefers-color-scheme: dark)' },
  ],
I had 2 meta tag theme-color in my HTML page, one reactive and one not. I suggest you to also check this.
I have to wait the new release of nuxt3 in order to integrate this fix right? Should I manually c...