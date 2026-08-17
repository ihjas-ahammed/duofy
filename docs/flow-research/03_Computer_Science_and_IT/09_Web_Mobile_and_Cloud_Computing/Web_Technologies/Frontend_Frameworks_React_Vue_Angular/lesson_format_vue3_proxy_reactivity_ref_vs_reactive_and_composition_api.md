# Duofy Reusable Lesson Format: Vue 3 Reactivity (Proxy, Ref vs Reactive, and Composition API)

**Target Topic:** `03_Computer_Science_and_IT / 09_Web_Mobile_and_Cloud_Computing / Web_Technologies / Frontend_Frameworks_React_Vue_Angular`  
**Lesson Format Type:** `vue3_proxy_reactivity_ref_vs_reactive_and_composition_api`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through Proxy-based reactive tracking, fine-grained dependency graphs, and composable business logic in Vue.js 3 (Evan You *Vue 3 Reactivity System Architecture*; Vuejs.org Design Principles): master the internal **Dependency Tracking Engine ($\mathbf{\texttt{track()}}$ and $\mathbf{\texttt{trigger()}}$)** (using ECMAScript `Proxy` getters to collect active side-effects into `targetMap -> depsMap -> dep Set` via `track()`, and Proxy setters to schedule re-runs of affected effects via `trigger()`), rigorously contrast **`ref()`** (wrapping primitive values in `{ value: T }` accessor objects with reactive `.value` getters/setters) vs **`reactive()`** (creating deep Proxy wrappers on JavaScript objects), master the **Composition API (`<script setup>`, `computed`, `watchEffect`)**, and analyze why Vue 3 eliminates Vue 2's `Object.defineProperty` limitations (e.g. inability to detect dynamically added properties or array index mutations).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Vue 3 Proxy Dependency Graph Diagram (`track()` get vs `trigger()` set) & Ref vs Reactive Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Dependency Tracking and Re-execution Flow During a Reactive Mutation in Vue 3 Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Vue 3 Reactivity Primitive / API (`ref`, `reactive`, `computed`, `watchEffect`) Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In Vue 3, the Reactivity Primitive Used to Wrap Primitive Data Types with a .value Property Is ___ (ref) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Architectural Contrast: Why Vue 3's Proxy Reactivity Surpasses Vue 2's Object.defineProperty Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Vue 3 Reactivity (Evan You 2020):
   - **The Proxy Reactivity Engine Formulation:**
     $$\mathbf{\text{Target Map: } \text{WeakMap}\langle \text{Target Object}, \ \text{Map}\langle \text{Key}, \ \text{Set}\langle \text{ReactiveEffect} \rangle \rangle \rangle}$$
     - **Property Read (`get` trap):** Calls $\mathbf{\texttt{track(target, key)}} \implies$ registers currently active `activeEffect` into the key's dependency `Set`.
     - **Property Write (`set` trap):** Calls $\mathbf{\texttt{trigger(target, key)}} \implies$ iterates over dependency `Set` and executes all subscribed `effect.run()`.
   - **`ref()` vs `reactive()` Comparison:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{API Primitive} & \textbf{Supported Data Types} & \textbf{Access Syntax} & \textbf{Destructuring Safe?} \\
     \hline
     \mathbf{\texttt{ref(x)}} & \text{Primitives (number, string) + Objects} & \mathbf{\texttt{val.value} \text{ (auto-unwrapped in template)}} & \mathbf{\text{YES (via refs)}} \\
     \mathbf{\texttt{reactive(obj)}} & \text{Objects, Arrays, Collections ONLY} & \texttt{obj.prop} & \mathbf{\text{NO (loses reactivity on destructure!)}} \\
     \hline
     \end{array}$$
