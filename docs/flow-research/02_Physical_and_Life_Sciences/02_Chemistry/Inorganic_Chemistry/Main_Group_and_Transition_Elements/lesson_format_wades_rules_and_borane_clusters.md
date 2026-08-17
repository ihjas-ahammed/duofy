# Duofy Reusable Lesson Format: Wade's Rules and Borane Clusters

**Target Topic:** `02_Physical_and_Life_Sciences / 02_Chemistry / Inorganic_Chemistry / Main_Group_and_Transition_Elements`  
**Lesson Format Type:** `wades_rules_and_borane_clusters`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through Polyhedral Skeletal Electron Pair Theory (PSEPT) and multi-center bonding in boron hydride clusters: formulate **Wade's Rules (Kenneth Wade, 1971; D. Michael P. Mingos, 1972)** for cluster geometry classification, calculate the number of **Skeletal Electron Pairs ($\text{SEP}$)** from chemical formulas, correlate SEP to polyhedral geometry (**Closo** $[\text{B}_n\text{H}_n]^{2-}$ with $n+1$ SEP, **Nido** $\text{B}_n\text{H}_{n+4}$ with $n+2$ SEP, **Arachno** $\text{B}_n\text{H}_{n+6}$ with $n+3$ SEP, **Hypho** $\text{B}_n\text{H}_{n+8}$ with $n+4$ SEP), and analyze 3-center-2-electron ($\text{B}-\text{H}-\text{B}$) bridging bonding in diborane ($\text{B}_2\text{H}_6$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Wade's Rules & PSEPT Skeletal Pair Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step B5H9 Skeletal Electron Pair Calculation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Borane Cluster Type & Skeletal Electron Pair Count Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Closo Cluster Skeletal Electron Pairs Above Vertex Count Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | B4H10 Arachno vs B6H6(2-) Closo Cluster Classification Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Polyhedral Skeletal Electron Pair Theory (Wade-Mingos Rules, 1971):
   - **Electron Counting per Vertex Unit:**
     - Each $\text{B}-\text{H}$ vertex unit contributes **2 skeletal electrons** (Boron has 3 valence electrons; 1 is used for terminal $\text{B}-\text{H}$ $\sigma$-bond, leaving 2 for skeletal bonding).
     - Each extra (bridging) $\text{H}$ atom contributes **1 electron**.
     - Anionic charge ($-z$) adds **$z$ electrons**.
     - Divide total skeletal electrons by 2 to get **Skeletal Electron Pairs (SEP)**.
   - **Cluster Classification Table (for an $n$-vertex cluster):**
     - **Closo ($n+1$ SEP):** $[\text{B}_n\text{H}_n]^{2-}$. Complete closed deltahedron (e.g. icosahedral $[\text{B}_{12}\text{H}_{12}]^{2-}$).
     - **Nido ($n+2$ SEP):** $\text{B}_n\text{H}_{n+4}$ or $[\text{B}_n\text{H}_{n+2}]^{2-}$. Open nest geometry derived by removing 1 vertex from an $(n+1)$-vertex polyhedron (e.g. $\text{B}_5\text{H}_9$, square pyramid).
     - **Arachno ($n+3$ SEP):** $\text{B}_n\text{H}_{n+6}$. Web-like geometry derived by removing 2 vertices from an $(n+2)$-vertex polyhedron (e.g. $\text{B}_4\text{H}_{10}$, butterfly).
     - **Hypho ($n+4$ SEP):** $\text{B}_n\text{H}_{n+8}$. Net-like geometry (3 missing vertices).
