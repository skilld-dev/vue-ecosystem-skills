# Named Routes

<VueSchoolLink
  href="https://vueschool.io/lessons/named-routes"
  title="Learn about the named routes"
/>

When creating a route, we can optionally give the route a `name`:


```js
const routes = [
  {
    path: '/user/:username',
    name: 'profile', // [!code highlight]
    component: User,
  },
]
```

We can then use the `name` instead of the `path` when passing the `to` prop to `<router-link>`:

```vue-html
<router-link :to="{ name: 'profile', params: { username: 'erina' } }">
  User profile
</router-link>
```

The example above would create a link to `/user/erina`.


Using a `name` has various advantages:

- No hardcoded URLs.
- Automatic encoding of `params`.
- Avoids URL typos.
- Bypassing path ranking, e.g. to display a lower-ranked route that matches the same path.

<RuleKitLink />

Each name **must be unique** across all routes. If you add the same name to multiple routes, the router will only keep the last one. You can read more about this [in the Dynamic Routing](../advanced/dynamic-routing#Removing-routes) section.

There are various other parts of Vue Router that can be passed a location, e.g. the methods `router.push()` and `router.replace()`. We'll go into more detail about those methods in the guide to [programmatic navigation](./navigation). Just like the `to` prop, these methods also support passing a location by `name`:

```js
router.push({ name: 'profile', params: { username: 'erina' } })
```
