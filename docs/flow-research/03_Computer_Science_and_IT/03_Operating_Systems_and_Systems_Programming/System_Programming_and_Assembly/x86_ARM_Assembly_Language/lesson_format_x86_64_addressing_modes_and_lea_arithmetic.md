# Duofy Reusable Lesson Format: x86-64 Addressing Modes and LEA Arithmetic

**Target Topic:** `03_Computer_Science_and_IT / 03_Operating_Systems_and_Systems_Programming / System_Programming_and_Assembly / x86_ARM_Assembly_Language`  
**Lesson Format Type:** `x86_64_addressing_modes_and_lea_arithmetic`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the mathematical addressing modes, displacement-base-index-scale calculations, and non-memory arithmetic optimizations of x86-64 assembly language (Randal E. Bryant & David R. O'Hallaron CS:APP 3rd Ed. Chapter 3.4–3.5): master the universal memory addressing formula **$\mathbf{\text{Address} = \text{Imm} + R_b + (R_i \cdot S)}$** (where $S \in \{1, 2, 4, 8\}$), contrast **Memory Dereferencing (`movq D(Rb, Ri, S), %rax`)** with **Load Effective Address Arithmetic (`leaq D(Rb, Ri, S), %rax`)** which computes the address polynomial in silicon without touching memory, evaluate how C compilers utilize `leaq` for single-cycle multiplication by constants (e.g. $3x, 5x, 9x, 12x$), and calculate exact destination register contents across complex addressing modes.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Addressing Mode Syntax Imm(Rb, Ri, S), LEA vs MOV Rules, & Scale Factor Set Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Instruction Execution Trace for Complex LEA Expressions Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Assembly Instruction / Addressing Mode & Mathematical Calculation Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Name of the Instruction That Computes Address Arithmetic Without Accessing Memory (leaq / LEA) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Computation of Destination Register Value After LEA Instruction Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State x86-64 Addressing & `lea` Arithmetic (CS:APP Chapter 3.4–3.5):
   - **The Universal Memory Addressing Formula:**
     $$\mathbf{\text{Effective Address} = \text{Imm} + R_b + (R_i \times S)}$$
     - $\text{Imm}$: Constant displacement (e.g. $8, -16$).
     - $R_b$: Base register (any 64-bit general-purpose register).
     - $R_i$: Index register (any register except `%rsp`).
     - $S$: Scale factor $\in \{\mathbf{1, 2, 4, 8}\}$ (corresponding to standard primitive sizes: char, short, int, long/pointer).
   - **`movq` vs `leaq` (Load Effective Address):**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Instruction} & \textbf{Operation} & \textbf{RAM Memory Access?} \\
     \hline
     \mathbf{\text{movq } D(R_b, R_i, S), \%rax} & \text{Fetch 8 bytes stored AT address in memory} & \mathbf{\text{YES (Memory Read)}} \\
     \mathbf{\text{leaq } D(R_b, R_i, S), \%rax} & \text{Store computed value } D + R_b + (R_i \times S) & \mathbf{\text{NO (Pure ALU Math!)}} \\
     \hline
     \end{array}$$
   - **Compiler Multiplication Tricks with `leaq` ($x$ in `%rdi`):**
     - $3x$: `leaq (%rdi, %rdi, 2), %rax` $\implies x + 2x = 3x$.
     - $5x$: `leaq (%rdi, %rdi, 4), %rax` $\implies x + 4x = 5x$.
     - $9x$: `leaq (%rdi, %rdi, 8), %rax` $\implies x + 8x = 9x$.
