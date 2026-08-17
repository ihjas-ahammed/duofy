# Duofy Reusable Lesson Format: Addressing Modes (Immediate, Register, Displacement, and PC-Relative)

**Target Topic:** `03_Computer_Science_and_IT / 08_Computer_Architecture_and_Hardware / Microprocessors_and_RISC_CISC_Architectures / Instruction_Set_Architecture_ISA`  
**Lesson Format Type:** `addressing_modes_immediate_register_displacement_and_pc_relative`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through operand location resolution, effective memory address (EA) calculation, and position-independent branch computation across standard microprocessor addressing modes (David A. Patterson & John L. Hennessy *Computer Organization and Design* RISC-V Edition Chapter 2; David Money Harris & Sarah L. Harris *Digital Design and Computer Architecture* 2nd ed.): master **Immediate Addressing** (operand is an embedded constant within the instruction word e.g. `ADDI x1, x0, 42`), master **Register Direct Addressing** (operands reside in CPU register files e.g. `ADD x1, x2, x3`), master **Base-Displacement / Base-Offset Addressing** ($\mathbf{\text{Effective Address (EA)} = \text{Base Register} + \text{Sign-Extended Offset}}$ e.g. `LW x1, 16(x2)` for struct fields and stack frames), master **PC-Relative Addressing** ($\mathbf{\text{Branch Target} = \text{PC} + (\text{Sign-Extended Offset} \ll 1)}$ for conditional branches `BEQ x1, x2, label`), and analyze why PC-relative addressing enables relocatable, position-independent code (PIC) in dynamic shared libraries (`.so` / `.dll`).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Addressing Modes Mathematical Formulas & Effective Address (EA) Reference Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Effective Address Calculation and Memory Fetch for a Base-Displacement Load Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Addressing Mode / Operand Mechanism & Effective Address Formula Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Addressing Mode That Calculates Branch Target Addresses Relative to the Program Counter Is ___-Relative (PC) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Architectural Analysis: Why PC-Relative Addressing Enables Position-Independent Code (PIC) Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Addressing Modes (Patterson & Hennessy Ch 2):
   - **The 4 Primary Addressing Modes Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Addressing Mode} & \textbf{Effective Operand Location} & \textbf{Mathematical Formula} & \textbf{RISC-V / MIPS Example} \\
     \hline
     \mathbf{\text{Immediate}} & \text{Embedded in instruction bits} & \text{Operand} = \text{SignExt}(\text{Imm}) & \texttt{ADDI x1, x2, 100} \\
     \mathbf{\text{Register Direct}} & \text{Inside CPU Register File} & \text{Operand} = \text{Reg}[r_s] & \texttt{ADD x1, x2, x3} \\
     \mathbf{\text{Base-Displacement}} & \mathbf{\text{Main Memory (RAM)}} & \mathbf{\text{EA} = \text{Reg}[\text{Base}] + \text{SignExt}(\text{Offset})} & \mathbf{\texttt{LW x1, 8(x2)}} \\
     \mathbf{\text{PC-Relative}} & \mathbf{\text{Instruction Memory (Branch)}} & \mathbf{\text{Target} = \text{PC} + \text{SignExt}(\text{Offset} \ll 1)} & \mathbf{\texttt{BEQ x1, x2, Loop}} \\
     \hline
     \end{array}$$
   - **Position-Independent Code (PIC) Invariant:** Branches jump by a relative offset $\Delta \text{PC}$; the compiled binary can be loaded into **ANY random base memory address** (ASLR) without rewriting branch instructions!
