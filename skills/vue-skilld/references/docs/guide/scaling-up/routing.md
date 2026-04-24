# Routing {#routing}

## Client-Side vs. Server-Side Routing {#client-side-vs-server-side-routing}

Routing on the server side means the server is sending a response based on the URL path that the user is visiting. When we click on a link in a traditional server-rendered web app, the browser receives an HTML response from the server and reloads the entire page with the new HTML.

In a Single-Page Application (SPA), however, the client-side JavaScript can intercept the navigation, dynamically fetch new data, and update the current page without full page reloads. This typically results in a more snappy user experience, especially for use cases that are more like actual "applications", where the user is expected to perform many interactions over a long period of time.

In such SPAs, the "routing" is done on the client side, in the browser. A client-side router is responsible for managing the application's rendered view using browser APIs such as History API or the `hashchange` event.

## Official Router {#official-router}


<div>
  <VueSchoolLink href="https://vueschool.io/courses/vue-router-4-for-everyone" title="Free Vue Router Course">
    Watch a Free Video Course on Vue School
  </VueSchoolLink>
</div>

Vue is well-suited for building SPAs. For most SPAs, it's recommended to use the officially-supported Vue Router library. For more details, see Vue Router's documentation.

## Simple Routing from Scratch {#simple-routing-from-scratch}

If you only need very simple routing and do not wish to involve a full-featured router library, you can do so with [Dynamic Components](/guide/essentials/component-basics#dynamic-components) and update the current component state by listening to browser `hashchange` events or using the History API.

Here's a bare-bone example:

<div class="composition-api">

```vue
<script setup>
import { ref, computed } from 'vue'
import Home from './Home.vue'
import About from './About.vue'
import NotFound from './NotFound.vue'

const routes = {
  '/': Home,
  '/about': About
}

const currentPath = ref(window.location.hash)

window.addEventListener('hashchange', () => {
  currentPath.value = window.location.hash
})

const currentView = computed(() => {
  return routes[currentPath.value.slice(1) || '/'] || NotFound
})
</script>

<template>
  <a href="#/">Home</a> |
  <a href="#/about">About</a> |
  <a href="#/non-existent-path">Broken Link</a>
  <component :is="currentView" />
</template>
```


</div>

<div class="options-api">

```vue
<script>
import Home from './Home.vue'
import About from './About.vue'
import NotFound from './NotFound.vue'

const routes = {
  '/': Home,
  '/about': About
}

export default {
  data() {
    return {
      currentPath: window.location.hash
    }
  },
  computed: {
    currentView() {
      return routes[this.currentPath.slice(1) || '/'] || NotFound
    }
  },
  mounted() {
    window.addEventListener('hashchange', () => {
		  this.currentPath = window.location.hash
		})
  }
}
</script>

<template>
  <a href="#/">Home</a> |
  <a href="#/about">About</a> |
  <a href="#/non-existent-path">Broken Link</a>
  <component :is="currentView" />
</template>
```


</div>
