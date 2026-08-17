# Duofy Reusable Lesson Format: Functional Dependencies, Armstrong's Axioms, and Attribute Closure

**Target Topic:** `03_Computer_Science_and_IT / 04_Database_Management_Systems / Relational_Databases_and_SQL / Normalization_1NF_to_5NF_and_BCNF`  
**Lesson Format Type:** `functional_dependencies_armstrongs_axioms_and_attribute_closure`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the formal mathematical definitions of functional dependencies, inference rules, and polynomial closure algorithms in relational database theory (William W. Armstrong 1974, *Dependency Structures of Data Base Relationships*, IFIP; Elmasri & Navathe *Fundamentals of Database Systems* Chapter 14.1–14.2; Silberschatz et al. Chapter 7.3): define **Functional Dependency ($X \to Y$)** as a semantic assertion where tuple equality on attribute set $X$ forces equality on $Y$ ($\forall t_1, t_2 \in r(R), \ t_1[X] = t_2[X] \implies t_1[Y] = t_2[Y]$), master **Armstrong's 3 Sound and Complete Axioms** (**Reflexivity: $Y \subseteq X \implies X \to Y$**, **Augmentation: $X \to Y \implies XZ \to YZ$**, and **Transitivity: $X \to Y \land Y \to Z \implies X \to Z$**), execute the **Attribute Closure Algorithm ($\mathbf{X^+}$)** in $O(|F| \cdot |R|)$ time, and derive all **Candidate Keys** (minimal superkeys) for a relation.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Functional Dependency Definition, Armstrong's Axioms, & Attribute Closure Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Computation of Attribute Closure {A}+ Under Set of FDs Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Armstrong Axiom / Derived Rule & Mathematical Inference Law Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Name of the Smallest Minimal Superkey Containing No Proper Subset Superkey (Candidate) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Derivation of All Candidate Keys for a Given Relation R(A, B, C, D) Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Functional Dependencies & Armstrong's Axioms (Armstrong 1974; Elmasri & Navathe 14.1–14.2):
   - **Functional Dependency ($X \to Y$):**
     $$\mathbf{\forall t_1, t_2 \in r(R): \ t_1[X] = t_2[X] \implies t_1[Y] = t_2[Y]}$$
   - **Armstrong's 3 Fundamental Axioms (Sound and Complete):**
     1. **Reflexivity:** If $Y \subseteq X \implies \mathbf{X \to Y}$.
     2. **Augmentation:** If $X \to Y \implies \mathbf{XZ \to YZ}$.
     3. **Transitivity:** If $X \to Y$ and $Y \to Z \implies \mathbf{X \to Z}$.
   - **Derived Inference Rules:**
     - Union Rule: $X \to Y \land X \to Z \implies X \to YZ$.
     - Decomposition Rule: $X \to YZ \implies X \to Y \land X \to Z$.
     - Pseudotransitivity: $X \to Y \land WY \to Z \implies WX \to Z$.
   - **Attribute Closure Algorithm ($X^+$):**
     - Initialize $X^+ = X$.
     - Repeat: If $U \to V \in F$ and $U \subseteq X^+ \implies X^+ = X^+ \cup V$ until no changes.
     - **Superkey Rule:** If $X^+ = R \implies X$ is a Superkey!