2. **Slide 2 (`ordering`):** Provide 5 steps of Base-Displacement memory fetch: (1) instruction decoder extracts 12-bit signed immediate offset (-16) and base register identifier (x2), (2) hardware Sign-Extension unit expands 12-bit offset to 64-bit two's complement value (0xFFFFFFFFFFFFFFF0), (3) ALU adds sign-extended offset to 64-bit value in base register x2 (0x7FFF0020) computing Effective Address EA = 0x7FFF0010, (4) memory address bus asserts EA = 0x7FFF0010 to L1 Data Cache / RAM, (5) 64-bit data word is read from memory and written to destination register x1!
3. **Slide 3 (`matching`):** Pair 4 concepts (Immediate Mode, Register Mode, Base-Displacement Mode, PC-Relative Mode) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that PC-Relative uses Program Counter. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why PC-Relative addressing enables Position-Independent Code: Why is PC-Relative addressing mathematically superior to absolute jump addressing for conditional branches and dynamic shared libraries (`.so` / `.dll`)? (Absolute jump addressing hardcodes fixed physical 32/64-bit memory addresses into instruction binaries, meaning code can only execute if loaded into that exact fixed address space; **PC-Relative addressing encodes branch targets as relative offset displacements ($\Delta \text{PC} = \text{Target} - \text{PC}$); because the distance between the branch instruction and its target label remains constant regardless of where the program is placed in RAM, the binary can be loaded into any arbitrary memory address without patching or code relocation**, enabling Address Space Layout Randomization (ASLR) and shared libraries).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "addressing_modes_immediate_register_displacement_and_pc_relative",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Fundamental Microprocessor Addressing Modes (Patterson \\& Hennessy)**\n• **Operand Resolution \\& Effective Address (EA) Matrix:**\n$$\n\\begin{array}{|l|l|l|l|}\n\\hline\n\\textbf{Addressing Mode} & \\textbf{Operand Location} & \\textbf{Mathematical Address Calculation} & \\textbf{RISC-V Assembly Syntax} \\\\\n\\hline\n\\mathbf{\\text{Immediate}} & \\text{Inside Instruction bits} & \\text{Data} = \\text{SignExt}(\\text{Imm}) & \\texttt{ADDI x5, x0, 100} \\\\\n\\mathbf{\\text{Register Direct}} & \\text{CPU Register File} & \\text{Data} = \\text{Register}[r_s] & \\texttt{ADD x5, x1, x2} \\\\\n\\mathbf{\\text{Base-Displacement}} & \\mathbf{\\text{Data Memory (RAM)}} & \\mathbf{\\text{EA} = \\text{Register}[r_{\\text{base}}] + \\text{SignExt}(\\text{Offset})} & \\mathbf{\\texttt{LW x5, 16(x10)}} \\\\\n\\mathbf{\\text{PC-Relative}} & \\mathbf{\\text{Instruction Memory}} & \\mathbf{\\text{Branch Target} = \\text{PC} + \\text{SignExt}(\\text{Offset} \\ll 1)} & \\mathbf{\\texttt{BEQ x1, x2, Loop}} \\\\\n\\hline\n\\end{array}\n$$\n• **The Position-Independent Invariant (PIC):**\n$$\n\\mathbf{\\Delta = (\\text{TargetAddress} - \\text{PC}) \\implies \\text{Invariant under any arbitrary memory base shift!}}\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential hardware steps executed to resolve a Base-Displacement memory load instruction: LW x1, -8(x2).",
      "orderItems": [
        "Instruction Decoder extracts the 12-bit signed immediate (-8) and source base register index (x2)",
        "Sign-Extension unit expands the 12-bit immediate (-8) into a full 64-bit two's complement integer (0xFFFFFFFFFFFFFFF8)",
        "ALU adds the sign-extended offset to the base address stored in register x2 to compute the Effective Address (EA)",
        "Memory Address Bus transmits the calculated Effective Address (EA) to the L1 Data Cache / RAM",
        "The 32-bit data word retrieved from memory is written into destination register x1"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Addressing Mode to its exact Mathematical Address Calculation.",
      "matchPairs": [
        { "left": "Immediate Addressing", "right": "Operand value is directly encoded within the instruction field (Data = SignExt(Imm))" },
        { "left": "Register Direct Addressing", "right": "Operand is retrieved directly from a general-purpose register without memory access" },
        { "left": "Base-Displacement Mode", "right": "Effective Address = Contents of Base Register + Sign-Extended Offset" },
        { "left": "PC-Relative Addressing", "right": "Target Address = Current Program Counter (PC) + Sign-Extended Offset" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The addressing mode that calculates branch target destinations relative to the Program Counter is ___-relative.",
      "blankAnswer": "PC",
      "blankDistractors": ["Base", "Direct", "Stack"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is PC-Relative addressing mathematically required for implementing Position-Independent Code (PIC) in dynamic shared libraries (.so / .dll) and operating systems with Address Space Layout Randomization (ASLR)?",
      "options": [
        { "text": "Absolute jump addressing encodes fixed, hardcoded physical 32-bit or 64-bit memory addresses into compiled machine code, requiring the program to be loaded into that exact predetermined address space to function; PC-Relative addressing encodes branch targets as relative signed byte displacements (Delta = Target - PC); because the relative distance between a branch instruction and its target label remains constant regardless of where the code is loaded into RAM, the entire binary executable or shared library can be mapped into any arbitrary memory address without requiring dynamic code modification or binary relocation patching", "isCorrect": true, "explanation": "Correct! This is David Patterson and John Hennessy's defining architectural explanation of position-independent control flow (Patterson & Hennessy *Computer Organization and Design* Chapter 2 *Instructions: Language of the Computer*). 1. **The Absolute Jump Failure in Shared Libraries:** - Suppose `libc.so` contains `JUMP 0x00401000`. - If App 1 loads `libc.so` at `0x00400000`: It works! - If App 2 already has something at `0x00400000` and must load `libc.so` at `0x00800000`: The absolute jump jumps to `0x00401000` and **crashes immediately**! 2. **The PC-Relative Triumph:** - In `libc.so`, the branch to `printf_helper` is $20\\text{ bytes}$ ahead of the `BEQ` instruction. - The instruction stores `Offset = +20`. - When executing: Target is $\\text{PC} + 20$. - If `libc.so` is loaded at `0x1000`: `0x1000 + 20 = 0x1014` (Correct!). - If `libc.so` is loaded at `0x90000000`: `0x90000000 + 20 = 0x90000014` (Correct!). 3. **The Security Impact:** PC-Relative addressing makes **ASLR (Address Space Layout Randomization)** possible, protecting computers from buffer-overflow exploits by randomizing memory locations on every boot!" },
        { "text": "Because PC-Relative addressing eliminates the need for a CPU clock", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because absolute addressing is only permitted on 8-bit game consoles", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because PC-Relative branches make programs execute 1,000 times faster", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
