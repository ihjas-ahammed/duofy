# Duofy Reusable Lesson Format: Gödel's Second Incompleteness Theorem and Consistency Statements

**Target Topic:** `01_Mathematics_and_Logic / 05_Mathematical_Logic_and_Foundations / Proof_Theory / Godel_Incompleteness_Theorems`  
**Lesson Format Type:** `godel_second_incompleteness_and_consistency_statements`  
**Architectural Rule:** EXACTLY 5 SLIDES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Train students to analyze **Gödel's Second Incompleteness Theorem (G2, 1931)**: formalize the arithmetic consistency sentence $\operatorname{Con}(T) \equiv \neg \operatorname{Prov}_T(\ulcorner 0 = 1 \urcorner)$, evaluate the **Hilbert-Bernays-Löb (HBL) Derivability Conditions**, prove that if $T$ is consistent then $T \not\vdash \operatorname{Con}(T)$ by formalizing G1 inside $T$ ($T \vdash \operatorname{Con}(T) \to G_T$), and explore Gentzen's consistency proof of Peano arithmetic via transfinite induction up to $\varepsilon_0$.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Gödel's Second Incompleteness Theorem Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Formalized Proof of T not |- Con(T) Walkthrough | `concept_pieces` | Encoding (Phase A) | `content` (Sequential worked steps) |
| **Slide 3** | Derivability Condition & Mathematical Statement Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Consistency Sentence Falsehood Formula Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Gentzen's Proof of PA Consistency via Epsilon_0 Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Gödel's Second Incompleteness Theorem (G2, 1931): Let $T$ be a consistent, computably axiomatizable extension of Peano arithmetic $PA$ satisfying the Hilbert-Bernays-Löb derivability conditions. Then $T$ cannot prove its own consistency:
   $$T \not\vdash \operatorname{Con}(T)$$
   where $\operatorname{Con}(T) \equiv \neg \operatorname{Prov}_T(\ulcorner 0 = 1 \urcorner)$ (asserts that $T$ does not prove the contradiction $0 = 1$). State the 3 Hilbert-Bernays-Löb (HBL) Conditions:
   - D1: If $T \vdash \phi$, then $T \vdash \operatorname{Prov}_T(\ulcorner \phi \urcorner)$.
   - D2: $T \vdash \operatorname{Prov}_T(\ulcorner \phi \to \psi \urcorner) \to (\operatorname{Prov}_T(\ulcorner \phi \urcorner) \to \operatorname{Prov}_T(\ulcorner \psi \urcorner))$.
   - D3: $T \vdash \operatorname{Prov}_T(\ulcorner \phi \urcorner) \to \operatorname{Prov}_T(\ulcorner \operatorname{Prov}_T(\ulcorner \phi \urcorner) \urcorner)$.
