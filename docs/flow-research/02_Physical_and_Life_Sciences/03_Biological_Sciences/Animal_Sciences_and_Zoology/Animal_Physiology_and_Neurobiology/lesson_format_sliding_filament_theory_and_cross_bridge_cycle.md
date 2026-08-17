# Duofy Reusable Lesson Format: Sliding Filament Theory and the Cross-Bridge Cycle

**Target Topic:** `02_Physical_and_Life_Sciences / 03_Biological_Sciences / Animal_Sciences_and_Zoology / Animal_Physiology_and_Neurobiology`  
**Lesson Format Type:** `sliding_filament_theory_and_cross_bridge_cycle`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the molecular biophysics and mechanochemistry of muscle contraction (Hugh Huxley & Jean Hanson; Andrew Huxley & Rolf Niedergerke, 1954): trace the excitation-contraction coupling sequence (T-tubule depolarization $\to$ DHPR/RyR activation $\to \text{Ca}^{2+}$ release from Sarcoplasmic Reticulum $\to \text{Ca}^{2+}$ binding to Troponin C $\to$ Tropomyosin steric shift exposing myosin binding sites on Actin), master the 5-step **Actin-Myosin Cross-Bridge Cycle (ATP binding causes detachment, ATP hydrolysis cocks myosin head to $90^\circ$, cross-bridge binds actin, phosphate $\text{P}_i$ release triggers the mechanical Power Stroke pulling actin $10\text{ nm}$ toward the M-line, ADP release)**, and explain the molecular etiology of **Rigor Mortis**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Sliding Filament Theory & Cross-Bridge Cycle Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step 5-Stage Myosin Cross-Bridge Cycle Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Muscle Protein Component & Contractile Function Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Troponin Subunit Binding Intracellular Calcium Ion Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Rigor Mortis ATP Depletion Molecular Etiology Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Sliding Filament Theory & The Cross-Bridge Cycle (1954):
   - **Excitation-Contraction Coupling:**
     $$\text{Action Potential} \longrightarrow \text{T-Tubule (DHPR)} \longrightarrow \text{RyR Opening} \longrightarrow \text{Sarcoplasmic } \text{Ca}^{2+} \text{ Surge}$$
     - $\text{Ca}^{2+}$ binds **Troponin C** ($4\text{ Ca}^{2+}$ ions), causing a conformational shift that rolls **Tropomyosin** away from the myosin-binding sites on the **Actin thin filament**.
   - **The 5-Stage Cross-Bridge Cycle:**
     1. **Rigor State (Attached):** Myosin head bound tightly to actin without nucleotide ($45^\circ$ angle).
     2. **Detachment:** A fresh **ATP molecule binds the myosin head**, causing immediate conformational change that breaks the actin-myosin bond.
     3. **Cocking (ATP Hydrolysis):** Myosin hydrolyzes $\text{ATP} \to \text{ADP} + \text{P}_i$, swinging the lever arm forward into a high-energy $90^\circ$ "cocked" position.
     4. **Re-Attachment (Cross-Bridge Formation):** Cocked myosin head binds weakly to a new actin monomer further along the filament.
     5. **The Power Stroke:** Release of inorganic phosphate ($\text{P}_i$) triggers the mechanical power stroke ($45^\circ$ swivel of lever arm), generating $3-5\text{ pN}$ force and sliding actin $\approx 10\text{ nm}$ toward the sarcomere M-line, followed by release of $\text{ADP}$.
   - **Sarcomere Kinematics:** Actin and myosin filaments **do not change length**; the degree of interdigitated overlap increases (I-band and H-zone shorten; A-band remains constant!).
