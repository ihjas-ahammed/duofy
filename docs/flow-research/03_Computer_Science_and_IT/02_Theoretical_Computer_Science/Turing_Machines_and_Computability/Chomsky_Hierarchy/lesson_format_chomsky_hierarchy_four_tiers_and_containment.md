# Duofy Reusable Lesson Format: Chomsky Hierarchy (Four Tiers and Containment)

**Target Topic:** `03_Computer_Science_and_IT / 02_Theoretical_Computer_Science / Turing_Machines_and_Computability / Chomsky_Hierarchy`  
**Lesson Format Type:** `chomsky_hierarchy_four_tiers_and_containment`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the formal language taxonomy, grammar production syntax constraints, and computational machine equivalences of the Chomsky Hierarchy (Noam Chomsky 1956, *Three Models for the Description of Language*; Michael Sipser Chapters 1–5): master the **Strict Nested Containment Hierarchy ($\mathbf{\text{Type 3} \subset \text{Type 2} \subset \text{Type 1} \subset \text{Type 0}}$)**, classify the **4 Grammar Production Rule Constraints** (**Type 3 Regular: $A \to aB \mid a$**, **Type 2 Context-Free: $A \to \gamma$ with single non-terminal LHS**, **Type 1 Context-Sensitive: $\alpha A \beta \to \alpha \gamma \beta$ with non-contracting length $|\gamma| \ge |A|$**, and **Type 0 Unrestricted: $\alpha \to \beta$ with no length constraints**), map each tier to its canonical recognizing machine (**Finite Automata $\to$ Pushdown Automata $\to$ Linear Bounded Automata $\to$ Turing Machines**), and identify classic language representatives ($a^* \to a^n b^n \to a^n b^n c^n \to \text{Halting Problem } A_{\text{TM}}$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Chomsky Hierarchy 4 Tiers, Production Constraints, & Machine Taxonomy Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Upward Traversal from Type 3 to Type 0 Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Chomsky Tier / Grammar Constraint & Recognizing Machine Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Chomsky Type Number Designated for Regular Languages Recognized by DFAs (3) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | The Strict Non-Contracting Length Constraint Distinguishing Type 1 from Type 0 Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Chomsky Hierarchy (Chomsky 1956; Sipser):
   - **The Strict 4-Tier Nested Containment:**
     $$\mathbf{\text{Type 3 (Regular)} \subset \text{Type 2 (Context-Free)} \subset \text{Type 1 (Context-Sensitive)} \subset \text{Type 0 (Recursively Enumerable)}}$$
   - **Grammar & Automata Master Matrix:**
     $$\begin{array}{|l|l|l|l|l|}
     \hline
     \textbf{Tier} & \textbf{Language Class} & \textbf{Production Constraint} & \textbf{Automaton} & \textbf{Canonical Example} \\
     \hline
     \mathbf{\text{Type 3}} & \text{Regular} & A \to aB \mid a & \text{Finite Automaton (DFA/NFA)} & a^*b^* \\
     \mathbf{\text{Type 2}} & \text{Context-Free} & A \to \gamma \quad (A \in V) & \text{Pushdown Automaton (PDA)} & a^n b^n \\
     \mathbf{\text{Type 1}} & \text{Context-Sensitive} & \alpha A \beta \to \alpha \gamma \beta \quad (|\alpha\gamma\beta| \ge |\alpha A\beta|) & \text{Linear Bounded Automaton (LBA)} & a^n b^n c^n \\
     \mathbf{\text{Type 0}} & \text{Unrestricted / RE} & \alpha \to \beta \quad (\alpha \ne \varepsilon) & \text{Turing Machine (TM)} & A_{\text{TM}} \ (\text{Halting}) \\
     \hline
     \end{array}$$
   - **Generative Power:** Higher tiers add more computational memory (from 0 bytes $\to$ stack $\to$ bounded tape $\to$ infinite tape).
2. **Slide 2 (`ordering`):** Provide 5 steps of the Chomsky hierarchy ordered from most restricted (Type 3) to most powerful (Type 0 / All): (1) Type 3 Regular Languages recognized by memory-less Finite State Automata with linear production rules, (2) Type 2 Context-Free Languages recognized by single-stack Pushdown Automata with single-variable LHS rules, (3) Type 1 Context-Sensitive Languages recognized by Linear Bounded Automata with non-contracting production rules, (4) Recursive Decidable Languages recognized by Turing Machines that always halt on all inputs, (5) Type 0 Recursively Enumerable Languages recognized by unrestricted Turing Machines with arbitrary rewrite rules!
3. **Slide 3 (`matching`):** Pair 4 Chomsky tiers (Type 3 Regular DFA, Type 2 Context-Free PDA, Type 1 Context-Sensitive LBA, Type 0 Recursively Enumerable TM) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that Regular Languages correspond to Type 3 in the Chomsky hierarchy. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the formal mathematical constraint that separates Type 1 (Context-Sensitive) from Type 0 (Unrestricted): What is the precise structural constraint imposed on production rules $\alpha \to \beta$ in a Type 1 (Context-Sensitive) grammar that is completely absent in a Type 0 (Unrestricted) grammar? (In a Type 1 grammar, every production rule $\alpha \to \beta$ must be **non-contracting, meaning the length of the right-hand side is greater than or equal to the length of the left-hand side ($|\beta| \ge |\alpha|$)**, preventing string length reduction during derivations; Type 0 imposes **zero length restrictions ($\alpha \to \beta$ where $|\beta|$ can be smaller than $|\alpha|$ or even $\varepsilon$)**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "chomsky_hierarchy_four_tiers_and_containment",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Chomsky Hierarchy (Noam Chomsky 1956)**\n• **The 4-Tier Nested Containment:**\n$$\n\\mathbf{\\text{Type 3 (Regular)} \\subset \\text{Type 2 (Context-Free)} \\subset \\text{Type 1 (Context-Sensitive)} \\subset \\text{Type 0 (RE)}}\n$$\n• **The Formal Production Rules & Machines:**\n$$\n\\begin{array}{|l|l|l|l|}\n\\hline\n\\textbf{Type} & \\textbf{Grammar Production Rule} & \\textbf{Recognizing Machine} & \\textbf{Example Language} \\\\\n\\hline\n\\mathbf{\\text{Type 3}} & A \\to aB \\mid a & \\text{Finite Automaton (DFA)} & L = \\{a^n b^m\\} \\\\\n\\mathbf{\\text{Type 2}} & A \\to \\gamma \\quad (A \\in V) & \\text{Pushdown Automaton (PDA)} & L = \\{a^n b^n\\} \\\\\n\\mathbf{\\text{Type 1}} & \\alpha A \\beta \\to \\alpha \\gamma \\beta \\quad (|\\gamma| \\ge |A|) & \\text{Linear Bounded Automaton (LBA)} & L = \\{a^n b^n c^n\\} \\\\\n\\mathbf{\\text{Type 0}} & \\alpha \\to \\beta \\quad (\\text{Unrestricted}) & \\text{Turing Machine (TM)} & L = A_{\\text{TM}} \\text{ (Halting)} \\\\\n\\hline\n\\end{array}\n$$\n• **Memory Ladder:** Finite State (0) $\\to$ Stack $\\to$ Bounded Tape ($k\\cdot n$) $\\to$ Infinite Tape!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the language classes in the Chomsky Hierarchy from most restricted (lowest generative power) to most powerful.",
      "orderItems": [
        "Type 3: Regular Languages generated by right-linear grammars and recognized by Finite State Automata",
        "Type 2: Context-Free Languages generated by single-variable LHS grammars and recognized by Pushdown Automata",
        "Type 1: Context-Sensitive Languages generated by non-contracting grammars and recognized by Linear Bounded Automata",
        "Recursive (Decidable) Languages recognized by Turing Machines that are guaranteed to halt on all inputs",
        "Type 0: Recursively Enumerable Languages generated by unrestricted grammars and recognized by Turing Machines"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Chomsky Hierarchy tier to its exact machine model and grammar constraint.",
      "matchPairs": [
        { "left": "Type 3 (Regular)", "right": "Finite Automaton (DFA/NFA) with right-linear production rules A -> a B | a" },
        { "left": "Type 2 (Context-Free)", "right": "Pushdown Automaton (PDA) with single non-terminal LHS production rules A -> gamma" },
        { "left": "Type 1 (Context-Sensitive)", "right": "Linear Bounded Automaton (LBA) with non-contracting productions |RHS| >= |LHS|" },
        { "left": "Type 0 (Recursively Enumerable)", "right": "Unrestricted Turing Machine with arbitrary string rewrite rules alpha -> beta" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the Chomsky Hierarchy, Regular Languages recognized by finite state automata are classified as Type ___.",
      "blankAnswer": "3",
      "blankDistractors": ["2", "1", "0"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the precise structural constraint imposed on production rules in a Type 1 (Context-Sensitive) grammar that is absent in a Type 0 (Unrestricted) grammar?",
      "options": [
        { "text": "In a Type 1 Context-Sensitive grammar, every production rule alpha -> beta must be strictly non-contracting, meaning the length of the right-hand side must be greater than or equal to the length of the left-hand side (|beta| >= |alpha|), preventing the string from shrinking during derivation; in Type 0 grammars, there are no length restrictions whatsoever, permitting rules where |beta| < |alpha| or beta = epsilon", "isCorrect": true, "explanation": "Correct! This non-contracting property is the foundational definition of Context-Sensitive Grammars (Chomsky 1956; Sipser Chapter 5). In a Type 1 grammar, production rules take the form $\\alpha A \\beta \\to \\alpha \\gamma \\beta$ where $\\gamma \\ne \\varepsilon$ (or in monotonic grammars, $\\alpha \\to \\beta$ where $|\\beta| \\ge |\\alpha|$). Because the length of the sentential form can NEVER decrease during derivation, any derivation of a terminal string $w$ of length $n = |w|$ can only involve sentential forms of length at most $n$. This property allows an automaton to decide membership by exploring a finite search space of bounded string lengths, which is why Type 1 languages are recognized by Linear Bounded Automata (tape bounded by $k \\cdot n$) and have a DECIDABLE membership problem. In Type 0 (Unrestricted) grammars, rules like $AB \\to \\varepsilon$ or $ABC \\to D$ are permitted. Strings can grow arbitrarily large and then shrink back down to $w$, creating an infinite search space that makes Type 0 membership UNDECIDABLE." },
        { "text": "Type 1 grammars forbid all terminal characters", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Type 1 grammars require all rules to have exactly 1 variable on the right-hand side", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Type 1 grammars only allow strings of length 10 or less", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
