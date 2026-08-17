# Duofy Reusable Lesson Format: RISC-V Modular ISA (Base Integer and Standard Extensions)

**Target Topic:** `03_Computer_Science_and_IT / 08_Computer_Architecture_and_Hardware / Microprocessors_and_RISC_CISC_Architectures / RISC_V_and_ARM_Architectures`  
**Lesson Format Type:** `risc_v_modular_isa_base_integer_and_standard_extensions`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the open-source philosophy, frozen base specifications, and composable extension ecosystem of RISC-V (David Patterson & Andrew Waterman *The RISC-V Reader: An Open Architecture Atlas*; Krste Asanović et al. UC Berkeley Technical Report): master the **Base Integer ISAs (RV32I and RV64I)** (40 core integer instructions, 32 general-purpose registers `x0` to `x31` where `x0` is hardwired to constant zero, and uniform 32-bit instruction encoding), master the **Standard Modular Extensions Taxonomy ($\mathbf{RV32G / RV64G = IMAFD}$)** (**`M`:** Integer Multiply/Divide, **`A`:** Atomic Memory Operations and `LR`/`SC` locks, **`F` & `D`:** IEEE 754 Floating Point with 32 registers `f0` to `f31`), master **Compressed Instructions (`C`)** (16-bit encoding shrinking code size by 25-30% to rival x86 density), and evaluate how modularity allows embedded microcontrollers to avoid the silicon area bloat of unused floating-point hardware.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | RISC-V Base RV32I/RV64I & Modular Extensions (IMAFDCV) Taxonomy Matrix Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Composition and Execution of an Atomic Compare-and-Swap in RISC-V ('A' Extension) Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | RISC-V Extension Letter / Base Specification & Hardware Capability Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In RISC-V, the General-Purpose Register Hardwired to Constant Zero Is ___ (x0 / zero) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Architectural Analysis: Why a Modular Composable ISA Prevents Silicon Area and Power Waste Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State RISC-V Modular ISA (Patterson & Waterman 2017):
   - **The RISC-V Extension Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Extension} & \textbf{Name} & \textbf{Key Added Instructions / Registers} & \textbf{Typical Domain} \\
     \hline
     \mathbf{\text{I}} & \mathbf{\text{Base Integer}} & \mathbf{\text{40 core instructions, 32 GPRs } (x_0 - x_{31})} & \text{Mandatory Core Base} \\
     \mathbf{\text{M}} & \text{Integer Math} & \texttt{MUL, MULH, DIV, DIVU, REM} & \text{Accelerated math} \\
     \mathbf{\text{A}} & \mathbf{\text{Atomic Ops}} & \mathbf{\texttt{LR.W, SC.W, AMOSWAP, AMOADD}} & \mathbf{\text{Multi-core OS locks (Linux)}} \\
     \mathbf{\text{F / D}} & \text{Floating Point} & \text{Single/Double IEEE 754, 32 FPRs } (f_0 - f_{31}) & \text{Graphics, DSP, Scientific} \\
     \mathbf{\text{C}} & \mathbf{\text{Compressed}} & \mathbf{\text{16-bit instruction encodings}} & \mathbf{\text{Embedded IoT / Cache efficiency}} \\
     \mathbf{\text{V}} & \text{Vector} & \text{Scalable vector registers, SIMD} & \text{Machine Learning / AI} \\
     \hline
     \end{array}$$
   - **The General-Purpose Shorthand:** $\mathbf{\text{RV64G} = \text{RV64IMAFD}}$ (The standard standard-compliance target for running Linux!).
