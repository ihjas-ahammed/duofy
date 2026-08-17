# Duofy Reusable Lesson Format: Addition of Angular Momenta and Clebsch-Gordan Coefficients

**Target Topic:** `02_Physical_and_Life_Sciences / 01_Physics / Quantum_Mechanics / Angular_Momentum_and_Spin`  
**Lesson Format Type:** `addition_of_angular_momenta_and_clebsch_gordan`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the quantum addition of angular momenta: couple two subsystems $\mathbf{J} = \mathbf{J}_1 + \mathbf{J}_2$, formulate the **Triangle Inequality ($|j_1 - j_2| \le J \le j_1 + j_2$)**, transform between **Uncoupled Basis ($|j_1, m_1, j_2, m_2\rangle$)** and **Coupled Basis ($|j_1, j_2, J, M\rangle$)**, compute **Clebsch-Gordan Coefficients ($\langle j_1 m_1 j_2 m_2 | J M \rangle$)** using ladder operator lowering techniques, and construct **Singlet ($S=0$) and Triplet ($S=1$)** wavefunctions for two spin-1/2 particles.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Addition of Angular Momenta & Clebsch-Gordan Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Triplet-to-Singlet Ladder Operator Derivation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Coupled State |J, M> & Uncoupled Expansion Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Two Spin-1/2 Singlet State Total Spin S Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Clebsch-Gordan Selection Rules and Triangle Condition Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State the Theory of Angular Momentum Addition ($\mathbf{J} = \mathbf{J}_1 + \mathbf{J}_2$):
   - **Allowed Total Quantum Numbers:**
     $$|j_1 - j_2| \le J \le j_1 + j_2, \qquad M = m_1 + m_2$$
     - Dimension Check: $\sum_{J=|j_1-j_2|}^{j_1+j_2} (2J + 1) = (2j_1 + 1)(2j_2 + 1)$.
   - **Transformation via Clebsch-Gordan Coefficients:**
     $$|J, M\rangle = \sum_{m_1, m_2} \langle j_1, m_1, j_2, m_2 | J, M \rangle \, |j_1, m_1\rangle |j_2, m_2\rangle$$
   - **Coupling Two Spin-1/2 Particles ($1/2 \otimes 1/2 = 1 \oplus 0$):**
     - **Triplet ($S = 1$, Symmetric under exchange):**
       $$|1, +1\rangle = |\uparrow\uparrow\rangle, \quad |1, 0\rangle = \frac{|\uparrow\downarrow\rangle + |\downarrow\uparrow\rangle}{\sqrt{2}}, \quad |1, -1\rangle = |\downarrow\downarrow\rangle$$
     - **Singlet ($S = 0$, Antisymmetric under exchange):**
       $$|0, 0\rangle = \frac{|\uparrow\downarrow\rangle - |\downarrow\uparrow\rangle}{\sqrt{2}}$$
