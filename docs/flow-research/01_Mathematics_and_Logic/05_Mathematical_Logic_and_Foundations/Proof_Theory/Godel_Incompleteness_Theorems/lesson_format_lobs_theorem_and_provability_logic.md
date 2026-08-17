# Duofy Reusable Lesson Format: Löb's Theorem and Provability Logic

**Target Topic:** `01_Mathematics_and_Logic / 05_Mathematical_Logic_and_Foundations / Proof_Theory / Godel_Incompleteness_Theorems`  
**Lesson Format Type:** `lobs_theorem_and_provability_logic`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of **Löb's Theorem (Martin Hugo Löb, 1955)**: evaluate the profound statement $T \vdash \operatorname{Prov}_T(\ulcorner \phi \urcorner) \to \phi \implies T \vdash \phi$ (a theory can only trust its own proof of $\phi$ if $\phi$ is already provable), derive Gödel's Second Theorem as a 1-line corollary by setting $\phi = \bot$, explore modal **Provability Logic GL (Gödel-Löb)** ($K4 + \Box(\Box P \to P) \to \Box P$), and interact with live self-reference truth simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Löb's Theorem & Modal Provability Logic Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Modal Provability Logic GL Axiom & Meaning Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Deriving Second Incompleteness via Löb with Falsehood Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Provability Logic Acronym Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Self-Referential Henkin vs Gödel Sentence Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "lobs_theorem_and_provability_logic",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is Löb's Theorem, and how does Modal Provability Logic GL formalize it?",
      "blankAnswer": "Löb's Theorem (Martin Hugo Löb, 1955) states that for any sentence phi in formal arithmetic T satisfying the Hilbert-Bernays-Löb conditions: if T |- Prov_T([phi]) -> phi, then T |- phi! In modal logic GL (Gödel-Löb), where Box represents provability, this is formalized by the characteristic axiom Box(Box P -> P) -> Box P. Setting phi = false (0 = 1) yields: if T |- not Prov_T([0=1]) (i.e. T proves Con(T)), then T |- 0=1 (T is inconsistent), immediately proving Gödel's Second Incompleteness Theorem!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each modal provability logic axiom to its arithmetic interpretation.",
      "matchPairs": [
        { "left": "Necessitation Rule (|- P => |- Box P)", "right": "If P is proven, arithmetic proves that P is provable (D1)" },
        { "left": "Distribution Axiom K: Box(P -> Q) -> (Box P -> Box Q)", "right": "Modus ponens distributes over provability (D2)" },
        { "left": "Transitivity Axiom 4: Box P -> Box Box P", "right": "If P is provable, the system proves that it is provable (D3)" },
        { "left": "Löb's Axiom: Box(Box P -> P) -> Box P", "right": "The formal modal logic engine of Gödel-Löb (GL) provability" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "How does setting phi = bot (falsehood, 0 = 1) in Löb's Theorem T |- Prov_T([phi]) -> phi => T |- phi immediately yield Gödel's Second Incompleteness Theorem?",
      "options": [
        { "text": "Prov_T([bot]) -> bot is logically equivalent to not Prov_T([bot]) = Con(T); if T |- Con(T), Löb's theorem forces T |- bot (proving T is inconsistent). Therefore, consistent systems CANNOT prove their own consistency!", "isCorrect": true, "explanation": "Correct! Setting phi = bot makes the antecedent exactly Con(T). If T proves Con(T), Löb's theorem immediately implies T proves bot (a contradiction), so consistent theories cannot prove Con(T)." },
        { "text": "Because false sentences are always provable", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because 0 = 1 has no Gödel number", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because modal logic replaces arithmetic", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "What is the two-letter acronym for the standard modal Provability Logic system of Gödel and Löb (GL)?",
      "blankAnswer": "gl"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Henkin vs Gödel Sentence Simulator",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Henkin vs Gödel Sentence Engine</h3><p>Gödel: G ↔ ¬Prov(G) | Henkin: H ↔ Prov(H)</p><button id=\"lobBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Apply Löb's Theorem to Henkin Sentence</button><div id=\"lobOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('lobBtn').onclick=()=>{document.getElementById('lobOut').innerText='Löb Evaluation: Since H ↔ Prov(H), trivially T |- Prov(H) -> H. By Löb’s Theorem, T |- H! Unlike Gödel’s unprovable sentence G, Henkin’s self-asserting sentence is provable and TRUE!'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