2. **Slide 2 (`ordering`):** Provide 5 steps of computing attribute closure $\{A\}^+$ for relation $R(A, B, C, D, E)$ with FDs $\{A \to B, \ B \to C, \ C \to D, \ D \to E\}$: (1) initialize result set closure with starting attribute: Closure = {A}, (2) scan FDs: find A -> B where LHS {A} is in Closure; update Closure = {A, B}, (3) scan FDs: find B -> C where LHS {B} is in Closure; update Closure = {A, B, C}, (4) scan FDs: find C -> D where LHS {C} is in Closure; update Closure = {A, B, C, D}, (5) scan FDs: find D -> E where LHS {D} is in Closure; update Closure = {A, B, C, D, E} = R, proving A is a Candidate Key!
3. **Slide 3 (`matching`):** Pair 4 inference rules (Reflexivity, Augmentation, Transitivity, Decomposition Rule) with their formulas.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of the candidate key term. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on computing candidate keys: Relation $R(A, B, C, D)$ has the functional dependency set $F = \{A \to B, \ B \to C, \ C \to D, \ D \to A\}$. What are all the Candidate Keys of relation $R$? (Compute closures: $\{A\}^+ = \{A, B, C, D\}$; $\{B\}^+ = \{B, C, D, A\}$; $\{C\}^+ = \{C, D, A, B\}$; $\{D\}^+ = \{D, A, B, C\}$; because every single attribute forms a cycle that determines all other attributes, and each is minimal (size 1), the candidate keys are **$\{A\}, \{B\}, \{C\}, \{D\}$ (all four individual attributes are candidate keys)**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "functional_dependencies_armstrongs_axioms_and_attribute_closure",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Functional Dependencies & Armstrong's Axioms (1974)**\n• **Formal FD Invariant ($X \\to Y$):**\n$$\n\\mathbf{\\forall t_1, t_2 \\in r(R): \\quad t_1[X] = t_2[X] \\implies t_1[Y] = t_2[Y]}\n$$\n• **Armstrong's 3 Sound \\& Complete Axioms (William Armstrong):**\n$$\n\\begin{array}{|l|l|}\n\\hline\n\\textbf{Axiom} & \\textbf{Mathematical Inference Rule} \\\\\n\\hline\n\\mathbf{\\text{Reflexivity}} & \\text{If } Y \\subseteq X \\implies \\mathbf{X \\to Y} \\\\\n\\mathbf{\\text{Augmentation}} & \\text{If } X \\to Y \\implies \\mathbf{XZ \\to YZ} \\\\\n\\mathbf{\\text{Transitivity}} & \\text{If } X \\to Y \\ \\land \\ Y \\to Z \\implies \\mathbf{X \\to Z} \\\\\n\\hline\n\\end{array}\n$$\n• **Attribute Closure Algorithm ($X^+$):** If $\\mathbf{X^+ = R} \\implies X$ is a **Superkey**! If no proper subset of $X$ is a superkey $\\implies X$ is a **Candidate Key**."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential expansion steps of computing the attribute closure {A}+ on R(A,B,C,D,E) with FDs {A->B, B->C, C->D, D->E}.",
      "orderItems": [
        "Initialize the working closure set with the starting attribute: Closure = {A}",
        "Examine dependency A -> B: since LHS {A} is in Closure, expand Closure = {A, B}",
        "Examine dependency B -> C: since LHS {B} is in Closure, expand Closure = {A, B, C}",
        "Examine dependency C -> D: since LHS {C} is in Closure, expand Closure = {A, B, C, D}",
        "Examine dependency D -> E: since LHS {D} is in Closure, expand Closure = {A, B, C, D, E} = R, proving A is a Candidate Key"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Functional Dependency Inference Rule to its exact formal equation.",
      "matchPairs": [
        { "left": "Reflexivity Axiom", "right": "If Y is a subset of X, then X -> Y holds unconditionally" },
        { "left": "Augmentation Axiom", "right": "If X -> Y holds, then XZ -> YZ holds for any arbitrary attribute set Z" },
        { "left": "Transitivity Axiom", "right": "If X -> Y and Y -> Z both hold, then X -> Z logically follows" },
        { "left": "Decomposition Rule", "right": "If X -> YZ holds, then X -> Y and X -> Z both independently hold" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "A minimal superkey that contains no proper subset capable of uniquely identifying all tuples is a ___ key.",
      "blankAnswer": "candidate",
      "blankDistractors": ["foreign", "composite", "surrogate"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A relation R(A, B, C, D) is governed by the set of functional dependencies F = {A -> B, B -> C, C -> D, D -> A}. What are all the Candidate Keys of relation R?",
      "options": [
        { "text": "{A}, {B}, {C}, and {D}; computing attribute closures reveals: {A}+ = {A,B,C,D}, {B}+ = {B,C,D,A}, {C}+ = {C,D,A,B}, and {D}+ = {D,A,B,C}; because each single individual attribute determines all attributes of R and each is minimal (cardinality 1), all four individual attributes are candidate keys", "isCorrect": true, "explanation": "Correct! This is a classic functional dependency closure calculation problem (Elmasri & Navathe Section 14.2.3). 1. Given relation $R(A, B, C, D)$ and dependencies $F = \\{A \\to B, \\ B \\to C, \\ C \\to D, \\ D \\to A\\}$. 2. Compute closures for all single attributes: - $\\{A\\}^+$: Start with $\\{A\\}$. $A \\to B \\implies \\{A, B\\}$. $B \\to C \\implies \\{A, B, C\\}$. $C \\to D \\implies \\{A, B, C, D\\} = R$. Thus, $\\{A\\}$ is a superkey. - $\\{B\\}^+$: Start with $\\{B\\}$. $B \\to C \\implies \\{B, C\\}$. $C \\to D \\implies \\{B, C, D\\}$. $D \\to A \\implies \\{B, C, D, A\\} = R$. Thus, $\\{B\\}$ is a superkey. - $\\{C\\}^+$: Start with $\\{C\\}$. $C \\to D \\to A \\to B \\implies \\{C, D, A, B\\} = R$. Thus, $\\{C\\}$ is a superkey. - $\\{D\\}^+$: Start with $\\{D\\}$. $D \\to A \\to B \\to C \\implies \\{D, A, B, C\\} = R$. Thus, $\\{D\\}$ is a superkey. 3. Since every single attribute has size 1, none of them have any proper non-empty subsets. Therefore, all 4 single attributes are strictly minimal superkeys, meaning $\\{A\\}, \\{B\\}, \\{C\\}, \\{D\\}$ are all Candidate Keys!" },
        { "text": "{A, B, C, D} is the only candidate key", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "{A} is the only candidate key", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "{A, B} and {C, D} are the candidate keys", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