2. **Slide 2 (`ordering`):** Provide 5 steps constructing $|1, 0\rangle$ and $|0, 0\rangle$ using lowering operator $\hat{J}_- = \hat{J}_{1-} + \hat{J}_{2-}$: (1) start with top state: $|1, 1\rangle = |\uparrow\uparrow\rangle$, (2) apply total lowering operator: $\hat{J}_- |1, 1\rangle = \hbar\sqrt{1(2)-1(0)} |1, 0\rangle = \sqrt{2}\hbar |1, 0\rangle$, (3) apply component lowering operators to RHS: $(\hat{J}_{1-} + \hat{J}_{2-})|\uparrow\uparrow\rangle = \hbar|\downarrow\uparrow\rangle + \hbar|\uparrow\downarrow\rangle$, (4) equate both sides to obtain normalized triplet state $|1, 0\rangle = \frac{1}{\sqrt{2}}(|\uparrow\downarrow\rangle + |\downarrow\uparrow\rangle)$, (5) construct the unique orthogonal state with $M = 0$ to obtain singlet $|0, 0\rangle = \frac{1}{\sqrt{2}}(|\uparrow\downarrow\rangle - |\downarrow\uparrow\rangle)$!
3. **Slide 3 (`matching`):** Pair 4 coupled states ($|1, +1\rangle$, $|1, 0\rangle$, $|1, -1\rangle$, $|0, 0\rangle$) with their uncoupled spinor expansions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the antisymmetric singlet state of two spin-1/2 particles has a total spin quantum number S equal to 0. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on Clebsch-Gordan Selection Rules: For combining an orbital angular momentum $l = 2$ and spin $s = 1$, what are the allowed values of total angular momentum $J$, and what selection rule governs non-zero Clebsch-Gordan coefficients? ($J \in \{1, 2, 3\}$, and Clebsch-Gordan coefficients $\langle j_1 m_1 j_2 m_2 | J M \rangle$ are strictly zero unless $M = m_1 + m_2$ and $|j_1 - j_2| \le J \le j_1 + j_2$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "addition_of_angular_momenta_and_clebsch_gordan",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Addition of Angular Momenta and Clebsch-Gordan Coefficients**\n• **Coupled Vector Operator:** $\\hat{\\mathbf{J}} = \\hat{\\mathbf{J}}_1 + \\hat{\\mathbf{J}}_2$.\n• **Allowed Total Angular Momentum Spectrum:**\n$$\n|j_1 - j_2| \\le J \\le j_1 + j_2, \\qquad M = m_1 + m_2\n$$\n• **Clebsch-Gordan Expansion:**\n$$\n|J, M\\rangle = \\sum_{m_1, m_2} \\langle j_1 m_1 j_2 m_2 | J M \\rangle \\, |j_1 m_1\\rangle |j_2 m_2\\rangle\n$$\n• **Two Spin-1/2 Particles ($1/2 \\otimes 1/2 = 1 \\oplus 0$):**\n  - **Triplet ($S = 1$, 3 states, symmetric):**\n    $|1, 1\\rangle = |\\uparrow\\uparrow\\rangle, \\quad |1, 0\\rangle = \\frac{|\\uparrow\\downarrow\\rangle + |\\downarrow\\uparrow\\rangle}{\\sqrt{2}}, \\quad |1, -1\\rangle = |\\downarrow\\downarrow\\rangle$.\n  - **Singlet ($S = 0$, 1 state, antisymmetric):**\n    $|0, 0\\rangle = \\frac{|\\uparrow\\downarrow\\rangle - |\\downarrow\\uparrow\\rangle}{\\sqrt{2}}$."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the ladder operator steps deriving the spin triplet |1, 0> and singlet |0, 0> states.",
      "orderItems": [
        "Identify the unique maximal stretch state: |J=1, M=1> = |spin1_up, spin2_up> = |up, up>",
        "Apply total lowering operator J_- = J_1- + J_2- to the LHS to yield sqrt(2) * hbar * |1, 0>",
        "Apply individual lowering operators to the RHS product state: hbar * |down, up> + hbar * |up, down>",
        "Equate both sides to determine the symmetric triplet state: |1, 0> = (1 / sqrt(2)) * ( |up, down> + |down, up> )",
        "Construct the orthogonal linear combination with M = 0 to establish the antisymmetric singlet state: |0, 0> = (1 / sqrt(2)) * ( |up, down> - |down, up> )"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each coupled two-spin state |S, M> to its uncoupled representation.",
      "matchPairs": [
        { "left": "|1, +1> (Triplet Up)", "right": "|up, up>" },
        { "left": "|1, 0> (Triplet Zero)", "right": "(1 / sqrt(2)) * ( |up, down> + |down, up> )" },
        { "left": "|1, -1> (Triplet Down)", "right": "|down, down>" },
        { "left": "|0, 0> (Singlet)", "right": "(1 / sqrt(2)) * ( |up, down> - |down, up> )" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The antisymmetric spin singlet state of two electrons has a total spin quantum number S equal to ___.",
      "blankAnswer": "0",
      "blankDistractors": ["1", "1/2", "2"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "When coupling an orbital angular momentum l = 2 with an electron spin s = 1/2, what are the allowed total angular momentum values J?",
      "options": [
        { "text": "J = 5/2 and J = 3/2 (obtained from |2 - 1/2| <= J <= 2 + 1/2), with total dimension (2*5/2 + 1) + (2*3/2 + 1) = 6 + 4 = 10 states", "isCorrect": true, "explanation": "Correct! Applying the triangle inequality for j1 = 2 and j2 = 1/2 yields J ranging in integer steps from |2 - 1/2| = 3/2 to 2 + 1/2 = 5/2. The total number of states is (2*2+1)*(2*1/2+1) = 5*2 = 10, perfectly matching 6 + 4." },
        { "text": "J = 2 only", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "J = 1, 2, 3", "isCorrect": false, "explanation": "Incorrect: Half-integer steps are required when combining integer with half-integer." },
        { "text": "J = 0", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
