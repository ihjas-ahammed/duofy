# Duofy Reusable Lesson Format: Adjoint Functor Pairs and the Unit-Counit Adjunction

**Target Topic:** `01_Mathematics_and_Logic / 05_Mathematical_Logic_and_Foundations / Category_Theory / Functors_and_Natural_Transformations`  
**Lesson Format Type:** `adjoint_functor_pairs_and_unit_counit`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify rapid recognition of **Adjoint Functor Pairs** ($F \dashv G$): formulate the Hom-set bijection $\operatorname{Hom}_{\mathcal{D}}(F(A), B) \cong \operatorname{Hom}_{\mathcal{C}}(A, G(B))$, define the **Unit $\eta: \operatorname{Id}_{\mathcal{C}} \Rightarrow G \circ F$** and **Counit $\varepsilon: F \circ G \Rightarrow \operatorname{Id}_{\mathcal{D}}$**, verify the **Triangle Identities**, evaluate classic Free-Forgetful adjunctions (Free Group $\dashv$ Forgetful, Discrete $\dashv$ Forgetful in $\mathbf{Top}$), and interact with live adjunction unit-counit loop simulators.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Adjoint Functors & Unit-Counit Triangle Identities Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Mathematical Discipline & Canonical Adjunction Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Triangle Identity Composition Verification Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | Unprompted Left Adjoint Functor Property Recall | `one_word` | Production (Phase C) | `content`, `blankAnswer` (plain text) |
| **Slide 5** | Interactive Free-Forgetful Adjunction Loop Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "adjoint_functor_pairs_and_unit_counit",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is an Adjoint Functor Pair (F -| G), and what are the Unit, Counit, and Triangle Identities?",
      "blankAnswer": "A functor F: C -> D is LEFT ADJOINT to G: D -> C (written F -| G) if there is a natural bijection Hom_D(F(A), B) cong Hom_C(A, G(B)) for all objects A in C, B in D. Equivalently, this is defined by a UNIT natural transformation eta: Id_C => G circ F and a COUNIT natural transformation epsilon: F circ G => Id_D satisfying the two TRIANGLE IDENTITIES: (epsilon F) circ (F eta) = id_F and (G epsilon) circ (eta G) = id_G. Left adjoints preserve ALL COLIMITS, and right adjoints preserve ALL LIMITS (RAPL)!"
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each canonical Free-Forgetful left adjoint F to its right adjoint G.",
      "matchPairs": [
        { "left": "Free Group Functor F: Set -> Grp", "right": "Forgetful Functor U: Grp -> Set (extracts underlying set of elements)" },
        { "left": "Free Vector Space Functor k^{(-)}: Set -> Vect_k", "right": "Forgetful Functor U: Vect_k -> Set" },
        { "left": "Abelianization Functor (-)_{ab}: Grp -> Ab", "right": "Inclusion Functor Inc: Ab -> Grp" },
        { "left": "Discrete Topology Functor D: Set -> Top", "right": "Forgetful Functor U: Top -> Set" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "What fundamental limit-preservation theorem holds for every Adjoint Functor Pair F -| G (where F is left adjoint and G is right adjoint)?",
      "options": [
        { "text": "RAPL / LACC: Right Adjoints Preserve Limits (G preserves all limits/products/pullbacks) and Left Adjoints Preserve Colimits (F preserves all colimits/coproducts/pushouts)", "isCorrect": true, "explanation": "Correct! One of the most powerful theorems in category theory: any functor that has a left adjoint automatically preserves all limits, and any functor that has a right adjoint automatically preserves all colimits." },
        { "text": "Left adjoints preserve all limits", "isCorrect": false, "explanation": "Incorrect: Left adjoints preserve colimits." },
        { "text": "Adjoints only preserve finite sets", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Adjoint functors are always invertible equivalences", "isCorrect": false, "explanation": "Incorrect: Adjunctions are weaker than categorical equivalences." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "one_word",
      "content": "In an adjunction F -| G, what 4-letter word describes the functor F (left or right)?",
      "blankAnswer": "left"
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Free-Forgetful Adjunction Loop Engine",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Free Group ⊣ Forgetful Adjunction</h3><p>Set S = {x, y}  ⇄  Free Group F(S) = ⟨x, y⟩</p><button id=\"adjBtn\" style=\"padding:8px 20px; background:#2563eb; color:white; border:none; border-radius:6px; cursor:pointer;\">Evaluate Unit η_S and Triangle Loop</button><div id=\"adjOut\" style=\"margin-top:12px; color:#10b981; font-weight:bold;\"></div><script>document.getElementById('adjBtn').onclick=()=>{document.getElementById('adjOut').innerText='Unit Mapping: η_S: S → U(F(S)) maps generators x ↦ x, y ↦ y. Counit evaluation ε_{F(S)} collapses words. Triangle identity (εF) ∘ (Fη) = id_F verified! Left adjoint F preserves all coproducts (free products).'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
