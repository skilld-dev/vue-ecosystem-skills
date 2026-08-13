---
outline: deep
---



# Form Input Bindings {#form-input-bindings}

<div class="options-api">
  <VueSchoolLink href="https://vueschool.io/lessons/user-inputs-vue-devtools-in-vue-3" title="Free Lesson on User Inputs with Vue.js"/>
</div>

<div class="composition-api">
  <VueSchoolLink href="https://vueschool.io/lessons/vue-fundamentals-capi-user-inputs-in-vue" title="Free Lesson on User Inputs with Vue.js"/>
</div>

When dealing with forms on the frontend, we often need to sync the state of form input elements with corresponding state in JavaScript. It can be cumbersome to manually wire up value bindings and change event listeners:

```vue-html
<input
  :value="text"
  @input="event => text = event.target.value">
```

The `v-model` directive helps us simplify the above to:

```vue-html
<input v-model="text">
```

In addition, `v-model` can be used on inputs of different types, `<textarea>`, and `<select>` elements. It automatically expands to different DOM property and event pairs based on the element it is used on:

- `<input>` with text types and `<textarea>` elements use `value` property and `input` event;
- `<input type="checkbox">` and `<input type="radio">` use `checked` property and `change` event;
- `<select>` uses `value` as a prop and `change` as an event.

