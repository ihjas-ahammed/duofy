# Duofy Reusable Lesson Format: Derived Functors (Tor and Ext) - Worked Examples

**Target Topic:** `01_Mathematics_and_Logic / 01_Pure_Mathematics / Algebra / Homological_Algebra / Derived_Functors_Tor_and_Ext`  
**Lesson Format Type:** `worked_examples`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to explicitly compute $\text{Tor}_1^{\mathbb{Z}}(\mathbb{Z}/m\mathbb{Z}, \mathbb{Z}/n\mathbb{Z}) \cong \mathbb{Z}/\gcd(m, n)\mathbb{Z}$ and $\text{Ext}_{\mathbb{Z}}^1(\mathbb{Z}/m\mathbb{Z}, \mathbb{Z}/n\mathbb{Z})$ by setting up free/projective resolutions $0 \to \mathbb{Z} \xrightarrow{\cdot m} \mathbb{Z} \to \mathbb{Z}/m\mathbb{Z} \to 0$, tensoring or applying Hom, and finding kernels/cokernels.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Free Resolution Computation Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Tor Calculation Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | GCD Torsion Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 4** | Numerical Tor Group Order Calculation | `numerical` | Production (Phase C) | `content`, `numericAnswer`, `numericTolerance` |
| **Slide 5** | Ext Group Extension Discrimination Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the canonical projective resolution $0 \to \mathbb{Z} \xrightarrow{\cdot m} \mathbb{Z} \to \mathbb{Z}/m\mathbb{Z} \to 0$ and the formula $\text{Tor}_1^{\mathbb{Z}}(\mathbb{Z}/m\mathbb{Z}, B) = \{b \in B \mid mb = 0\} = B[m]$.
2. **Slide 2 (`concept_pieces`):** Deconstruct the 4 steps of computing $\text{Tor}_1(\mathbb{Z}/12\mathbb{Z}, \mathbb{Z}/18\mathbb{Z})$.
3. **Slide 3 (`fill_in_blank`):** Single sentence blank testing recall that $\text{Tor}_1(\mathbb{Z}/m, \mathbb{Z}/n) \cong \mathbb{Z}/\gcd(m, n)$. Plain text only.
4. **Slide 4 (`numerical`):** Ask student to calculate the integer order of $\text{Tor}_1^{\mathbb{Z}}(\mathbb{Z}/24\mathbb{Z}, \mathbb{Z}/36\mathbb{Z}) = \gcd(24, 36) = 12$.
5. **Slide 5 (`quiz`):** Quiz testing the identification of non-split extensions in $\text{Ext}_{\mathbb{Z}}^1(\mathbb{Z}/2\mathbb{Z}, \mathbb{Z}/2\mathbb{Z})$ (distinguishing $\mathbb{Z}/4\mathbb{Z}$ from $\mathbb{Z}/2\mathbb{Z} \times \mathbb{Z}/2\mathbb{Z}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "worked_examples",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Computing Tor and Ext for Cyclic Groups**\nTo compute $\\text{Tor}_1^{\\mathbb{Z}}(\\mathbb{Z}/m\\mathbb{Z}, B)$, use the standard free resolution of $\\mathbb{Z}/m\\mathbb{Z}$:\n$$\n0 \\to \\mathbb{Z} \\xrightarrow{\\cdot m} \\mathbb{Z} \\to \\mathbb{Z}/m\\mathbb{Z} \\to 0\n$$\nDrop $\\mathbb{Z}/m\\mathbb{Z}$ and tensor with $B$:\n$$\n0 \\to \\mathbb{Z} \\otimes B \\xrightarrow{\\cdot m} \\mathbb{Z} \\otimes B \\to 0 \\implies 0 \\to B \\xrightarrow{\\cdot m} B \\to 0\n$$\nTaking homology in degree 1 yields:\n$$\n\\text{Tor}_1^{\\mathbb{Z}}(\\mathbb{Z}/m\\mathbb{Z}, B) = \\ker(B \\xrightarrow{\\cdot m} B) = \\{b \\in B \\mid mb = 0\\} = B[m]\n$$"
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Identify Subgroup):** For $B = \\mathbb{Z}/18\\mathbb{Z}$ and $m = 12$, we need elements $b \\in \\mathbb{Z}/18\\mathbb{Z}$ with $12b \\equiv 0 \\pmod{18}$.\n• **Step 2 (Solve Congruence):** $12b \\equiv 0 \\pmod{18} \\iff 2b \\equiv 0 \\pmod 3 \\iff b$ is a multiple of 3.\n• **Step 3 (Count Elements):** The multiples of 3 in $\\mathbb{Z}/18\\mathbb{Z}$ are $\{0, 3, 6, 9, 12, 15\}$, which has 6 elements.\n• **Step 4 (Conclude Isomorphism):** $\\text{Tor}_1^{\\mathbb{Z}}(\\mathbb{Z}/12\\mathbb{Z}, \\mathbb{Z}/18\\mathbb{Z}) \\cong \\mathbb{Z}/6\\mathbb{Z}$, since $\\gcd(12, 18) = 6$."
    },
    {
      "slideIndex": 3,
      "type": "fill_in_blank",
      "content": "For any two positive integers m and n, the group Tor_1(Z/mZ, Z/nZ) is cyclic of order equal to the greatest common ___ of m and n.",
      "blankAnswer": "divisor",
      "blankDistractors": ["multiple", "prime", "factor"]
    },
    {
      "slideIndex": 4,
      "type": "numerical",
      "content": "What is the order of the group Tor_1(Z/24Z, Z/36Z)?",
      "numericAnswer": 12.0,
      "numericTolerance": 0.01
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What does the non-zero element in Ext^1_Z(Z/2Z, Z/2Z) ≅ Z/2Z represent?",
      "options": [
        { "text": "The non-split extension 0 -> Z/2Z -> Z/4Z -> Z/2Z -> 0", "isCorrect": true, "explanation": "Correct! Ext^1 classifies extensions: 0 represents the split extension Z/2Z x Z/2Z, and 1 represents the non-split group Z/4Z." },
        { "text": "The direct product Z/2Z x Z/2Z", "isCorrect": false, "explanation": "Incorrect: The direct product is the trivial (split) extension corresponding to 0." },
        { "text": "The Klein four-group V_4", "isCorrect": false, "explanation": "Incorrect: V_4 is isomorphic to Z/2Z x Z/2Z." },
        { "text": "The quaternion group Q_8", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
