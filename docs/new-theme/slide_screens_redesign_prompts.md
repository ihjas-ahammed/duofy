# Duofy Slide Screens Redesign & Image Generation Prompt Specification
## Comprehensive Screen-by-Screen Cognitive Overhaul & AI Prompt Matrix

> **Target Platform:** Duofy Mobile & Desktop Learning Applications  
> **Theoretical Framework:** Deliberate Practice (*PEAK*), Retrieval Dynamics (*Make It Stick*), Dual-Mode Cognition (*A Mind for Numbers*), Flow Psychology (*Csikszentmihalyi*), and Cognitive Load Theory (*Sweller & Mayer*).  
> **Output Formats:** Markdown (`.md`), Interactive HTML (`.html`), Publication PDF (`.pdf`)  
> **Purpose:** Detailed catalog of UI/UX transformations for all 18 slide screens with copy-pasteable image generation prompts for Midjourney v6, Flux Pro, Imagen 3, and DALL-E 3.

---

## Table of Contents
1. [Screen 01: Theory & Concept Introduction View (`theory` / `theory_group`)](#screen-01-theory--concept-introduction-view)
2. [Screen 02: Modular Concept Pieces View (`concept_pieces`)](#screen-02-modular-concept-pieces-view)
3. [Screen 03: Descriptive Reading & Deep Synthesis View (`descriptive`)](#screen-03-descriptive-reading--deep-synthesis-view)
4. [Screen 04: Interactive Proof & Step-by-Step Derivation View (`interactive_proof` / `step_by_step`)](#screen-04-interactive-proof--step-by-step-derivation-view)
5. [Screen 05: Active Retrieval Quiz View (`quiz`)](#screen-05-active-retrieval-quiz-view)
6. [Screen 06: Fill in the Blank & Code Synthesis View (`fill_in_blank`)](#screen-06-fill-in-the-blank--code-synthesis-view)
7. [Screen 07: Numerical Calculation & Precision Keypad View (`numerical`)](#screen-07-numerical-calculation--precision-keypad-view)
8. [Screen 08: One-Word Direct Recall View (`one_word` / `pyq_one_word`)](#screen-08-one-word-direct-recall-view)
9. [Screen 09: Conceptual Matching Pairs View (`matching`)](#screen-09-conceptual-matching-pairs-view)
10. [Screen 10: Chronological & Logic Ordering View (`ordering`)](#screen-10-chronological--logic-ordering-view)
11. [Screen 11: Spaced Repetition Flashcard View (`flashcard`)](#screen-11-spaced-repetition-flashcard-view)
12. [Screen 12: Program Construction & Logic Builder View (`program`)](#screen-12-program-construction--logic-builder-view)
13. [Screen 13: Live SeriousPython Code Runner & Sandbox View (`try_yourself` / `code_runner`)](#screen-13-live-seriouspython-code-runner--sandbox-view)
14. [Screen 14: Interactive HTML5 Canvas & Simulator View (`custom_html`)](#screen-14-interactive-html5-canvas--simulator-view)
15. [Screen 15: Error Spotting & Bug Hunting Diagnostic View (`error_spotting`)](#screen-15-error-spotting--bug-hunting-diagnostic-view)
16. [Screen 16: Lesson Header & Ambient Flow Chrome (Progress, Combo, Zen Mode)](#screen-16-lesson-header--ambient-flow-chrome)
17. [Screen 17: Bottom Action, Confidence Meter & Diagnostic Autopsy Tray](#screen-17-bottom-action-confidence-meter--diagnostic-autopsy-tray)
18. [Screen 18: Lesson Complete & Metacognitive Mastery Summary Screen (`lesson_complete_screen`)](#screen-18-lesson-complete--metacognitive-mastery-summary-screen)

---

### Screen 01: Theory & Concept Introduction View
**Slide Type ID:** `theory` / `theory_group`

#### 1. Current State & Purpose
Presents foundational theoretical concepts, definitions, formulas, and diagrams at the start of a lesson. Currently suffers from passive reading risks, large blocks of unchunked text, and disjointed canvas placement.

#### 2. Cognitive Science Deficiencies
- **Fluency Illusion (*Make It Stick*):** Learners smoothly skim text and overestimate understanding without forming active schemas.
- **Split-Attention Effect (Mayer & Sweller):** Canvas illustrations are often visually separated from the explanatory text, forcing working memory to juggle multiple locations.
- **Einstellung Rigidity (*A Mind for Numbers*):** Concepts are presented from a single rigid viewpoint without alternate perspectives.

#### 3. Required Redesign Changes
- **Modular Chunking:** Break text into visual concept cards with clear typographic hierarchy (`Space Grotesk` headings + `Plus Jakarta Sans` subheadings + `Newsreader` narrative).
- **Spatial Contiguity Integration:** Embed interactive canvas or SVG diagrams directly inline adjacent to formulas.
- **Pre-Activation Prompt:** Add an initial 1-sentence thought-experiment question at the top before the full theory unfolds.
- **Signaling Highlights:** Subtle amber/cobalt signposting on invariant terms in formulas (e.g., highlighting \(e\) and \(\pi\) in Euler's formula).

#### 4. Image Generation Prompt
```text
UI Design of a modern educational mobile app screen, "Theory & Concept Introduction" slide. Clean "Cognitive Sanctuary" light theme with soft off-white background #F8FAFC, elevated crisp white cards with rounded corners (16px radius) and subtle drop shadows. At top, a thin sleek progress bar (35% filled in vibrant royal blue #2563EB) and a minimalist flame combo badge. Main card features a bold lesson title "Euler's Identity & Rotational Phasors" in Space Grotesk font, followed by an inline interactive SVG complex plane unit circle diagram with glowing vector arrows. Below the diagram, an elegant LaTeX formula box with syntax-highlighted terms in cobalt blue and emerald green. Underneath, a concise 2-sentence concept chunk in Newsreader serif typography with high legibility. At the bottom, a full-width pill button "Continue to Active Practice" in solid royal blue with subtle hover glow. Minimalist, distraction-free, Apple Design Award quality, Figma UI mockup, 8k resolution, crisp vector graphics --ar 9:16
```

---

### Screen 02: Modular Concept Pieces View
**Slide Type ID:** `concept_pieces`

#### 1. Current State & Purpose
Deconstructs complex systems into modular atomic pieces (e.g., components of an engine, steps of a metabolic pathway, or layers of a network protocol).

#### 2. Cognitive Science Deficiencies
- **Working Memory Overload (CLT):** Displaying all pieces simultaneously exceeds the 4-item working memory capacity.
- **Lack of Deliberate Assembly (*PEAK*):** Users tap passively rather than predicting where each component connects.

#### 3. Required Redesign Changes
- **Progressive Unfolding:** Cards start in a collapsed "piece tray" at the bottom; tapping a piece dynamically illuminates its matching node on the central visual schematic.
- **Micro-Self-Testing:** Each piece reveals a 1-sentence functional explanation only when dragged or tapped.
- **Color-Coded Semantic Anchors:** Each piece receives a dedicated pastel chromatic token (Mint, Cobalt, Amber, Violet).

#### 4. Image Generation Prompt
```text
Mobile app UI design for "Modular Concept Pieces" learning screen in modern "Midnight Flow" dark mode theme. Deep nocturnal navy background #090D16 with dark glassmorphic cards #131D31. In the upper half, an interactive architectural diagram of a "Transformer Attention Mechanism" with glowing connected nodes and subtle dotted line paths. In the lower half, four modular horizontal pill cards labeled "Queries (Q)", "Keys (K)", "Values (V)", and "Softmax Scaling", each styled with glowing left border accents in emerald, sky blue, amber, and lavender. The "Queries" card is actively selected, casting a gentle neon blue aura. Sleek minimalist typography in Plus Jakarta Sans and JetBrains Mono. Bottom bar has a clean button "Assemble Schema". High-tech, futuristic yet clean pedagogical interface, Dribbble trending, 8k, UI/UX showcase --ar 9:16
```

---

### Screen 03: Descriptive Reading & Deep Synthesis View
**Slide Type ID:** `descriptive`

#### 1. Current State & Purpose
Long-form conceptual reading, historical context, literature excerpts, and deep philosophical derivations.

#### 2. Cognitive Science Deficiencies
- **Saccadic Eye Fatigue:** Long line lengths (>80 characters) strain visual tracking.
- **Passive Eye Glaze:** Learners scroll through paragraphs without retrieval checkpoints.

#### 3. Required Redesign Changes
- **60-Character Optimal Reading Column:** Narrow text measure styled in `Newsreader` serif with 1.75 line-height and generous margins.
- **Warm Codex (Sepia) Mode Palette:** Ivory background `#FFFDF9`, rich walnut text `#2C2416`, and warm amber highlights.
- **Active Margin Annotations:** Inset margin notes and key vocabulary definitions that expand without shifting layout.
- **Mid-Text Retrieval Stop:** A collapsible "Stop & Predict" card halfway through the reading.

#### 4. Image Generation Prompt
```text
Clean mobile UI design for "Descriptive Conceptual Reading" screen in "Warm Codex" sepia theme. Ivory parchment paper background #FFFDF9 with deep walnut text #2C2416. Elegant editorial typography using Newsreader serif font with 1.75 line height and perfect 65-character line length. The top header shows "Origins of Quantum Mechanics: The Ultraviolet Catastrophe" with a small sepia badge "Deep Synthesis • 4 min read". In the middle of the article, an inline pull-quote card with an antique iron-gall ink border and a small portrait illustration of Max Planck. At bottom of text, an interactive "Stop & Reflect" reflection callout box with a dashed golden ochre outline #D97706. Minimalist footer with reading progress tracker. Editorial magazine aesthetic, elegant, distraction-free, 8k --ar 9:16
```

---

### Screen 04: Interactive Proof & Step-by-Step Derivation View
**Slide Type ID:** `interactive_proof` / `step_by_step` / `proof`

#### 1. Current State & Purpose
Guides students through multi-step mathematical proofs, logic derivations, and algorithmic traces.

#### 2. Cognitive Science Deficiencies
- **Passive Proof Reading:** Showing all proof steps at once allows students to skip deductive justification.
- **Lack of Isolated Sub-Step Feedback (*PEAK*):** If step 3 fails, the user cannot easily isolate and practice that specific logical link.

#### 3. Required Redesign Changes
- **Accordion Step-by-Step Unrolling:** Only the current derivation step is active; subsequent steps are blurred/locked until the justification is verified.
- **Deductive Justification Dropdowns:** The user must select the mathematical theorem or algebraic axiom that justifies the transition from Step \(n\) to Step \(n+1\).
- **Interactive Visual Canvas Sync:** As each algebraic step is completed, the adjacent geometric canvas updates in real time (Dual Coding Principle).

#### 4. Image Generation Prompt
```text
Mobile app UI design for "Interactive Mathematical Proof" screen. Modern light theme #F8FAFC with sleek card containers. Main view showcases a step-by-step derivation for "Pythagorean Theorem via Vector Dot Products". Step 1 and Step 2 are completed, displayed in clean white cards with green checkmarks and crisp LaTeX equations. Step 3 is currently active, outlined with a bright royal blue border #2563EB: it shows an equation with a missing algebraic operator and an interactive pill selector for "Distributive Property", "Orthogonality Axiom", "Cauchy-Schwarz Inequality". Below the proof steps, an interactive SVG right-angle triangle diagram with live updating angle projections. Clean typography with JetBrains Mono for equations and Plus Jakarta Sans for UI. Premium STEM educational app, Figma UI, ultra-clean, 8k --ar 9:16
```

---

### Screen 05: Active Retrieval Quiz View
**Slide Type ID:** `quiz`

#### 1. Current State & Purpose
Multiple choice concept verification questions with 3-4 selectable options.

#### 2. Cognitive Science Deficiencies
- **Recognition over Recall (*Make It Stick*):** Multiple choice often tests superficial recognition rather than true generative recall.
- **Mindless Guessing:** Users rapidly tap options without cognitive commitment.

#### 3. Required Redesign Changes
- **"Active-First" Generation Scratchpad:** An optional scratchpad or mental prediction prompt appears *before* option selection is unlocked.
- **Pre-Answer Metacognitive Calibration:** 3-tier confidence indicator (1★ Guessing, 2★ Plausible, 3★ Absolute Certainty) required before checking.
- **Diagnostic Error Autopsy Tray:** Explains why the selected distractor is wrong, not just highlighting the correct choice in green.

#### 4. Image Generation Prompt
```text
Mobile app UI interface for "Active Retrieval Quiz" screen in "Cognitive Sanctuary" light theme. Clean off-white background #F8FAFC with high-contrast slate text #0F172A. Question card at top: "What happens to the margin of error in a confidence interval when sample size n is quadrupled?" Four elegant option cards with subtle borders: Option A, B, C, D. Option B ("It is halved") is actively selected with a crisp cobalt blue outline #2563EB and a soft light blue background tint. Above the submit button, a horizontal "Confidence Calibration" bar with 3 selectable star chips: "1★ Guessing", "2★ Fairly Sure", "3★ Certain". Bottom has a solid blue "Check Answer" pill button. Clean, modern typography in Plus Jakarta Sans, zero clutter, Duolingo meets Apple design, 8k --ar 9:16
```

---

### Screen 06: Fill in the Blank & Code Synthesis View
**Slide Type ID:** `fill_in_blank`

#### 1. Current State & Purpose
Cloze-style learning questions where students complete missing tokens in text, mathematical equations, or code snippets.

#### 2. Cognitive Science Deficiencies
- **Token Clutter:** Random scattered word chips create extraneous visual scanning load.
- **Lack of Desirable Difficulty:** Obvious distractor chips make the missing word trivially guessable.

#### 3. Required Redesign Changes
- **Integrated In-Line Drop Slots:** Slots are shaped exactly like the missing syntax or equation token with clean dotted borders.
- **Dual Input Modes:** Toggle between draggable word bank chips and direct keyboard text entry for advanced learners.
- **Contextual Syntax Highlighting:** If in code mode, the surrounding code block maintains full dark/light IDE styling (`JetBrains Mono`).

#### 4. Image Generation Prompt
```text
Mobile app UI design for "Fill in the Blank" code synthesis slide. Dark mode "Midnight Flow" theme with deep navy canvas #090D16. The center of the screen features a rounded code editor card #131D31 with syntax-highlighted Python code defining a binary search function. Inside the code, line 4 has a glowing empty slot with a cyan dashed outline for the midpoint calculation: `mid = left + [ _____ ]`. Below the code card, a horizontal bank of 4 draggable rounded chips: `(right - left) // 2`, `(right + left) / 2`, `right * 2`, `left // 2`. The first chip has a subtle glow effect. Sleek font pairing with JetBrains Mono and Plus Jakarta Sans. Smooth modern glassmorphic aesthetics, 8k resolution, UI design portfolio piece --ar 9:16
```

---

### Screen 07: Numerical Calculation & Precision Keypad View
**Slide Type ID:** `numerical`

#### 1. Current State & Purpose
Math and science calculation problems requiring precision numerical answers, decimal inputs, and units.

#### 2. Cognitive Science Deficiencies
- **System Keyboard Frustration:** The native phone alphanumeric keyboard obscures the problem text and formula.
- **Math Anxiety Trigger (*A Mind for Numbers*):** High stress caused by rigid error penalties for minor rounding discrepancies.

#### 3. Required Redesign Changes
- **Custom Built-in Scientific Math Keypad:** Integrated numbers `0-9`, decimal point, negative sign, fraction toggle `a/b`, and \(\pi\) / \(\sqrt{x}\) buttons that never cover the problem card.
- **Dynamic Tolerance Indicator:** Subtitle showing acceptable margin of error (e.g., "\(\pm 0.05\) tolerance").
- **Step-by-Step Scratchpad Drawer:** Swipe-up canvas for finger scratch calculations.

#### 4. Image Generation Prompt
```text
Mobile learning app UI design for "Numerical Calculation & Scientific Input" slide. Clean light mode with pure white cards and soft gray canvas #F8FAFC. Top card presents a physics problem: "Calculate the escape velocity from Mars (M = 6.42 x 10^23 kg, R = 3389 km) in km/s." Below the question, a large numerical input display showing `5.03` with a blinking royal blue cursor and unit tag `km/s`. Lower half of the screen features a dedicated custom scientific numerical keypad with large rounded soft-gray buttons: numbers 0-9, decimal point, negative sign, backspace, and square root symbol. Top-right of the screen has a small "Scratchpad" pen icon. Ultra-clean typography, Apple Calculator meets Brilliant.org aesthetic, 8k --ar 9:16
```

---

### Screen 08: One-Word Direct Recall View
**Slide Type ID:** `one_word` / `pyq_one_word`

#### 1. Current State & Purpose
Direct cued-recall testing for scientific definitions, medical terminology, and historical concepts.

#### 2. Cognitive Science Deficiencies
- **Spelling Friction:** Exact string matching causes unfair failures for minor typos.
- **Lack of Scaffolding (*PEAK*):** If totally blocked, users have no low-penalty pathway to unstuck their memory.

#### 3. Required Redesign Changes
- **Fuzzy Match & Phonetic Tolerance Engine:** Recognizes valid spelling variants while politely noting correct orthography.
- **Progressive Letter Reveal (Desirable Difficulty Ladder):** Users can tap "Reveal First Letter" for a minor score deduction rather than giving up.
- **Pronunciation & Etymology Card:** Post-answer drawer displays phonetic pronunciation and root word origin.

#### 4. Image Generation Prompt
```text
Mobile app UI design for "One-Word Exact Recall" screen in "Forest Zen" theme. Deep forest green nocturnal background #0A1918 with elevated moss-slate cards #122624. Question card displays: "Name the biological process where cells engulf large particles or whole microorganisms." In the center, an elegant single-line text input field with a mint-green glowing underline #10B981 showing the typed answer "Phagocytosis". Beneath the input, a small subtle button "💡 Reveal First Letter (P...)". Top right displays a green streak counter with a leaf icon. Bottom has a mint-colored "Submit Word" button. Calming, focused, non-anxiety-inducing educational UI, 8k --ar 9:16
```

---

### Screen 09: Conceptual Matching Pairs View
**Slide Type ID:** `matching`

#### 1. Current State & Purpose
Interactive 2-column interface where learners match terms with their corresponding definitions, formulas, or diagrams.

#### 2. Cognitive Science Deficiencies
- **Line Spaghetti Visual Clutter:** Drawing crisscrossing lines between columns quickly becomes illegible.
- **Working Memory Fragmentation:** Over 5 pairs at once causes cognitive overload.

#### 3. Required Redesign Changes
- **Tonal Color-Lock Pairing:** Tapping a left card and right card locks them in a matching soft pastel color pairing (no messy crisscross lines).
- **Max 4-Item Chunks:** Enforce a strict 4-pair maximum per slide to honor Cowan's working memory model.
- **Instant Micro-Haptic Confirmation:** Subtle haptic pulse upon correct pairing.

#### 4. Image Generation Prompt
```text
Mobile app UI design for "Matching Pairs" interactive learning slide in "Midnight Flow" dark theme #090D16. Two parallel columns of 4 rounded cards each. Left column displays Greek mythological archetypes: "Prometheus", "Sisyphus", "Icarus", "Daedalus". Right column displays core themes: "Endless Repetitive Struggle", "Hubris & Overreaching", "Forethought & Fire", "Mastery of Craft". "Prometheus" and "Forethought & Fire" are successfully matched, both highlighted with a shared glowing emerald green border #22C55E. "Icarus" is currently selected with a glowing sky blue border #60A5FA awaiting its pair. Minimalist, modern card UI, JetBrains Mono tags, Figma design showcase, 8k --ar 9:16
```

---

### Screen 10: Chronological & Logic Ordering View
**Slide Type ID:** `ordering`

#### 1. Current State & Purpose
Requires students to arrange a sequence of algorithm steps, historical milestones, or proof logic in proper chronological order.

#### 2. Cognitive Science Deficiencies
- **Cumbersome Drag Handles:** Small drag handles cause accidental mis-drops and frustrating UX friction.
- **Lack of Step Invariant Feedback:** When an order is wrong, it doesn't indicate *which* specific transition failed.

#### 3. Required Redesign Changes
- **Large Drag-and-Snap Cards:** Full-card touch targets with smooth vertical spring physics and haptic snapping.
- **Transition Arrow Indicators:** Dynamic vertical numbered connector lines `(1) -> (2) -> (3) -> (4)` between cards that highlight logical dependencies.
- **Partial Order Diagnostics:** Visual indicator showing which sub-sequences are correctly ordered even if the total array is not.

#### 4. Image Generation Prompt
```text
Mobile learning app UI design for "Sequence & Logic Ordering" slide. Clean "Cognitive Sanctuary" light theme with slate background #F8FAFC. Screen prompt: "Order the stages of the Mitosis cell cycle from start to finish." Four large draggable cards with vertical numbered badges on their left edges: (1) Prophase, (2) Metaphase, (3) Anaphase, (4) Telophase. Card (2) "Metaphase" is currently being dragged, slightly tilted with an elevated drop shadow and glowing blue border #2563EB. Vertical connecting line with soft downward arrows linking the cards together. Bottom pill button "Verify Sequence". High fidelity, crisp UI components, Apple iOS 18 design guidelines, 8k --ar 9:16
```

---

### Screen 11: Spaced Repetition Flashcard View
**Slide Type ID:** `flashcard`

#### 1. Current State & Purpose
Classic front/back flip card for active recall and Leitner/SuperMemo spaced repetition intervals.

#### 2. Cognitive Science Deficiencies
- **Passive Flipping:** Users flip the card immediately without spending 5-10 seconds in effortful mental retrieval.
- **Binary Self-Grading Anxiety:** Harsh "Pass/Fail" binary options discourage honest evaluation.

#### 3. Required Redesign Changes
- **Effort Timer & Delayed Flip:** Flip button encourages a 5-second mental generation pause before revealing the back.
- **4-Tier Metacognitive Grading:** Replacing binary Pass/Fail with: `Again (<10m)`, `Hard (1d)`, `Good (3d)`, `Easy (7d)`.
- **Memory Stability Indicator:** Small visual bar showing current memory retention half-life in days.

#### 4. Image Generation Prompt
```text
Mobile app UI interface for "Spaced Repetition 3D Flip Flashcard" slide. Modern dark theme #090D16 with soft gradient glow. Center card is an elevated 3D glassmorphic card #131D31 with a subtle perspective tilt: Front face shows "Dopamine D2 Receptor Agonists - Clinical Mechanism & Side Effects". A small flip icon in the top right. Bottom area displays 4 self-grading rating buttons in distinct colors: Red "Again (<10m)", Amber "Hard (1d)", Blue "Good (4d)", Emerald "Easy (10d)". Top header shows a spaced repetition queue counter "Card 14 / 25" and memory stability gauge (88% Retained). Clean typography, Plus Jakarta Sans, slick modern 3D UI card rendering, 8k --ar 9:16
```

---

### Screen 12: Program Construction & Logic Builder View
**Slide Type ID:** `program`

#### 1. Current State & Purpose
Teaches programming logic, variable scope, and control flow through structured interactive code puzzles.

#### 2. Cognitive Science Deficiencies
- **Syntax Overwhelm:** Beginners struggle with missing brackets, colons, and indentation rather than the conceptual algorithm.
- **Passive Reading of Code:** Looking at finished code gives false fluency without procedural muscle memory.

#### 3. Required Redesign Changes
- **Block-to-Text Hybrid Architecture:** Combines clean Python syntax highlighting with drag-and-drop code logic slots.
- **Real-Time AST Validation:** Instant feedback on indentation and variable binding without crashing the runtime.
- **Step-by-Step Execution Variable Inspector:** Small expandable tray showing variable values (`x=5`, `total=15`) updating per loop iteration.

#### 4. Image Generation Prompt
```text
Mobile UI design for "Program Construction & Coding Logic" slide in dark theme #090D16. Main view displays a sleek code editor window with macOS style top-left red/yellow/green window dots. Code contains an algorithm for "Calculate Fibonacci Sequence" with syntax highlighted keywords in violet #A78BFA, functions in blue #60A5FA, and strings in green #34D399. A missing loop condition line has a designated drop target. Below the editor, a code block tray with 3 formatted draggable code blocks: `for i in range(2, n):`, `while i <= n:`, `for i in list:`. On the bottom right, a small mini variable tracker box showing `prev=1, curr=1, next=2`. Modern developer education UI, JetBrains IDE aesthetic, 8k --ar 9:16
```

---

### Screen 13: Live SeriousPython Code Runner & Sandbox View
**Slide Type ID:** `try_yourself` / `code_runner`

#### 1. Current State & Purpose
A full interactive mobile Python coding environment running pure-Python NumPy, Matplotlib, and Scikit-learn scripts on-device.

#### 2. Cognitive Science Deficiencies
- **Mobile Keyboard Cramping:** Typing Python syntax on standard phone keyboards is painfully slow.
- **Detached Execution Console:** Console output is hidden in a separate tab, violating the spatial contiguity principle.

#### 3. Required Redesign Changes
- **Quick-Access Python Accessory Toolbar:** Floating keyboard toolbar with `( )`, `[ ]`, `:`, `=`, `->`, `def`, `return`, `print`, and 4-space tab indent key.
- **Split-Pane Live Terminal & Matplotlib Canvas:** Code on top (55%), live terminal output and auto-rendering Matplotlib charts on bottom (45%).
- **Interactive Reset & Solution Diff:** One-tap button to reset to starter code or view a side-by-side diff against the master solution.

#### 4. Image Generation Prompt
```text
Mobile app UI design for "Live Python Code Runner & Data Science Sandbox" screen in dark mode #090D16. Split view layout: Upper 55% contains an interactive code editor with JetBrains Mono font showing a NumPy matrix multiplication script with a runnable `import numpy as np` snippet. Directly above the phone keyboard, a sleek horizontal developer accessory bar with one-tap buttons: `( )`, `[ ]`, `:`, `tab`, `def`, `run`. Lower 45% shows a live terminal console output card #0F172A displaying the calculated output matrix and a crisp embedded Matplotlib scatter plot with red decision boundaries. A prominent circular green "Run Code ▶" floating action button. High-tech, developer-friendly educational app, 8k --ar 9:16
```

---

### Screen 14: Interactive HTML5 Canvas & Simulator View
**Slide Type ID:** `custom_html` / `interactive_webview`

#### 1. Current State & Purpose
Full-screen interactive webview simulators (e.g., physics pendulum, projectile trajectories, logic gate circuit builders, neural net visualizers).

#### 2. Cognitive Science Deficiencies
- **Aimless Play without Learning Goals (*PEAK*):** Users play with simulator sliders without connecting the physics to the mathematical equation.
- **Unresponsive Touch Handles:** Stiff webview controls cause lag and break the flow state.

#### 3. Required Redesign Changes
- **Goal-Directed Parameter Challenges:** Overlay a specific target objective banner (e.g., *"Adjust launch angle \(	heta\) to hit the target at 120m with air resistance"*).
- **Synchronized Parameter Readouts:** Real-time HUD displaying velocity, energy conservation curves, and trajectory equations updating at 60fps.
- **DuoMessageChannel Two-Way Sync:** Seamless progress tracking communicating simulator state directly to the native Flutter lesson engine.

#### 4. Image Generation Prompt
```text
Mobile app UI design for "Interactive Physics Simulator & Canvas" slide. Modern dark theme #090D16. The screen showcases an interactive "Gravitational Orbital Mechanics Simulator" with a large glowing golden Sun at the center and an interactive elliptical orbit path of Earth. Interactive HUD overlays: Top banner with objective "Achieve a stable circular orbit at radius R = 1.5 AU". Lower section contains 2 sleek slider controls: "Initial Velocity (v)" and "Launch Angle (	heta)", with glowing emerald green slider thumbs. Real-time metric card on the side showing `Period: 365.2 days | Eccentricity: 0.016`. Futuristic, beautiful, highly engaging STEM interactive visualization, PhET meets Apple UI, 8k --ar 9:16
```

---

### Screen 15: Error Spotting & Bug Hunting Diagnostic View
**Slide Type ID:** `error_spotting`

#### 1. Current State & Purpose
Presents a worked mathematical derivation or code snippet containing a subtle intentional logical flaw that the learner must identify and correct.

#### 2. Cognitive Science Deficiencies
- **Unfocused Guessing:** Learners tap random lines without analyzing the underlying deductive sequence.
- **Missing Causal Autopsy (*Make It Stick*):** Failing to explain *why* the bug causes system failure misses a prime metacognitive learning opportunity.

#### 3. Required Redesign Changes
- **Line-by-Line Target Inspection:** Tapping a line highlights it with an amber diagnostic scope.
- **Two-Stage Bug Resolution:** Stage 1: Identify flawed line -> Stage 2: Select the correct logical replacement from a multi-choice prompt.
- **Misconception Deep Dive:** Post-solve drawer explains the historical or conceptual misconception associated with this specific error.

#### 4. Image Generation Prompt
```text
Mobile app UI design for "Error Spotting & Logic Bug Hunt" slide in "Cognitive Sanctuary" light theme #F8FAFC. The main card presents a 6-line mathematical proof solving for a limit: `lim x->0 (sin x / x)`. Line 3 contains an erroneous application of L'Hopital's Rule: it is actively selected with a prominent amber alert border #D97706 and a small magnifying glass bug icon. Below the proof card, a prompt card asks: "Why is Line 3 invalid?" with 3 selectable options. Bottom button "Confirm Flaw Analysis" in solid cobalt blue #2563EB. Clean mathematical typography with JetBrains Mono and Space Grotesk. Diagnostic, intellectually engaging UI design, 8k --ar 9:16
```

---

### Screen 16: Lesson Header & Ambient Flow Chrome
**Slide Screen Component:** Header Navigation, Progress, Streak & Zen Mode

#### 1. Current State & Purpose
The top navigation bar of every lesson screen, providing exit controls, lesson progress tracking, combo flame counters, and AI assistant triggers.

#### 2. Cognitive Science Deficiencies
- **Visual Distraction During Deep Work (*Deep Work*):** Bright flashing badges and rigid progress meters distract working memory during high-focus problem solving.
- **Brittle Streak Anxiety:** High stress caused by fear of losing an all-or-nothing daily streak counter.

#### 3. Required Redesign Changes
- **Ambient Zen Mode (Auto-Dimming Chrome):** When problem solving begins, the top bar smoothly fades to 20% opacity, returning to full visibility upon user touch or step completion.
- **Fluid Flow Momentum Meter:** Replaces brittle streaks with a rolling 14-day cognitive volume momentum indicator with graceful rest day protection.
- **Integrated AI Socratic Tutor Pill:** Minimalist glowing pill button to invoke contextual hints without obscuring the question.

#### 4. Image Generation Prompt
```text
Mobile app UI design for "Ambient Flow Header & Lesson Chrome Bar" (component showcase at top of mobile screen). Sleek minimalist glassmorphic header on dark background #090D16: Left side has a subtle 'X' close button; center has a smooth pill-shaped fluid progress bar (65% filled with glowing gradient from Royal Blue #2563EB to Sky Blue #60A5FA); right side features a subtle flame icon with combo multiplier "x5" in warm amber #FBBF24 and an intelligent AI tutor orb icon with a soft violet pulse #A78BFA. Ultra-clean, modern, unobtrusive, designed for deep flow state, 8k resolution, vector UI asset --ar 16:9
```

---

### Screen 17: Bottom Action, Confidence Meter & Diagnostic Autopsy Tray
**Slide Screen Component:** Bottom Action Bar, Metacognitive Sliders & Feedback Drawer

#### 1. Current State & Purpose
The bottom action area handling answer verification, next slide progression, progressive hints, and feedback display.

#### 2. Cognitive Science Deficiencies
- **Binary Right/Wrong Penalties:** Abrupt red/green banners that trigger frustration without providing causal explanations.
- **Lack of Metacognitive Checking:** No mechanism to measure if a correct answer was a lucky guess or true mastery.

#### 3. Required Redesign Changes
- **3-Tier Metacognitive Confidence Bar:** Clean selector allowing the student to specify confidence (*Guessing*, *Plausible*, *Certain*) before checking.
- **Gated 3-Tier Progressive Hint Ladder:** Clean collapsible drawer offering Socratic Clues, Schema Outlines, and Worked Steps.
- **Causal Diagnostic Autopsy Tray:** Slides up post-check, explaining *why* the concept works and analyzing common cognitive traps.

#### 4. Image Generation Prompt
```text
Mobile app UI design for "Bottom Action Bar & Diagnostic Feedback Drawer" (component mockup on mobile screen). Clean light theme #F8FAFC. The bottom drawer has slid up with a soft emerald green background tint #DCFCE7 and a crisp green top border #16A34A. Inside the drawer: A bold green header "✨ Excellent Deduction!" followed by a 2-line causal explanation of the underlying theorem. Below the explanation, a collapsible tab "Why other options fail (Misconception Analysis)". At the very bottom, a wide solid royal blue pill button "Continue (Enter ↵)" with high clickability. Elegant Plus Jakarta Sans typography, friendly yet rigorous educational aesthetic, 8k --ar 16:9
```

---

### Screen 18: Lesson Complete & Metacognitive Mastery Summary Screen
**Slide Screen Component:** `lesson_complete_screen`

#### 1. Current State & Purpose
The summary screen shown upon completing all slides in a lesson, celebrating completion and forecasting future review sessions.

#### 2. Cognitive Science Deficiencies
- **Superficial Vanity Points:** Celebrating meaningless confetti XP without highlighting genuine conceptual schema gains.
- **Lack of Spaced Repetition Scheduling:** Fails to inform the learner *when* these concepts will be reviewed for optimal memory consolidation.

#### 3. Required Redesign Changes
- **Cognitive Mastery Radar & Schema Growth:** Displays exact sub-skills mastered (e.g., *Eigenvalues: 94%*, *Matrix Trace: 88%*).
- **Memory Stability Forecast:** Visual calendar card showing the next spaced repetition interval (*"Optimal review in 3 days"*).
- **Flow State Velocity Score:** Reflects focused deliberate practice time, error recovery rate, and total cognitive volume.

#### 4. Image Generation Prompt
```text
Mobile app UI design for "Lesson Complete & Metacognitive Mastery Summary" screen in "Cognitive Sanctuary" light theme #F8FAFC. Top hero section features an elegant glowing circular progress ring (92% Mastery) in emerald green #16A34A and royal blue #2563EB with text "Lesson Mastered • Linear Transformations". Below the hero, three sleek metrics cards: "Focus Velocity (12m in Flow)", "First-Try Accuracy (88%)", and "Cognitive Momentum (+45 pts)". In the middle, a Spaced Repetition calendar forecast card with a badge: "📅 Next Review Scheduled: Wednesday (3 Days)". At bottom, two pill buttons: Primary "Continue Learning Journey" in solid blue, Secondary "Review Difficult Steps". Celebration without distraction, high-end pedagogical UX, 8k resolution --ar 9:16
```

---
*Comprehensive Redesign & Image Generation Prompt Specification compiled for Duofy.*
