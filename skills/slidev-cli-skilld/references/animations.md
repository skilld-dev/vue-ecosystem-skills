# Animations

Source: shipped skill references and https://sli.dev/guide/animations.

## Click animations

Directive:

```md
<div v-click>Appears on click</div>
<div v-after>Appears with the element above</div>
```

Component for lists (nested with `depth`):

```md
<v-clicks>

- Item 1
- Item 2
  - Sub (with depth="2")
- Item 3

</v-clicks>
```

Switch between states:

```md
<v-switch>
  <template #1>First state</template>
  <template #2>Second state</template>
</v-switch>
```

### Click positioning

```md
<div v-click>Default: next click</div>
<div v-click="+1">One click later</div>
<div v-click="-1">Same click as previous</div>
<div v-click="3">Absolute: visible from click 3</div>
<div v-click="[2,5]">Visible only during clicks 2-5</div>
```

### Click count control

Frontmatter `clicks: N` fixes the slide's total clicks; `clicksStart: N`
shifts the starting count. See [config.md](config.md).

## Motion

`v-motion` (powered by @vueuse/motion):

```md
<div
  v-motion
  :initial="{ x: -100, opacity: 0 }"
  :enter="{ x: 0, opacity: 1 }"
>Slides in</div>
```

Click-keyed:

```md
<div
  v-motion
  :initial="{ scale: 1 }"
  :click-1="{ scale: 1.5 }"
  :click-2="{ scale: 1 }"
>Scales on clicks</div>
```

## Slide transitions

Headmatter `transition:` sets the default; per-slide frontmatter overrides.

Built-ins: `fade`, `fade-out`, `slide-left`, `slide-right`, `slide-up`,
`slide-down`, `view-transition`.

Directional (forward | backward):

```yaml
---
transition: slide-left | slide-right
---
```

Custom: define `.my-transition-enter-active`, `.my-transition-leave-active`,
`.my-transition-enter-from`, `.my-transition-leave-to` CSS classes, then use
`transition: my-transition`.

## Click CSS classes

Animated elements receive: `.slidev-vclick-target`,
`.slidev-vclick-hidden`, `.slidev-vclick-current`, `.slidev-vclick-prior`.
Style them to customize reveal behavior.

## Rough markers

Hand-drawn annotations via `v-mark` (Rough Notation):

```md
<span v-mark.circle>Appears with default click</span>
<span v-mark.underline.red>Colored underline</span>
<span v-mark="{ at: 5, color: '#234', type: 'box' }">Explicit</span>
```

Types: `underline`, `circle`, `highlight`, `strike-through`, `box`.
Accepts click values like `v-click` (`v-mark="5"`, `v-mark="'+1'"`).

## Drawing mode

Draw on slides in presentation: press `C`. Configure in headmatter:

```yaml
---
drawings:
  enabled: true
  persist: false
  presenterOnly: false
  syncAll: true
---
```