::: tip Note
`v-model` will ignore the initial `value`, `checked` or `selected` attributes found on any form elements. It will always treat the current bound JavaScript state as the source of truth. You should declare the initial value on the JavaScript side, using <span class="options-api">the [`data`](/api/options-state.html#data) option</span><span class="composition-api">[reactivity APIs](/api/reactivity-core.html#reactivity-api-core)</span>.
:::

## Basic Usage {#basic-usage}

### Text {#text}

```vue-html
<p>Message is: {{ message }}</p>
<input v-model="message" placeholder="edit me" />
```

<div class="demo">
  <p>Message is: {{ message }}</p>
  <input v-model="message" placeholder="edit me" />
</div>

<div class="composition-api">


</div>
<div class="options-api">


</div>

<span id="vmodel-ime-tip"></span>
::: tip Note
For languages that require an IME (Chinese, Japanese, Korean, etc.), you'll notice that `v-model` doesn't get updated during IME composition. If you want to respond to these updates as well, use your own `input` event listener and `value` binding instead of using `v-model`.
:::

### Multiline Text {#multiline-text}

```vue-html
<span>Multiline message is:</span>
<p style="white-space: pre-line;">{{ message }}</p>
<textarea v-model="message" placeholder="add multiple lines"></textarea>
```

<div class="demo">
  <span>Multiline message is:</span>
  <p style="white-space: pre-line;">{{ multilineText }}</p>
  <textarea v-model="multilineText" placeholder="add multiple lines"></textarea>
</div>

<div class="composition-api">


</div>
<div class="options-api">


</div>

Note that interpolation inside `<textarea>` won't work. Use `v-model` instead.

```vue-html
<!-- bad -->
<textarea>{{ text }}</textarea>

<!-- good -->
<textarea v-model="text"></textarea>
```

### Checkbox {#checkbox}

Single checkbox, boolean value:

```vue-html
<input type="checkbox" id="checkbox" v-model="checked" />
<label for="checkbox">{{ checked }}</label>
```

<div class="demo">
  <input type="checkbox" id="checkbox-demo" v-model="checked" />
  <label for="checkbox-demo">{{ checked }}</label>
</div>

<div class="composition-api">


</div>
<div class="options-api">


</div>

We can also bind multiple checkboxes to the same array or Set value:

<div class="composition-api">

```js
const checkedNames = ref([])
```

</div>
<div class="options-api">

```js
export default {
  data() {
    return {
      checkedNames: []
    }
  }
}
```

</div>

```vue-html
<div>Checked names: {{ checkedNames }}</div>

<input type="checkbox" id="jack" value="Jack" v-model="checkedNames" />
<label for="jack">Jack</label>

<input type="checkbox" id="john" value="John" v-model="checkedNames" />
<label for="john">John</label>

<input type="checkbox" id="mike" value="Mike" v-model="checkedNames" />
<label for="mike">Mike</label>
```

<div class="demo">
  <div>Checked names: {{ checkedNames }}</div>

  <input type="checkbox" id="demo-jack" value="Jack" v-model="checkedNames" />
  <label for="demo-jack">Jack</label>

  <input type="checkbox" id="demo-john" value="John" v-model="checkedNames" />
  <label for="demo-john">John</label>

  <input type="checkbox" id="demo-mike" value="Mike" v-model="checkedNames" />
  <label for="demo-mike">Mike</label>
</div>

In this case, the `checkedNames` array will always contain the values from the currently checked boxes.

<div class="composition-api">


</div>
<div class="options-api">


</div>

### Radio {#radio}

```vue-html
<div>Picked: {{ picked }}</div>

<input type="radio" id="one" value="One" v-model="picked" />
<label for="one">One</label>

<input type="radio" id="two" value="Two" v-model="picked" />
<label for="two">Two</label>
```

<div class="demo">
  <div>Picked: {{ picked }}</div>

  <input type="radio" id="one" value="One" v-model="picked" />
  <label for="one">One</label>

  <input type="radio" id="two" value="Two" v-model="picked" />
  <label for="two">Two</label>
</div>

<div class="composition-api">


</div>
<div class="options-api">


</div>

### Select {#select}

Single select:

```vue-html
<div>Selected: {{ selected }}</div>

<select v-model="selected">
  <option disabled value="">Please select one</option>
  <option>A</option>
  <option>B</option>
  <option>C</option>
</select>
```

<div class="demo">
  <div>Selected: {{ selected }}</div>
  <select v-model="selected">
    <option disabled value="">Please select one</option>
    <option>A</option>
    <option>B</option>
    <option>C</option>
  </select>
</div>

<div class="composition-api">


</div>
<div class="options-api">


</div>

:::tip Note
If the initial value of your `v-model` expression does not match any of the options, the `<select>` element will render in an "unselected" state. On iOS this will cause the user not being able to select the first item because iOS does not fire a change event in this case. It is therefore recommended to provide a disabled option with an empty value, as demonstrated in the example above.
:::

Multiple select (bound to array):

```vue-html
<div>Selected: {{ selected }}</div>

<select v-model="selected" multiple>
  <option>A</option>
  <option>B</option>
  <option>C</option>
</select>
```

<div class="demo">
  <div>Selected: {{ multiSelected }}</div>

  <select v-model="multiSelected" multiple>
    <option>A</option>
    <option>B</option>
    <option>C</option>
  </select>
</div>

<div class="composition-api">


</div>
<div class="options-api">


</div>

Select options can be dynamically rendered with `v-for`:

<div class="composition-api">

```js
const selected = ref('A')

const options = ref([
  { text: 'One', value: 'A' },
  { text: 'Two', value: 'B' },
  { text: 'Three', value: 'C' }
])
```

</div>
<div class="options-api">

```js
export default {
  data() {
    return {
      selected: 'A',
      options: [
        { text: 'One', value: 'A' },
        { text: 'Two', value: 'B' },
        { text: 'Three', value: 'C' }
      ]
    }
  }
}
```

</div>

```vue-html
<div>Selected: {{ selected }}</div>

<select v-model="selected">
  <option v-for="option in options" :value="option.value">
    {{ option.text }}
  </option>
</select>
```
<div class="demo">
  <div>Selected: {{ dynamicSelected }}</div>
  
  <select v-model="dynamicSelected">
    <option v-for="option in options" :value="option.value">
      {{ option.text }}
    </option>
  </select>
</div>

<div class="composition-api">


</div>
<div class="options-api">


</div>

## Value Bindings {#value-bindings}

For radio, checkbox and select options, the `v-model` binding values are usually static strings (or booleans for checkbox):

```vue-html
<!-- `picked` is a string "a" when checked -->
<input type="radio" v-model="picked" value="a" />

<!-- `toggle` is either true or false -->
<input type="checkbox" v-model="toggle" />

<!-- `selected` is a string "abc" when the first option is selected -->
<select v-model="selected">
  <option value="abc">ABC</option>
</select>
```

But sometimes we may want to bind the value to a dynamic property on the current active instance. We can use `v-bind` to achieve that. In addition, using `v-bind` allows us to bind the input value to non-string values.

### Checkbox {#checkbox-1}

```vue-html
<input
  type="checkbox"
  v-model="toggle"
  true-value="yes"
  false-value="no" />
```

`true-value` and `false-value` are Vue-specific attributes that only work with `v-model`. Here the `toggle` property's value will be set to `'yes'` when the box is checked, and set to `'no'` when unchecked. You can also bind them to dynamic values using `v-bind`:

```vue-html
<input
  type="checkbox"
  v-model="toggle"
  :true-value="dynamicTrueValue"
  :false-value="dynamicFalseValue" />
```

:::tip Tip
The `true-value` and `false-value` attributes don't affect the input's `value` attribute, because browsers don't include unchecked boxes in form submissions. To guarantee that one of two values is submitted in a form (e.g. "yes" or "no"), use radio inputs instead.
:::

### Radio {#radio-1}

```vue-html
<input type="radio" v-model="pick" :value="first" />
<input type="radio" v-model="pick" :value="second" />
```

`pick` will be set to the value of `first` when the first radio input is checked, and set to the value of `second` when the second one is checked.

### Select Options {#select-options}

```vue-html
<select v-model="selected">
  <!-- inline object literal -->
  <option :value="{ number: 123 }">123</option>
</select>
```

`v-model` supports value bindings of non-string values as well! In the above example, when the option is selected, `selected` will be set to the object literal value of `{ number: 123 }`.

## Modifiers {#modifiers}

### `.lazy` {#lazy}

By default, `v-model` syncs the input with the data after each `input` event (with the exception of IME composition as [stated above](#vmodel-ime-tip)). You can add the `lazy` modifier to instead sync after `change` events:

```vue-html
<!-- synced after "change" instead of "input" -->
<input v-model.lazy="msg" />
```

### `.number` {#number}

If you want user input to be automatically typecast as a number, you can add the `number` modifier to your `v-model` managed inputs:

```vue-html
<input v-model.number="age" />
```

If the value cannot be parsed with `parseFloat()`, then the original (string) value is used instead. In particular, if the input is empty (for instance after the user clearing the input field), an empty string is returned. This behavior differs from the DOM property `valueAsNumber`. 

The `number` modifier is applied automatically if the input has `type="number"`.

### `.trim` {#trim}

If you want whitespace from user input to be trimmed automatically, you can add the `trim` modifier to your `v-model`-managed inputs:

```vue-html
<input v-model.trim="msg" />
```

## `v-model` with Components {#v-model-with-components}

> If you're not yet familiar with Vue's components, you can skip this for now.

HTML's built-in input types won't always meet your needs. Fortunately, Vue components allow you to build reusable inputs with completely customized behavior. These inputs even work with `v-model`! To learn more, read about [Usage with `v-model`](/guide/components/v-model) in the Components guide.