2. **Slide 2 (`ordering`):** Provide 5 steps of atomic Lock acquisition via Load-Reserved/Store-Conditional (`LR.W`/`SC.W`): (1) CPU executes `LR.W x1, (x2)` to load lock word into register x1 and place hardware reservation on memory address, (2) branch checks if lock is already held ($x1 \neq 0$); if held, loops back to retry, (3) CPU sets register $x3 = 1$ to claim lock, (4) CPU executes `SC.W x4, x3, (x2)` attempting conditional store to memory address, (5) hardware checks reservation: if no other core wrote to the address, store succeeds ($x4=0$) and lock is acquired; else store fails ($x4 \neq 0$) and loop restarts!
3. **Slide 3 (`matching`):** Pair 4 concepts (RV32I Base, 'M' Extension, 'A' Extension, 'C' Extension) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that hardwired zero register is x0. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on modularity benefits: Why did the designers of RISC-V create a modular ISA with optional standard extensions (e.g. RV32E for tiny microcontrollers vs RV64GC for supercomputers) rather than creating a single monolithic instruction set containing every instruction (like x86)? (In monolithic ISAs like x86, every chip manufacturer is legally and architecturally forced to implement the entire instruction set—including 40 years of legacy floating-point, vector, and cryptographic instructions—even on tiny $0.10 microcontroller chips where they are never used; **RISC-V's modular architecture guarantees that a simple IoT microcontroller needs to implement only the tiny 40-instruction RV32I base (saving silicon area, battery power, and manufacturing costs), while a server processor can add M, A, F, D, C, and V extensions on the exact same unified software toolchain**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "risc_v_modular_isa_base_integer_and_standard_extensions",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: RISC-V Modular Architecture (Patterson \\& Waterman 2017)**\n• **Standard Extension \\& Capability Matrix:**\n$$\n\\begin{array}{|l|l|l|l|}\n\\hline\n\\textbf{Module} & \\textbf{Extension Name} & \\textbf{Added Hardware Capabilities} & \\textbf{Target Computing Sector} \\\\\n\\hline\n\\mathbf{\\text{I}} & \\mathbf{\\text{Base Integer}} & \\mathbf{\\text{40 core instructions; 32 GPRs } (x0 - x31)} & \\text{Mandatory Foundation} \\\\\n\\mathbf{\\text{M}} & \\text{Integer Multiply/Divide} & \\texttt{MUL, MULH, DIV, REM} & \\text{General Computation} \\\\\n\\mathbf{\\text{A}} & \\mathbf{\\text{Atomic Operations}} & \\mathbf{\\texttt{LR.W, SC.W, AMOADD (Lock-free sync)}} & \\mathbf{\\text{Multi-Core Operating Systems (Linux)}} \\\\\n\\mathbf{\\text{F / D}} & \\text{Single/Double Float} & \\text{IEEE 754 float math; 32 FPRs } (f0 - f31) & \\text{Scientific, Graphics, DSP} \\\\\n\\mathbf{\\text{C}} & \\mathbf{\\text{Compressed (16-bit)}} & \\mathbf{\\text{Compresses code size by 25-30\\%}} & \\mathbf{\\text{Embedded IoT, Cache Efficiency}} \\\\\n\\mathbf{\\text{V}} & \\text{Vector Extension} & \\text{Variable-length vector registers} & \\text{AI/ML, Neural Networks} \\\\\n\\hline\n\\end{array}\n$$\n• **The General-Purpose Standard Definition:** $\\mathbf{\\text{RV64G} = \\text{RV64IMAFD}}$ (The standard baseline for Linux OS kernels)!\n• **The Zero Register Invariant:** Register $\\mathbf{x0}$ is **hardwired to constant zero ($0$)**; writes to $x0$ are silently discarded!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed when acquiring a spinlock using RISC-V Atomic Load-Reserved / Store-Conditional (LR.W / SC.W).",
      "orderItems": [
        "CPU executes LR.W x1, (x2) to load the lock status from memory address (x2) and register a hardware address reservation",
        "CPU evaluates register x1: if lock is already held (x1 != 0), it loops back to retry reading the lock",
        "CPU prepares value 1 in register x3 to signify claiming lock ownership",
        "CPU executes SC.W x4, x3, (x2) to conditionally write value 1 to address (x2) if the reservation is still valid",
        "Hardware evaluates reservation: if no other core modified the address, store succeeds (x4=0) and lock is acquired; else loop restarts"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each RISC-V Modular Component to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "RV32I Base Integer", "right": "Core 32-bit frozen integer ISA containing 40 instructions and 32 general-purpose registers" },
        { "left": "Extension 'A' (Atomics)", "right": "Provides Load-Reserved/Store-Conditional and Atomic Memory Operations for multi-core synchronization" },
        { "left": "Extension 'C' (Compressed)", "right": "Encodes common 32-bit instructions into 16-bit formats to shrink binary size and improve I-cache hits" },
        { "left": "Register x0 (zero)", "right": "Hardwired to constant 0, enabling elegant synthesis of NOP (addi x0, x0, 0) and register moves" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the RISC-V architecture, the general-purpose register hardwired to constant zero is ___.",
      "blankAnswer": "x0",
      "blankDistractors": ["x1", "x31", "pc"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why did the architects of RISC-V design a modular composable ISA with optional extensions (e.g. RV32I vs RV64GC) rather than mandating a single monolithic instruction set containing all features (like x86)?",
      "options": [
        { "text": "In monolithic ISAs like x86, silicon chip designers are legally and architecturally required to implement the entire instruction set—including decades of legacy floating-point, SIMD, and virtualization hardware—even in low-cost $0.10 microcontrollers where they will never be used, wasting massive silicon die area, battery power, and manufacturing costs; RISC-V's modular architecture allows tiny embedded IoT sensors to implement only the ultra-compact 40-instruction RV32I base in a few thousand logic gates, while high-performance servers can add M, A, F, D, C, and V extensions on the exact same unified software and compiler toolchain", "isCorrect": true, "explanation": "Correct! This is David Patterson and Andrew Waterman's primary architectural motivation for RISC-V (*The RISC-V Reader* Chapter 1). 1. **The Monolithic Hardware Bloat:** - If you want to make an x86 microcontroller: Intel's specification requires you to support MMX, SSE, AVX, x87 FPU, and 40 years of legacy modes. - The decoder alone takes up more silicon area than the entire microcontroller needs! - This makes tiny x86 microcontrollers economically unviable. 2. **The RISC-V Modular Revolution:** - A tiny smart thermostat or pacemaker needs only **RV32I** (just $\\sim 40\\text{ instructions}$, fitting into $<15,000\\text{ silicon transistors}$ and running on micro-watts of power). - A smartphone implements **RV64GC** (64-bit integer, multiplication, atomics, floating point, and compressed instructions). - A supercomputer cloud chip implements **RV64GCV** (adding hardware vector engines). 3. **The Software Benefit:** All of these chips share the exact same GCC/LLVM compiler backend, Linux kernel base, and software ecosystem without fragmentation!" },
        { "text": "Because RISC-V chips can only be built using wooden circuit boards", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because monolithic ISAs are legally prohibited in North America", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because modular extensions prevent processors from connecting to the Internet", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