2. **Slide 2 (`ordering`):** Provide 5 steps classifying pentaborane(9) $\text{B}_5\text{H}_9$ using Wade's rules: (1) identify $n = 5$ boron vertices, (2) count skeletal electrons from the 5 $\text{BH}$ units: $5 \times 2 = 10$ electrons, (3) add 1 electron for each of the 4 bridging hydrogen atoms: $4 \times 1 = 4$ electrons, (4) sum total skeletal electrons ($10 + 4 = 14$) and divide by 2 to obtain $\text{SEP} = 7$ pairs, (5) compare $\text{SEP} = 7$ with vertex count $n=5$: $\text{SEP} = n + 2 = 5 + 2 = 7$, confirming that $\text{B}_5\text{H}_9$ is a **Nido** cluster based on an octahedron with 1 missing vertex!
3. **Slide 3 (`matching`):** Pair 4 borane clusters ($[\text{B}_6\text{H}_6]^{2-}$, $\text{B}_5\text{H}_9$, $\text{B}_4\text{H}_{10}$, $[\text{B}_{12}\text{H}_{12}]^{2-}$) with their Wade's rule structural classifications (Closo octahedral, Nido square pyramidal, Arachno butterfly, Closo icosahedral).
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that a closo borane cluster with n vertices contains exactly n + 1 skeletal electron pairs. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on classifying tetraborane(10) $\text{B}_4\text{H}_{10}$: What is the skeletal electron pair count and Wade's rule cluster classification for tetraborane(10), $\text{B}_4\text{H}_{10}$? (It has **$7$ Skeletal Electron Pairs ($\text{SEP} = 7 = n + 3$)**, classifying it as an **Arachno** cluster; $4\text{ BH}$ units contribute $4 \times 2 = 8$ electrons $+$ $6$ extra bridging hydrogens contribute $6$ electrons $= 14$ electrons $= 7$ pairs $= 4 + 3$, representing an octahedron missing 2 vertices).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "wades_rules_and_borane_clusters",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Wade's Rules and Polyhedral Skeletal Electron Pair Theory**\n• **Skeletal Electron Counting Rules:**\n  - Each $\\text{B}-\\text{H}$ vertex unit $\\longrightarrow$ **2 skeletal electrons**.\n  - Each extra bridging $\\text{H}$ atom $\\longrightarrow$ **1 skeletal electron**.\n  - Each negative charge ($-z$) $\\longrightarrow$ **$z$ skeletal electrons**.\n  - **Skeletal Electron Pairs (SEP)** = Total Skeletal Electrons / 2.\n• **Cluster Geometries (for $n$ boron vertices):**\n$$\n\\begin{aligned}\n\\text{Closo } ([\\text{B}_n\\text{H}_n]^{2-}): &\\quad \\text{SEP} = n + 1 \\quad (\\text{Complete deltahedron}) \\\\\n\\text{Nido } (\\text{B}_n\\text{H}_{n+4}): &\\quad \\text{SEP} = n + 2 \\quad (\\text{1 vertex missing from } n+1 \\text{ polyhedra}) \\\\\n\\text{Arachno } (\\text{B}_n\\text{H}_{n+6}): &\\quad \\text{SEP} = n + 3 \\quad (\\text{2 vertices missing from } n+2 \\text{ polyhedra}) \\\\\n\\text{Hypho } (\\text{B}_n\\text{H}_{n+8}): &\\quad \\text{SEP} = n + 4 \\quad (\\text{3 vertices missing})\n\\end{aligned}\n$$\n• **3c-2e Bonds:** Multi-center $\\text{B}-\\text{H}-\\text{B}$ bridges satisfy electron-deficient boron valency."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the steps classifying pentaborane(9), B5H9, using Wade's electron counting rules.",
      "orderItems": [
        "Identify the number of cluster vertices: n = 5 boron atoms",
        "Count skeletal electrons contributed by the five BH vertex units: 5 * 2 = 10 electrons",
        "Add one skeletal electron for each of the 4 bridging hydrogen atoms: 4 * 1 = 4 electrons",
        "Sum the total skeletal electrons (10 + 4 = 14) and divide by 2 to determine SEP = 7 pairs",
        "Evaluate the SEP formula: SEP = 7 = n + 2 (since 5 + 2 = 7), confirming B5H9 is a NIDO cluster"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each borane species to its Wade's rule cluster classification.",
      "matchPairs": [
        { "left": "[B6H6]2- (n = 6, SEP = 7)", "right": "Closo cluster (complete 6-vertex regular octahedron; n+1 pairs)" },
        { "left": "B5H9 (n = 5, SEP = 7)", "right": "Nido cluster (5-vertex square pyramid derived from 6-vertex octahedron; n+2 pairs)" },
        { "left": "B4H10 (n = 4, SEP = 7)", "right": "Arachno cluster (4-vertex butterfly derived from 6-vertex octahedron; n+3 pairs)" },
        { "left": "[B12H12]2- (n = 12, SEP = 13)", "right": "Closo cluster (complete 12-vertex icosahedron; n+1 pairs)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "A closo borane cluster containing n boron atoms possesses exactly n + ___ skeletal electron pairs (SEP).",
      "blankAnswer": "1",
      "blankDistractors": ["2", "3", "4"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the skeletal electron pair count (SEP) and cluster classification for tetraborane(10), B4H10?",
      "options": [
        { "text": "SEP = 7 pairs (4 BH units = 8 e⁻ + 4 extra H's = 6 e⁻ -> 14 e⁻ / 2 = 7 pairs); with n = 4 vertices, SEP = n + 3 = 4 + 3 = 7, classifying B4H10 as an ARACHNO cluster", "isCorrect": true, "explanation": "Correct! In B4H10, there are 4 BH units (contributing 4*2 = 8 electrons) and 6 extra bridging/capping hydrogens (contributing 6*1 = 6 electrons), giving 14 skeletal electrons (7 pairs). Since n = 4 and SEP = 7 = 4 + 3 (n+3), it is an arachno cluster based on an octahedron with 2 missing vertices." },
        { "text": "SEP = 5 pairs, Closo cluster", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "SEP = 6 pairs, Nido cluster", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "SEP = 8 pairs, Hypho cluster", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