2. **Slide 2 (`concept_pieces`):** Deconstruct proof of G2: (1) recall that the proof of G1 showed: "If $T$ is consistent, then $T \not\vdash G_T$", (2) express this meta-proof formally inside $T$ using HBL conditions: $T \vdash \operatorname{Con}(T) \to \neg \operatorname{Prov}_T(\ulcorner G_T \urcorner)$, (3) recall by the Diagonal Lemma that $T \vdash G_T \leftrightarrow \neg \operatorname{Prov}_T(\ulcorner G_T \urcorner)$, (4) substitute into implication: $T \vdash \operatorname{Con}(T) \to G_T$, (5) if $T$ could prove its own consistency ($T \vdash \operatorname{Con}(T)$), by Modus Ponens $T$ would prove $G_T$, which violates G1 ($T \not\vdash G_T$), concluding $T \not\vdash \operatorname{Con}(T)$!
3. **Slide 3 (`matching`):** Pair 4 proof-theoretic consistency statements ($\operatorname{Con}(PA)$, $\operatorname{Con}(ZFC)$, Gentzen's Theorem, Inconsistent Theory) with their formal provability status.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the canonical consistency statement asserts the unprovability of the explicit contradiction zero equals one ($0 = 1$). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on Gerhard Gentzen's 1936 Consistency Proof of Peano Arithmetic: How did Gentzen prove $\operatorname{Con}(PA)$ without violating Gödel's Second Incompleteness Theorem? (By stepping outside Peano Arithmetic into a stronger meta-theory: he used transfinite induction up to ordinal $\varepsilon_0$, which cannot be formalized within PA alone, showing that consistency of a theory can only be proven within a strictly stronger system).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "godel_second_incompleteness_and_consistency_statements",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Gödel's Second Incompleteness Theorem (G2, 1931)**\n• **Consistency Sentence $\\operatorname{Con}(T)$:**\n$$\n\\operatorname{Con}(T) \\equiv \\neg \\operatorname{Prov}_T(\\ulcorner 0 = 1 \\urcorner)\n$$\n(Asserts that no integer encodes a proof of the explicit contradiction $0 = 1$).\n• **The Second Incompleteness Theorem (G2):** If formal theory $T$ is consistent, then:\n$$\nT \\not\\vdash \\operatorname{Con}(T)\n$$\n(No consistent formal mathematical system powerful enough to do arithmetic can prove its own consistency!).\n• **Hilbert's Program Failure:** Disproved David Hilbert's dream of proving the consistency of higher mathematics using elementary finitary methods within the system."
    },
    {
      "slideIndex": 2,
      "type": "concept_pieces",
      "content": "• **Step 1 (Formalize First Theorem):** Formalize the proof of G1 ('If $T$ is consistent, $G_T$ is unprovable') inside $T$:\n  $$T \\vdash \\operatorname{Con}(T) \\to \\neg \\operatorname{Prov}_T(\\ulcorner G_T \\urcorner)$$\n• **Step 2 (Apply Gödel Equivalence):** By definition of $G_T$, $T \\vdash G_T \\leftrightarrow \\neg \\operatorname{Prov}_T(\\ulcorner G_T \\urcorner)$.\n• **Step 3 (Derive Core Implication):** Substituting into Step 1 yields:\n  $$T \\vdash \\operatorname{Con}(T) \\to G_T$$\n• **Step 4 (Hypothesize Consistency Proof):** Suppose $T \\vdash \\operatorname{Con}(T)$.\n• **Step 5 (Contradiction with G1):** By Modus Ponens, $T \\vdash G_T$, directly contradicting the First Incompleteness Theorem! Therefore, $T \\not\\vdash \\operatorname{Con}(T)$."
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each consistency theorem to its proof-theoretic meaning.",
      "matchPairs": [
        { "left": "PA not |- Con(PA)", "right": "Peano arithmetic cannot prove its own consistency (G2)" },
        { "left": "ZFC |- Con(PA)", "right": "ZFC set theory easily proves PA is consistent by constructing standard model N" },
        { "left": "ZFC not |- Con(ZFC)", "right": "ZFC cannot prove its own consistency unless ZFC is inconsistent" },
        { "left": "Gentzen's Consistency Proof (1936)", "right": "Proves Con(PA) using transfinite induction up to ordinal epsilon_0 outside PA" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The standard consistency sentence Con(T) is formally written as the arithmetic assertion not Prov_T([___ = 1]).",
      "blankAnswer": "0",
      "blankDistractors": ["1", "2", "x"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "How did Gerhard Gentzen prove the consistency of Peano Arithmetic in 1936 without violating Gödel's Second Incompleteness Theorem?",
      "options": [
        { "text": "Gentzen used TRANSFINITE INDUCTION up to ordinal epsilon_0, a proof principle that exceeds the deductive strength of PA and cannot be formalized within PA alone", "isCorrect": true, "explanation": "Correct! Gödel's theorem states PA cannot prove Con(PA) using only PA's axioms. Gentzen proved Con(PA) by stepping into a strictly stronger meta-theory involving transfinite induction up to epsilon_0." },
        { "text": "Gentzen found a bug in Gödel's math", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Gentzen proved that PA is inconsistent", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Gentzen proved it using a finite truth table", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