2. **Slide 2 (`ordering`):** Provide 5 steps of the cross-bridge cycle: (1) free ATP binds to the myosin head, causing it to detach from the actin thin filament, (2) myosin ATPase hydrolyzes ATP to $\text{ADP} + \text{P}_i$, swinging the lever arm into the high-energy cocked $90^\circ$ conformation, (3) elevated sarcoplasmic $\text{Ca}^{2+}$ binds troponin C, rolling tropomyosin away so the cocked myosin head binds to actin, (4) inorganic phosphate ($\text{P}_i$) is released from the myosin catalytic site, triggering the mechanical power stroke that pulls the actin filament $10\text{ nm}$ toward the M-line, (5) $\text{ADP}$ dissociates from the myosin head, leaving the cross-bridge locked in the transient attached rigor state awaiting the next ATP molecule!
3. **Slide 3 (`matching`):** Pair 4 contractile proteins (Myosin Heavy Chain, Actin Thin Filament, Troponin C, Tropomyosin) with their specific functional roles.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that calcium ions bind specifically to troponin C to initiate cross-bridge cycling. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the molecular cause of Rigor Mortis: Several hours after death, skeletal muscles throughout the body become completely rigid and locked (rigor mortis). What is the exact molecular cause of this sustained muscle stiffness? (Following death, cellular respiration ceases and **ATP is completely depleted**; because ATP binding is strictly required to detach the myosin head from actin, myosin heads remain **permanently cross-linked to actin in the rigid $45^\circ$ state**, while $\text{Ca}^{2+}$ leaks unchecked into the sarcoplasm).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "sliding_filament_theory_and_cross_bridge_cycle",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Sliding Filament Theory and the Cross-Bridge Cycle**\n• **Excitation-Contraction Coupling:**\n$$\n\\text{Action Potential} \\to \\text{T-Tubules} \\to \\text{RyR Opening} \\to \\text{Ca}^{2+} \\text{ Influx into Sarcoplasm}\n$$\n  - $\\text{Ca}^{2+}$ binds **Troponin C**, moving **Tropomyosin** to unmask myosin binding sites on Actin.\n• **The 5-Stage Cross-Bridge Cycle (Huxley & Hanson, 1954):**\n  1. **ATP Binding & Detachment:** ATP binds myosin head $\\implies$ Myosin **detaches** from actin.\n  2. **Cocking (Hydrolysis):** ATP hydrolyzes to $\\text{ADP} + \\text{P}_i$, cocking lever arm to $90^\\circ$.\n  3. **Cross-Bridge Binding:** Myosin binds to a new upstream actin monomer.\n  4. **The Power Stroke:** Release of $\\text{P}_i$ triggers lever arm swivel ($45^\\circ$), sliding actin $10\\text{ nm}$ toward M-line.\n  5. **ADP Release:** Returns to transient rigor attached state.\n• **Sarcomere Kinematics:** Filaments do NOT change length; A-band remains constant while I-band and H-zone shorten."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential molecular events of the actin-myosin cross-bridge cycle.",
      "orderItems": [
        "A molecule of ATP binds to the nucleotide pocket of the myosin head, causing immediate detachment from actin",
        "Myosin ATPase hydrolyzes ATP into ADP and Pi, re-cocking the myosin lever arm into a high-energy 90° conformation",
        "Calcium-activated troponin-tropomyosin shifts, allowing the cocked myosin head to bind to a new actin subunit",
        "Inorganic phosphate (Pi) is released, triggering the mechanical power stroke that pulls the actin filament 10 nm toward the M-line",
        "ADP dissociates from the active site, leaving the myosin head locked in the attached rigor state until a new ATP binds"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each sarcomeric protein component to its precise physiological role.",
      "matchPairs": [
        { "left": "Myosin Heavy Chain", "right": "Thick filament motor protein with an ATPase head and swiveling lever arm that generates mechanical force" },
        { "left": "Actin Filament", "right": "Helical thin filament providing tracks and binding sites for cross-bridge attachment" },
        { "left": "Troponin C", "right": "Calcium-sensor protein that binds 4 Ca²⁺ ions to initiate conformational shifting" },
        { "left": "Tropomyosin", "right": "Filamentous protein that sterically blocks myosin-binding sites on actin in the resting relaxed state" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In skeletal muscle excitation-contraction coupling, calcium ions released from the sarcoplasmic reticulum bind directly to troponin ___.",
      "blankAnswer": "c",
      "blankDistractors": ["t", "i", "a"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the precise molecular cause of Rigor Mortis (the profound stiffening of skeletal muscles occurring a few hours after death)?",
      "options": [
        { "text": "COMPLETE DEPLETION OF CELLULAR ATP; because ATP binding is mandatory to break the actin-myosin bond, the lack of ATP prevents myosin heads from detaching, locking all cross-bridges permanently in the rigid attached state", "isCorrect": true, "explanation": "Correct! In the cross-bridge cycle, ATP binding is required to detach the myosin head from actin. Following death, cellular respiration stops and ATP production ceases. As glycogen and ATP stores are exhausted, myosin heads that have executed a power stroke cannot bind ATP to detach. Consequently, all cross-bridges remain permanently locked in the rigor complex, causing generalized muscle rigidity until tissue autolysis begins." },
        { "text": "Excessive accumulation of ATP inside mitochondria", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Complete destruction of all actin filaments", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Conversion of myosin into bone mineral", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