2. **Slide 2 (`ordering`):** Provide 5 steps of Vue 3 reactive mutation: (1) component executes `computed(() => count.value * 2)` inside `<script setup>`, (2) computed getter runs and accesses `count.value`, triggering `track(count, 'value')` which saves the computed effect in count's dep set, (3) user event executes `count.value++`, invoking the Proxy setter trap on count, (4) setter calls `trigger(count, 'value')` which iterates through all registered dependencies, (5) the computed effect re-runs and surgical template DOM update patches the screen without diffing unchanged components!
3. **Slide 3 (`matching`):** Pair 4 concepts (`ref()`, `reactive()`, `computed()`, `watchEffect()`) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of `ref`. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on Vue 3 Proxy vs Vue 2 `Object.defineProperty`: Why does Vue 3's ES6 `Proxy` reactivity engine mathematically and architecturally outperform Vue 2's legacy `Object.defineProperty` implementation? (Vue 2 used `Object.defineProperty` to convert individual object keys into getter/setters upon initialization; **it required recursive full-object traversals at startup (slow initial load) and could NOT detect dynamically added new properties (`obj.newProp = 123`), deleted properties, or direct array index assignments (`arr[0] = 5`), requiring awkward hacks like `Vue.set()`; Vue 3's `Proxy` wraps the entire object natively at the engine level, lazily intercepting ALL property additions, deletions, and array index mutations dynamically with zero startup overhead**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "vue3_proxy_reactivity_ref_vs_reactive_and_composition_api",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Vue 3 Proxy-Based Reactivity Engine (Evan You 2020)**\n• **Dependency Tracking \\& Trigger Topology:**\n$$\n\\mathbf{\\text{TargetMap: } \\text{WeakMap}\\langle \\text{TargetObject}, \\ \\text{Map}\\langle \\text{Key}, \\ \\text{Set}\\langle \\text{ReactiveEffect} \\rangle \\rangle \\rangle}\n$$\n• **The Two Reactivity Phases:**\n  - **Track (GET trap):** $\\mathbf{\\texttt{track(target, key)}} \\implies$ Subscribes currently running $\\mathbf{\\texttt{activeEffect}}$ to property's dependency Set!\n  - **Trigger (SET trap):** $\\mathbf{\\texttt{trigger(target, key)}} \\implies$ Notifies and executes all subscribed effects in dependency Set!\n• **Ref vs Reactive Taxonomy Matrix:**\n$$\n\\begin{array}{|l|l|l|l|}\n\\hline\n\\textbf{Primitive} & \\textbf{Accepted Types} & \\textbf{Access Syntax} & \\textbf{Destructuring Behavior} \\\\\n\\hline\n\\mathbf{\\texttt{ref(x)}} & \\text{Primitives, Booleans, Objects} & \\mathbf{\\texttt{count.value}} & \\mathbf{\\text{Preserves reactivity (use toRefs)}} \\\\\n\\mathbf{\\texttt{reactive(obj)}} & \\text{Objects \\& Arrays ONLY} & \\texttt{state.count} & \\mathbf{\\text{LOSES reactivity on destructuring!}} \\\\\n\\hline\n\\end{array}\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed when a reactive state mutation triggers a computed property recalculation in Vue 3.",
      "orderItems": [
        "A computed property (double = computed(() => count.value * 2)) is evaluated during initial component setup",
        "Reading count.value activates the Proxy 'get' trap, invoking track() to register the computed effect in count's dependency Set",
        "A user click handler executes count.value++, invoking the Proxy 'set' trap on the reactive state",
        "The 'set' trap calls trigger(), looking up count in targetMap and enqueueing all subscribed effects for execution",
        "The computed effect re-runs, recalculates the multiplied value, and triggers a surgical patch to the component DOM"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Vue 3 Composition API Primitive to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "ref()", "right": "Wraps an inner primitive value in a reactive object exposing getters/setters on .value" },
        { "left": "reactive()", "right": "Returns a deep Proxy of an object to intercept property reads and writes directly" },
        { "left": "computed()", "right": "Returns a read-only reactive ref that lazily caches its return value based on dependencies" },
        { "left": "watchEffect()", "right": "Runs a side-effect function immediately and automatically re-executes whenever accessed dependencies mutate" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In Vue 3, the reactivity primitive used to wrap primitive values with a .value property is ___.",
      "blankAnswer": "ref",
      "blankDistractors": ["reactive", "computed", "watch"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does Vue 3's Proxy-based reactivity engine fundamentally outperform and eliminate the major architectural limitations of Vue 2's Object.defineProperty implementation?",
      "options": [
        { "text": "Vue 2 used Object.defineProperty to convert each existing object property into getters/setters upon component initialization, requiring expensive recursive object traversal at startup and making it completely blind to dynamically added new properties (obj.newProp = 123), deleted properties, or direct array index mutations (arr[0] = 5), requiring cumbersome workarounds like Vue.set(); Vue 3's Proxy intercepts all operations at the object level natively in JavaScript, lazily wrapping nested properties on demand and seamlessly tracking dynamic property additions, deletions, and array index mutations with zero startup performance tax", "isCorrect": true, "explanation": "Correct! This is Evan You's central architectural upgrade from Vue 2 to Vue 3 (*Vue 3 Design Principles*). 1. **The Vue 2 Limitation (Object.defineProperty):** - In Vue 2: When an object was passed to `data`: Vue recursively walked every key with `Object.keys()` to attach `get` and `set`. - If an object had 10,000 items: Initial load was **crawlingly slow**! - Worse: If you wrote `user.newAddress = 'Paris'`, Vue 2 could not see it! You had to write `Vue.set(user, 'newAddress', 'Paris')`. - If you wrote `items[0] = 'newVal'`, Vue 2 could not detect array index mutations! 2. **The Vue 3 Proxy Revolution:** - Vue 3 passes the object to `new Proxy(target, { get, set, deleteProperty })`. - The initial wrap takes **$0\\text{ milliseconds}$** (zero recursive loops). - If you add `user.newAddress = 'Paris'`: The Proxy `set` trap fires instantly and updates the UI! - If you write `items[0] = 'newVal'`: The Proxy detects array index changes natively! 3. **The Result:** Faster startup, significantly lower memory usage, and $100\\%$ transparent reactivity!" },
        { "text": "Because Vue 2 was written in Java while Vue 3 is written in Python", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Proxy objects are executed exclusively on GPU graphics cards", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Vue 3 prohibits the use of arrays and objects", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