2. **Slide 2 (`ordering`):** Provide 5 steps of tracing `leaq 12(%rdi, %rsi, 4), %rax` where %rdi=100 and %rsi=20: (1) inspect the scale factor S=4 and multiply index register %rsi by 4 (20 * 4 = 80), (2) add base register %rdi value (100 + 80 = 180), (3) add immediate displacement 12 (180 + 12 = 192), (4) observe that leaq does NOT access memory address 192, (5) write computed mathematical integer 192 directly into destination register %rax!
3. **Slide 3 (`matching`):** Pair 4 addressing modes (8(%rdi), (%rdi, %rsi), (%rdi, %rsi, 4), 16(%rdi, %rsi, 8)) with their mathematical expressions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that LEA stands for load effective address. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating result of chained `leaq` instructions: Suppose register `%rdi` holds the integer value $x = 10$. The CPU executes the following two assembly instructions:
   ```gas
   leaq (%rdi, %rdi, 2), %rax    # Instruction 1
   leaq 4(%rdi, %rax, 4), %rax   # Instruction 2
   ```
   What final numerical value is stored in register `%rax`? (Instruction 1 computes `%rax = %rdi + %rdi * 2 = 10 + 20 = 30` ($3x$); Instruction 2 computes `%rax = 4 + %rdi + %rax * 4 = 4 + 10 + (30 * 4) = 14 + 120 = \mathbf{134}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "x86_64_addressing_modes_and_lea_arithmetic",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: x86-64 Addressing Modes & LEA (CS:APP 3)**\n• **The Universal Memory Addressing Formula:**\n$$\n\\mathbf{\\text{Address} = \\text{Imm} + R_b + (R_i \\times S) \\qquad \\text{where } S \\in \\{1, 2, 4, 8\\}}\n$$\n• **`movq` vs `leaq` Invariant (CS:APP Chapter 3.5):**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Instruction} & \\textbf{Semantics} & \\textbf{Memory Access?} \\\\\n\\hline\n\\mathbf{\\text{movq } D(R_b, R_i, S), \\%rax} & \\text{Dereference RAM address and read 8 bytes} & \\mathbf{\\text{YES (Bus Transaction)}} \\\\\n\\mathbf{\\text{leaq } D(R_b, R_i, S), \\%rax} & \\text{Store address calculation } D + R_b + R_i \\cdot S & \\mathbf{\\text{NO (Pure Silicon Math!)}} \\\\\n\\hline\n\\end{array}\n$$\n• **Fast Compiler Arithmetic:** `leaq (%rdi, %rdi, 4), %rax` calculates $\\mathbf{5x}$ in a single clock cycle without using the slow multiplier unit!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps evaluated by the CPU when executing 'leaq 12(%rdi, %rsi, 4), %rax' where %rdi = 100 and %rsi = 20.",
      "orderItems": [
        "Extract the scale factor S = 4 and multiply the index register %rsi value by 4 (20 * 4 = 80)",
        "Add the base register %rdi value to the scaled index product (100 + 80 = 180)",
        "Add the immediate displacement constant of 12 to the accumulated sum (180 + 12 = 192)",
        "Bypass the Memory Management Unit and data cache entirely (zero RAM dereferencing)",
        "Write the computed arithmetic integer value 192 directly into destination register %rax"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each x86-64 Assembly Operand format to its exact mathematical formula.",
      "matchPairs": [
        { "left": "Imm(%rdi)", "right": "Imm + %rdi (Base register with immediate displacement offset)" },
        { "left": "(%rdi, %rsi)", "right": "%rdi + %rsi (Sum of base register and index register with scale 1)" },
        { "left": "(%rdi, %rsi, 4)", "right": "%rdi + (%rsi * 4) (Base register plus index register scaled by 4)" },
        { "left": "16(%rdi, %rsi, 8)", "right": "16 + %rdi + (%rsi * 8) (Full form: Displacement + Base + Index * 8)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The x86-64 instruction used by compilers to perform fast address arithmetic without touching memory is ___ (Load Effective Address).",
      "blankAnswer": "leaq",
      "blankDistractors": ["movq", "addq", "pushq"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Suppose register %rdi holds the integer value x = 10. The CPU executes the following two assembly instructions in sequence: 1) leaq (%rdi, %rdi, 2), %rax; 2) leaq 4(%rdi, %rax, 4), %rax. What final numerical value is stored in register %rax?",
      "options": [
        { "text": "134; Instruction 1 computes %rax = %rdi + %rdi * 2 = 10 + 20 = 30 (3x); Instruction 2 computes %rax = 4 + %rdi + %rax * 4 = 4 + 10 + (30 * 4) = 14 + 120 = 134", "isCorrect": true, "explanation": "Correct! This is a classic assembly arithmetic evaluation problem (CS:APP Section 3.5.1). 1. Given starting condition: `%rdi = 10`. 2. **Execute Instruction 1: `leaq (%rdi, %rdi, 2), %rax`** - Formula: $\\text{Imm} + R_b + (R_i \\times S) = 0 + \\%\\text{rdi} + (\\%\\text{rdi} \\times 2)$. - Substitution: $10 + (10 \\times 2) = 10 + 20 = 30$. - Register state after step 1: `%rdi = 10`, `%rax = 30`. 3. **Execute Instruction 2: `leaq 4(%rdi, %rax, 4), %rax`** - Formula: $\\text{Imm} + R_b + (R_i \\times S) = 4 + \\%\\text{rdi} + (\\%\\text{rax} \\times 4)$. - Substitution: $4 + 10 + (30 \\times 4) = 14 + 120 = 134$. - Register state after step 2: `%rax = 134`. 4. Notice how two single-cycle `leaq` instructions evaluated the entire polynomial $4 + x + 4(3x) = 13x + 4$ in 2 clock cycles without any memory accesses or complex multiplication instructions!" },
        { "text": "74", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "120", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "30", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
