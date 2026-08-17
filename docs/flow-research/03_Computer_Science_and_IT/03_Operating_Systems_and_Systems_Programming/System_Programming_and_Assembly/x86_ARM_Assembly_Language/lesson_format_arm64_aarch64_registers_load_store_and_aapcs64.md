# Duofy Reusable Lesson Format: ARM64 (AArch64) Registers, Load-Store Model, and AAPCS64

**Target Topic:** `03_Computer_Science_and_IT / 03_Operating_Systems_and_Systems_Programming / System_Programming_and_Assembly / x86_ARM_Assembly_Language`  
**Lesson Format Type:** `arm64_aarch64_registers_load_store_and_aapcs64`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the 64-bit RISC register architecture, Link Register call/return mechanisms, load-store memory boundaries, and AAPCS64 calling standards of ARM64 / AArch64 assembly (ARM Architecture Reference Manual ARMv8-A; Procedure Call Standard for the Arm 64-bit Architecture AAPCS64; Patterson & Hennessy ARM Edition): master the **31 General Purpose Registers (`X0`–`X30`, with `W0`–`W30` for 32-bit lower halves)**, decode special registers (**`X30` as Link Register LR**, **`X29` as Frame Pointer FP**, **`XZR`/`WZR` as Zero Register**, and **`SP`**), master the **Strict Load-Store RISC Rule** (ALU instructions operate ONLY on registers; memory access requires `LDR`/`STR` or pair instructions **`STP`/`LDP`** with pre/post-indexed addressing `[sp, #-16]!`), decode the **AAPCS64 Standard** (8 argument registers `X0`–`X7`, return values in `X0`/`X1`, callee-saved `X19`–`X28`), and trace function calls via **`BL` (Branch with Link)** and **`RET`**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | ARM64 31-Register Taxonomy, Link Register LR, & Load-Store Invariant Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step ARM64 Function Prologue, Memory Store Pair, and Return Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | ARM64 Register / Instruction & Architectural Function Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Name of the Dedicated ARM64 Register That Stores 0 When Read and Discards Writes (XZR / Zero) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | How Function Calls and Return Addresses Differ Between x86-64 (call/ret) and ARM64 (BL/RET) Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State ARM64 (AArch64) Architecture & AAPCS64 (ARMv8-A; AAPCS64):
   - **Register Organization:**
     - 31 64-bit general-purpose registers: **`X0` through `X30`** (`W0`–`W30` represent lower 32 bits).
     - **`X0`–`X7`:** Function arguments and return values (AAPCS64 supports up to 8 register args!).
     - **`X9`–`X15`:** Caller-saved temporary registers.
     - **`X19`–`X28`:** Callee-saved registers.
     - **`X29` (FP):** Frame Pointer.
     - **`X30` (LR):** **Link Register** (stores return address for `RET`).
     - **`XZR` / `WZR`:** Zero Register (hardwired 0; writes discarded).
     - **`SP`:** Dedicated Stack Pointer (must be 16-byte aligned).
   - **Strict Load-Store Architecture:**
     - Math operations CANNOT touch memory: `ADD X0, X1, X2` (registers only!).
     - Memory transfer: `LDR X0, [X1]`, `STR X0, [X1]`.
     - Store/Load Pair: `STP X29, X30, [SP, #-16]!` (pre-indexed decrement and push FP+LR).
