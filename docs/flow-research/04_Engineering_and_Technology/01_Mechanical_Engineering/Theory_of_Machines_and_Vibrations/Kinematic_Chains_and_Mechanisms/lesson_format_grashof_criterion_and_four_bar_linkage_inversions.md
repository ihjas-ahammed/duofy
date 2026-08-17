# Duofy Reusable Lesson Format: Four-Bar Linkages (Grashof Criterion & Inversions)

**Target Topic:** `04_Engineering_and_Technology / 01_Mechanical_Engineering / Theory_of_Machines_and_Vibrations / Kinematic_Chains_and_Mechanisms`  
**Lesson Format Type:** `grashof_criterion_and_four_bar_linkage_inversions`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through planar four-bar linkage synthesis, rotatability conditions, and kinematic inversions in machine design (Franz Grashof 1883; Joseph E. Shigley et al. *Theory of Machines and Mechanisms* Chapter 1 & 2; Kenneth J. Waldron & Gary L. Kinzel Chapter 3): master **Grashof's Rotatability Criterion for Planar Four-Bar Linkages**:
$$\mathbf{s + l \le p + q}$$
where $s$ is the length of the shortest link, $l$ is the length of the longest link, and $p, q$ are the lengths of the two intermediate links; master the **Four Fundamental Grashof Inversions (Class I)**:
1. **Crank-Rocker Mechanism:** Grounding a link **adjacent to the shortest link $s$** allows link $s$ to rotate through a complete $360^\circ$ circle (acting as the driving crank) while the opposite grounded link oscillates back and forth as a rocker;
2. **Double-Crank (Drag-Link) Mechanism:** Grounding the **shortest link $s$** allows **both input and output grounded links to make full $360^\circ$ continuous revolutions**;
3. **Double-Rocker Mechanism:** Grounding the link **opposite to the shortest link $s$** forces both grounded links to oscillate as rockers while the floating coupler link $s$ completes full $360^\circ$ continuous revolutions;
and contrast with **Non-Grashof Linkages (Class II, $\mathbf{s + l > p + q}$)** where **no single link can make a complete $360^\circ$ revolution** (Triple Rocker).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Grashof's Law ($s + l \le p + q$) & 4-Bar Inversion Classification Matrix Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Sizing and Inversion Determination for a Planar Four-Bar Linkage Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Grounded Link Selection / Grashof Condition & Resulting Mechanism Type Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In a Grashof Four-Bar Linkage, Fixing the Shortest Link (s) as the Ground Frame Produces a Double-___ Mechanism (Crank / Drag-Link) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mechanism Synthesis Problem: Classifying a Four-Bar Linkage with Specific Link Lengths Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Grashof's Law (Shigley 2014; Grashof 1883):
   - **Grashof's Condition Formulation:**
     $$\mathbf{s + l \le p + q \quad (s = \text{shortest link}, \ l = \text{longest link})}$$
   - **The Four-Bar Inversion Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Grashof Criterion} & \textbf{Fixed Ground Link} & \textbf{Mechanism Name} & \textbf{Kinematic Motion Mode} \\
     \hline
     \mathbf{s + l \le p + q} & \mathbf{\text{Adjacent to Shortest }} s & \mathbf{\text{Crank-Rocker}} & \text{Shortest link rotates } 360^\circ \text{ (Crank); other link rocks} \\
     \mathbf{s + l \le p + q} & \mathbf{\text{Shortest Link }} s & \mathbf{\text{Double-Crank (Drag-Link)}} & \mathbf{\text{Both connected links make complete } 360^\circ \text{ revolutions}} \\
     \mathbf{s + l \le p + q} & \mathbf{\text{Opposite to Shortest }} s & \mathbf{\text{Double-Rocker}} & \text{Both grounded links oscillate; coupler } s \text{ makes } 360^\circ \text{ turns} \\
     s + l > p + q & \text{Any Link Fixed} & \text{Triple-Rocker (Class II)} & \text{Zero links can complete a full } 360^\circ \text{ rotation} \\
     \hline
     \end{array}$$
   - **The Continuous Rotation Invariant:** In any Class I Grashof linkage ($s+l \le p+q$), the **shortest link $s$ ALWAYS makes a complete $360^\circ$ revolution** relative to all three other links!
