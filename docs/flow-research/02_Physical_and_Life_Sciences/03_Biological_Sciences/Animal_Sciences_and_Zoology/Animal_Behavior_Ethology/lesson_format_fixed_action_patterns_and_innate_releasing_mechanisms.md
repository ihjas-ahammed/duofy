# Duofy Reusable Lesson Format: Fixed Action Patterns and Innate Releasing Mechanisms

**Target Topic:** `02_Physical_and_Life_Sciences / 03_Biological_Sciences / Animal_Sciences_and_Zoology / Animal_Behavior_Ethology`  
**Lesson Format Type:** `fixed_action_patterns_and_innate_releasing_mechanisms`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the neuroethological architecture of instinctual behaviors (Konrad Lorenz & Nikolaas Tinbergen, Nobel Prize 1973): formulate the triplet triad of classical ethology (**Sign Stimulus / Releaser** $\to$ **Innate Releasing Mechanism [IRM]** $\to$ **Fixed Action Pattern [FAP]**), analyze the 4 defining hallmarks of an FAP (innate / unlearned, highly stereotyped across a species, triggered by simple specific sign stimuli, and **runs unconditionally to completion without requiring ongoing sensory feedback**), evaluate **Supernormal Stimuli** (artificial exaggerated cues eliciting supra-optimal behavioral drives), and examine classic ethological model systems (three-spined stickleback red belly aggression, graylag goose egg-rolling, European robin breast territoriality).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Classical Ethology FAP & IRM Triad Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Graylag Goose Egg-Rolling FAP Execution Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Ethological Concept & Experimental Model Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Neural Circuit Filter Activating Fixed Action Pattern Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Supernormal Stimulus Egg Preference in Oystercatchers Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Fixed Action Patterns & The IRM Triad:
   - **The Classical Ethological Triad (Lorenz & Tinbergen):**
     $$\text{Sign Stimulus / Releaser} \longrightarrow \text{Innate Releasing Mechanism (IRM)} \longrightarrow \text{Fixed Action Pattern (FAP)}$$
   - **Characteristics of a Fixed Action Pattern (FAP):**
     1. **Innate / Genetically Programmed:** Performed correctly on the very first exposure without prior training or social learning.
     2. **Stereotyped:** Highly uniform in kinematics and duration across all individuals of a species.
     3. **Ballistic / Autonomous:** Once initiated by the IRM, the motor program **runs to completion even if the triggering stimulus is removed mid-action**.
     4. **Resistant to Modification:** Difficult to interrupt or alter by immediate feedback.
   - **Sign Stimuli & Supernormal Stimuli:**
     - **Sign Stimulus (Releaser):** A specific, isolated sensory feature (e.g., the red underbelly of a male three-spined stickleback, or the red spot on a parent herring gull's lower mandible).
     - **Supernormal Stimulus:** An exaggerated, artificial mock-up (e.g., a giant wooden egg with high-contrast spots) that triggers a stronger, more vigorous behavioral response than the natural biological stimulus.
2. **Slide 2 (`ordering`):** Provide 5 steps of the classic Graylag Goose (*Anser anser*) egg-retrieval FAP (Lorenz & Tinbergen, 1938): (1) brooding goose spots an egg that has rolled out of the nest rim (Sign Stimulus: spherical shape near nest), (2) visual stimulus activates the goose's hardwired Innate Releasing Mechanism (IRM) in the central nervous system, (3) goose extends its neck and places the underside of its bill over the displaced egg, (4) goose executes a fixed sequence of sagittal bill tucking and lateral balance adjustments to roll the egg back into the nest, (5) if the experimenter removes the egg mid-action, the goose continues the identical bill-tucking motor sequence all the way back to the empty nest cup without stopping (proving the ballistic nature of the FAP)!
3. **Slide 3 (`matching`):** Pair 4 classic ethological experiments (Stickleback red belly models, Herring gull chick red mandible spot, Oystercatcher giant spotted dummy egg, Graylag goose egg-rolling) with their theoretical ethological significance.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the hardwired neurosensory filter that recognizes a sign stimulus and unlocks a fixed action pattern is the innate releasing mechanism (IRM). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on supernormal stimuli: In Tinbergen's experiments on Eurasian oystercatchers, when a mother bird is presented with her own natural egg alongside a giant, brightly painted artificial egg five times its normal size, how does she behave? (She attempts to **climb onto and incubate the giant fake egg, completely abandoning her own natural egg**; because natural selection tuned the sensory-perceptual releasing mechanism to the simple heuristic 'larger and more speckled = higher quality egg', the exaggerated supernormal stimulus over-stimulates the neural circuit).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "fixed_action_patterns_and_innate_releasing_mechanisms",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Fixed Action Patterns (FAPs) and the IRM Triad**\n• **The Classical Ethological Sequence (Lorenz & Tinbergen, 1938):**\n$$\n\\text{Sign Stimulus (Releaser)} \\longrightarrow \\text{Innate Releasing Mechanism (IRM)} \\longrightarrow \\text{Fixed Action Pattern (FAP)}\n$$\n• **The 4 Defining Hallmarks of an FAP:**\n  1. **Innate & Unlearned:** Executed flawlessly on first trial without prior learning.\n  2. **Stereotyped:** Highly uniform, invariant motor sequence across the entire species.\n  3. **Triggered by Specific Sign Stimulus:** Requires only a simple sensory cue (e.g. red patch).\n  4. **Ballistic (Runs to Completion):** Once released, the motor program **completes fully even if the stimulus is removed mid-action**.\n• **Supernormal Stimuli:** Exaggerated artificial models that trigger **stronger behavioral responses** than natural biological cues."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the steps of the Graylag Goose egg-retrieval Fixed Action Pattern (FAP).",
      "orderItems": [
        "The brooding goose visually detects an egg displaced outside the rim of the nest (Sign Stimulus)",
        "The visual cue unlocks the hardwired Innate Releasing Mechanism (IRM) in the central nervous system",
        "The goose extends its neck and positions the underside of its beak over the displaced egg",
        "The goose performs a stereotyped motor sequence of sagittal bill-tucking to roll the egg backward",
        "Even if the experimenter removes the egg mid-roll, the goose continues the exact neck-tucking motor program to completion"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each classic ethological experiment to its biological concept.",
      "matchPairs": [
        { "left": "Stickleback fish attacking crude red-bottomed wooden models", "right": "Sign Stimulus / Releaser (red underbelly triggers aggressive territorial FAP)" },
        { "left": "Herring gull chick pecking at a red cardboard strip", "right": "Innate begging response triggered by high-contrast red spot on parent's lower bill" },
        { "left": "Oystercatcher incubating a giant artificial wooden egg", "right": "Supernormal Stimulus (exaggerated size/contrast overrides natural biological egg)" },
        { "left": "Graylag goose completing neck movements without an egg", "right": "Ballistic Fixed Action Pattern (invariant motor sequence running to completion)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The hardwired neural circuit that recognizes a sign stimulus and triggers a fixed action pattern is the innate ___ mechanism (IRM).",
      "blankAnswer": "releasing",
      "blankDistractors": ["inhibitory", "synaptic", "migratory"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "When a mother Eurasian oystercatcher is presented with a choice between her own real egg and a giant artificial wooden egg four times larger with exaggerated black spots, how does she respond?",
      "options": [
        { "text": "She preferentially chooses to incubate the GIANT ARTIFICIAL EGG, abandoning her own real egg; the exaggerated artificial cue acts as a SUPERNORMAL STIMULUS that hyper-activates her innate visual releasing mechanism", "isCorrect": true, "explanation": "Correct! Natural selection evolved an innate releasing rule: 'larger, higher-contrast speckled objects in the nest are higher quality eggs.' Because oystercatchers never encountered giant wooden replicas in their evolutionary history, the exaggerated supernormal stimulus exploits and over-excites the underlying neural circuit, causing the bird to prioritize the fake egg over her own biological offspring." },
        { "text": "She destroys the fake egg with her bill immediately", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "She ignores both eggs and flies away permanently", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "She lays a third egg inside the wooden model", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
