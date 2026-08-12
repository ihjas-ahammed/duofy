# Key to Flow: Theoretical Computer Science

**Subject Area:** `03_Computer_Science_and_IT / 02_Theoretical_Computer_Science`

---

## 📌 Core Concept & Mental Model
Theoretical Computer Science explores the mathematical limits of computation, formal languages, automata, and compiler construction.

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. Chomsky Hierarchy of Languages & Automata
| Language Class | Automata Model | Grammar Type | Example |
| :--- | :--- | :--- | :--- |
| **Regular** | Deterministic / Non-Deterministic Finite Automata (DFA/NFA) | Regular Grammar | $a^* b^n$ |
| **Context-Free** | Pushdown Automata (PDA) | Context-Free Grammar (CFG) | $a^n b^n$ |
| **Context-Sensitive** | Linear-Bounded Automata (LBA) | Context-Sensitive Grammar | $a^n b^n c^n$ |
| **Recursively Enumerable** | Turing Machine | Unrestricted Grammar | Halting Problem |

### 2. Compiler Pipeline Stages
1. **Lexical Analysis (Scanner):** Converts source code characters into Tokens using Regular Expressions & DFAs.
2. **Syntax Analysis (Parser):** Builds Abstract Syntax Trees (AST) using CFGs and LL(k) or LR(k) parsers.
3. **Semantic Analysis:** Type checking and symbol table management.
4. **Intermediate Code Gen & Optimization:** 3-Address Code, dead code elimination, loop unrolling.
5. **Code Generation:** Assembly / Machine Instructions.

### 3. Top Recommended Resources
* **Automata Bible:** *Introduction to the Theory of Computation* by Michael Sipser.
* **Compiler Bible ("Dragon Book"):** *Compilers: Principles, Techniques, and Tools* by Aho, Lam, Sethi, Ullman.

---

## 🎯 Problem-Solving Checklist
- [ ] Can you convert an NFA to a DFA using Subset Construction?
- [ ] Can you apply the Pumping Lemma for Regular Languages to prove a language is non-regular?
- [ ] Can you construct LL(1) parsing tables (FIRST and FOLLOW sets)?
- [ ] Can you prove a problem is undecidable by reducing the Halting Problem to it?