2. **Slide 2 (`ordering`):** Provide 5 steps of four-bar linkage analysis: (1) measure or obtain the four link lengths $L_1, L_2, L_3, L_4$, (2) sort the link lengths to identify the shortest ($s$), longest ($l$), and intermediate ($p, q$) links, (3) test Grashof's condition by evaluating the sum $s + l$ versus $p + q$, (4) if $s+l \le p+q$, inspect which specific link is fixed to the ground frame, (5) classify the resulting mechanism as Crank-Rocker, Double-Crank, Double-Rocker, or Triple-Rocker!
3. **Slide 3 (`matching`):** Pair 4 concepts (Fixed link adjacent to $s$, Fixed link is $s$, Fixed link opposite to $s$, Non-Grashof $s+l > p+q$) with their mechanism types.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Crank. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on classifying four-bar linkage: A planar four-bar linkage has link lengths $L_1 = 30\text{ mm}$, $L_2 = 70\text{ mm}$, $L_3 = 90\text{ mm}$, and $L_4 = 110\text{ mm}$. Link $L_1$ is the fixed ground frame. What type of mechanism does this arrangement form? (Sort lengths: $s = L_1 = 30\text{ mm}$, $l = L_4 = 110\text{ mm}$, $p = L_2 = 70\text{ mm}$, $q = L_3 = 90\text{ mm}$; Sums: $s + l = 30 + 110 = 140\text{ mm}$; $p + q = 70 + 90 = 160\text{ mm}$; Since $s + l = 140 \le p + q = 160$, it satisfies Grashof's criterion (Class I); Because the **shortest link $s = L_1 = 30\text{ mm}$ is the fixed ground link**, both input and output links $L_2$ and $L_4$ can make complete $360^\circ$ continuous revolutions, forming a **Double-Crank (Drag-Link) Mechanism**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "grashof_criterion_and_four_bar_linkage_inversions",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Grashof's Law \\& Four-Bar Linkage Inversions (Franz Grashof 1883)**\n• **The Grashof Inequality Formulation:**\n$$\n\\mathbf{s + l \\le p + q \\quad (s = \\text{shortest link}, \\ l = \\text{longest link}, \\ p, q = \\text{intermediate links})}\n$$\n• **The Four-Bar Kinematic Inversion Matrix:**\n$$\n\\begin{array}{|l|l|l|l|}\n\\hline\n\\textbf{Grashof Criterion} & \\textbf{Fixed Ground Link} & \\textbf{Kinematic Mechanism} & \\textbf{Rotational Motion Mode} \\\\\n\\hline\n\\mathbf{s + l \\le p + q} & \\mathbf{\\text{Adjacent to Shortest }} s & \\mathbf{\\text{Crank-Rocker}} & \\text{Link } s \\text{ rotates } 360^\\circ \\text{ (Crank); other link oscillates} \\\\\n\\mathbf{s + l \\le p + q} & \\mathbf{\\text{Shortest Link }} s & \\mathbf{\\text{Double-Crank (Drag-Link)}} & \\mathbf{\\text{Both connected links make complete } 360^\\circ \\text{ revolutions}} \\\\\n\\mathbf{s + l \\le p + q} & \\mathbf{\\text{Opposite to Shortest }} s & \\mathbf{\\text{Double-Rocker}} & \\text{Both grounded links oscillate; coupler } s \\text{ rotates } 360^\\circ \\\\\n\\mathbf{s + l > p + q} & \\text{Any Link Fixed} & \\text{Triple-Rocker (Class II)} & \\text{Zero links can complete a full } 360^\\circ \\text{ rotation} \\\\\n\\hline\n\\end{array}\n$$\n• **The Rotational Invariant:** In any Class I Grashof linkage ($s+l \\le p+q$), the **shortest link $s$ ALWAYS makes a full $360^\\circ$ rotation** relative to all other links!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to determine whether a four-bar linkage satisfies Grashof's criterion and classify its kinematic inversion.",
      "orderItems": [
        "Record the physical lengths of all four rigid links: L1, L2, L3, and L4",
        "Sort the link lengths to identify the shortest link (s), longest link (l), and intermediate links (p and q)",
        "Evaluate Grashof's inequality: compute (s + l) and compare it against (p + q)",
        "If s + l <= p + q, determine the geometric position of the fixed ground link relative to shortest link s",
        "Classify the mechanism: Crank-Rocker (adjacent to s fixed), Double-Crank (s fixed), or Double-Rocker (opposite s fixed)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Ground Link Selection in a Grashof Linkage to its exact Mechanism Behavior.",
      "matchPairs": [
        { "left": "Fixed Link Adjacent to Shortest Link (s)", "right": "Crank-Rocker Mechanism (shortest link undergoes continuous 360° rotation while opposite rocks)" },
        { "left": "Fixed Link Is the Shortest Link (s)", "right": "Double-Crank / Drag-Link Mechanism (both connected grounded links make continuous 360° rotations)" },
        { "left": "Fixed Link Opposite to Shortest Link (s)", "right": "Double-Rocker Mechanism (both grounded links oscillate while coupler link s rotates 360°)" },
        { "left": "Non-Grashof Linkage (s + l > p + q)", "right": "Triple-Rocker Mechanism (no link in the kinematic chain can complete a full 360° revolution)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In a Grashof four-bar linkage, fixing the shortest link (s) as the ground frame produces a double-___ mechanism.",
      "blankAnswer": "crank",
      "blankDistractors": ["rocker", "slider", "cam"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A planar four-bar linkage has link lengths L1 = 30 mm, L2 = 70 mm, L3 = 90 mm, and L4 = 110 mm. Link L1 (length 30 mm) is chosen as the fixed ground frame. What kinematic mechanism does this assembly form?",
      "options": [
        { "text": "A Double-Crank (Drag-Link) Mechanism (because s + l = 30 + 110 = 140 mm <= p + q = 70 + 90 = 160 mm, and the shortest link s = L1 = 30 mm is the fixed ground link)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using Grashof's Law (Shigley *Theory of Machines and Mechanisms* Chapter 1). 1. **Identify the Link Lengths:** - Shortest link: $s = L_1 = 30\\text{ mm}$. - Longest link: $l = L_4 = 110\\text{ mm}$. - Intermediate links: $p = L_2 = 70\\text{ mm}$ and $q = L_3 = 90\\text{ mm}$. 2. **Check Grashof's Inequality:** - $s + l = 30\\text{ mm} + 110\\text{ mm} = \\mathbf{140\\text{ mm}}$. - $p + q = 70\\text{ mm} + 90\\text{ mm} = \\mathbf{160\\text{ mm}}$. - Since $s + l (140\\text{ mm}) \\le p + q (160\\text{ mm})$, this is a **Class I Grashof Linkage** (continuous rotation is guaranteed!). 3. **Identify the Inversion (Fixed Link):** - The fixed ground link is $L_1 = 30\\text{ mm}$, which is the **Shortest Link ($s$)**! - Grashof Inversion Rule: Fixing the shortest link $s$ produces a **Double-Crank (Drag-Link) Mechanism**, where both links connected to ground ($L_2$ and $L_4$) can make **complete $360^\\circ$ continuous revolutions**!" },
        { "text": "A Crank-Rocker Mechanism", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "A Double-Rocker Mechanism", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "A Triple-Rocker Mechanism (Non-Grashof)", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