2. **Slide 2 (`ordering`):** Provide 5 steps of standard ARM64 function call and stack management: (1) caller places function arguments into registers X0, X1, X2 and executes 'BL func' (saving return PC into X30 LR), (2) callee prologue saves Frame Pointer X29 and Link Register X30 onto stack: 'STP X29, X30, [SP, #-16]!', (3) callee updates Frame Pointer to current stack top: 'MOV X29, SP', (4) callee performs computation on registers and writes return value into X0, (5) callee restores FP and LR via 'LDP X29, X30, [SP], #16' and returns via 'RET' (jumping to address in X30 LR)!
3. **Slide 3 (`matching`):** Pair 4 ARM64 registers/instructions (X30 Link Register, XZR Zero Register, STP Store Pair, BL Branch with Link) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the zero register is XZR (or WZR). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the difference in function return address storage between x86-64 and ARM64: How do x86-64 and ARM64 fundamentally differ in where the CPU stores the return address during a subroutine call? (In x86-64, the `call` instruction **automatically pushes the 8-byte return address onto the memory stack** and decrements `%rsp`; in ARM64, the `BL` (Branch with Link) instruction **stores the return address directly in high-speed hardware register `X30` (Link Register LR) without touching memory**, avoiding expensive stack writes for leaf functions).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "arm64_aarch64_registers_load_store_and_aapcs64",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: ARM64 (AArch64) & AAPCS64 Architecture**\n• **31 64-Bit Registers (`X0`–`X30` / `W0`–`W30` for 32-bit):**\n$$\n\\begin{array}{|l|l|}\n\\hline\n\\textbf{ARM64 Register} & \\textbf{AAPCS64 Standard Function Role} \\\\\n\\hline\n\\mathbf{X0\\text{--}X7} & \\mathbf{\\text{Function Arguments (up to 8 in registers!) \\& Return Values}} \\\\\n\\mathbf{X9\\text{--}X15} & \\text{Caller-saved temporary scratchpad registers} \\\\\n\\mathbf{X19\\text{--}X28} & \\text{Callee-saved preserved registers} \\\\\n\\mathbf{X29 \\text{ (FP)}} & \\text{Frame Pointer} \\\\\n\\mathbf{X30 \\text{ (LR)}} & \\mathbf{\\text{Link Register (Holds function return address for RET)}} \\\\\n\\mathbf{\\text{XZR} \\ / \\ \\text{WZR}} & \\mathbf{\\text{Zero Register (Always reads 0; writes discarded)}} \\\\\n\\hline\n\\end{array}\n$$\n• **Strict Load-Store RISC Invariant:** Math operates **EXCLUSIVELY on registers** (`ADD X0, X1, X2`); memory transfer requires `LDR`, `STR`, `STP`, or `LDP`!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential assembly steps executed during an ARM64 non-leaf function call adhering to AAPCS64.",
      "orderItems": [
        "Caller loads arguments into registers X0-X2 and executes 'BL target_func', placing return PC into X30 (LR)",
        "Callee prologue pushes Frame Pointer and Link Register: STP X29, X30, [SP, #-16]!",
        "Callee establishes new stack frame base: MOV X29, SP",
        "Callee executes computation, invokes child sub-routines, and writes return result into register X0",
        "Callee epilogue restores FP and LR: LDP X29, X30, [SP], #16, and executes 'RET' (branches to address in X30)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each ARM64 Assembly Register / Instruction to its exact architectural role.",
      "matchPairs": [
        { "left": "X30 (Link Register LR)", "right": "Stores return instruction address when BL executes, enabling RET without reading stack" },
        { "left": "XZR / WZR Register", "right": "Hardwired zero register; returns 0 on read and discards written values without error" },
        { "left": "STP X29, X30, [SP, #-16]!", "right": "Pre-indexed Store Pair instruction that pushes FP and LR to stack while decrementing SP" },
        { "left": "BL (Branch with Link)", "right": "Jumps to target subroutine while simultaneously recording the next PC address into X30 LR" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In ARM64 assembly, the 64-bit register that always reads as zero and discards written values is ___.",
      "blankAnswer": "XZR",
      "blankDistractors": ["WZR", "SP", "LR"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "How do x86-64 and ARM64 architectures fundamentally differ in where the CPU stores the return address during a standard subroutine function call?",
      "options": [
        { "text": "In x86-64, the 'call' instruction automatically pushes the 8-byte return address onto the memory stack and decrements the RSP stack pointer; in ARM64, the 'BL' (Branch with Link) instruction stores the return address directly in high-speed hardware register X30 (Link Register LR) without touching memory, completely eliminating expensive stack write transactions for leaf functions", "isCorrect": true, "explanation": "Correct! This is one of the most important architectural differences between CISC x86 and RISC ARM (Patterson & Hennessy ARM Edition; CS:APP Chapter 3). 1. **x86-64 Mechanism (`call` / `ret`):** - When x86-64 executes `call func`, the CPU hardware pushes the return address (the next `%rip`) onto the stack in RAM/cache (`pushq %rip`) and decrements `%rsp` by 8 bytes. - When returning (`ret`), the CPU pops the return address from the memory stack back into `%rip`. - Every function call (even trivial leaf functions that don't call anything else) forces memory stack transactions. 2. **ARM64 Mechanism (`BL` / `RET`):** - When ARM64 executes `BL func` (Branch with Link), the CPU hardware simply copies the return address (`PC + 4`) into general-purpose hardware register **`X30` (the Link Register LR)**. - Zero memory access occurs! - For 'leaf functions' (functions that do not call any other functions), the function does its work and returns via `RET` (which jumps to `X30`) without EVER touching the stack or memory for return addresses! - Only non-leaf functions need to push `X30` to the stack to preserve it before making nested `BL` calls. This gives ARM64 significant efficiency in function call overhead." },
        { "text": "In ARM64, return addresses are stored on the hard drive swap partition", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "In x86-64, return addresses are stored in the L3 cache only", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "ARM64 does not support function calls or subroutines", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
