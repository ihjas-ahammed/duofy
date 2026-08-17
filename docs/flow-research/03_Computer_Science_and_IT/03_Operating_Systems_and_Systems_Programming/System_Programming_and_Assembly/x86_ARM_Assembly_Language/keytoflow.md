# Key to Flow: x86 and ARM Assembly Language (Addressing Modes, LEA, Stack Frames, System V vs AAPCS64, & ARM64)

**Subject Area:** `03_Computer_Science_and_IT / 03_Operating_Systems_and_Systems_Programming / System_Programming_and_Assembly / x86_ARM_Assembly_Language`

---

## 📌 Core Concept & Mental Model
**Register Micro-Architectures, Displacement-Base-Index-Scale Addressing Math, Pointer Arithmetic vs Memory Dereferencing (`lea` vs `mov`), 16-Byte Stack Frame Alignments, and Callee/Caller-Saved ABI Invariants** govern bare-metal systems execution across x86-64 CISC and ARM64 / AArch64 RISC processors (Randal E. Bryant & David R. O'Hallaron CS:APP 3rd Ed. Chapter 3; David A. Patterson & John L. Hennessy *Computer Organization and Design* ARM Edition; System V AMD64 ABI; ARM Procedure Call Standard AAPCS64):
* **1. x86-64 Memory Addressing Modes & `lea` Arithmetic:**
  - **The Universal Addressing Form:**
    $$\mathbf{\text{Address} = \text{Imm} + R_b + (R_i \times S)}$$
    - AT&T Syntax: `Imm(Rb, Ri, S)` where $S \in \{1, 2, 4, 8\}$ is the scale factor.
  - **`mov` vs `lea` (Load Effective Address):**
    - `movq 8(%rbx, %rcx, 4), %rax`: Calculates address AND **dereferences RAM** to fetch the 64-bit value at that memory address!
    - `leaq 8(%rbx, %rcx, 4), %rax`: Calculates the mathematical expression $8 + \text{RBX} + (\text{RCX} \times 4)$ and stores the **result in RAX without touching RAM**! (Compilers use `leaq` for ultra-fast multiplication, e.g. `leaq (%rdi, %rdi, 4), %rax` computes $5x$ in 1 clock cycle!).
* **2. x86-64 System V Calling Convention & Stack Frames:**
  - **Passing First 6 Integer/Pointer Arguments:** `RDI, RSI, RDX, RCX, R8, R9` (Args 7+ pushed on stack).
  - **Return Value:** `RAX` (low-order) / `RDX` (high-order 128-bit).
  - **Caller-Saved (Volatile):** `RAX, RCX, RDX, RSI, RDI, R8-R11` (Can be overwritten by callee).
  - **Callee-Saved (Preserved):** `RBX, RBP, R12-R15` (Callee must `push`/`pop` to restore).
  - **Stack Pointer (`RSP`):** Grows downward toward lower addresses. Must be **16-byte aligned before any `call` instruction**!
* **3. ARM64 (AArch64) Architecture & AAPCS64:**
  - **31 General-Purpose 64-Bit Registers (`X0`–`X30` / `W0`–`W30` for 32-bit):**
    - **`X0`–`X7`:** Function arguments and return values (up to 8 args in registers!).
    - **`X9`–`X15`:** Caller-saved temporary registers.
    - **`X19`–`X28`:** Callee-saved registers.
    - **`X29` (FP):** Frame Pointer.
    - **`X30` (LR):** **Link Register** (stores return address; written by `BL` Branch with Link, returned via `RET`).
    - **`XZR` / `WZR`:** Zero Register (reads as 0; writes discarded).
    - **`SP`:** Dedicated Stack Pointer (requires 16-byte alignment).
  - **Load-Store RISC Philosophy:** Arithmetic operations can ONLY operate on registers (`ADD X0, X1, X2`), never directly on memory! Memory access strictly requires `LDR` / `STR` / `STP` / `LDP`.
* **4. CISC (x86-64) vs RISC (ARM64) Summary:**
  $$\begin{array}{|l|l|l|}
  \hline
  \textbf{Architectural Property} & \textbf{x86-64 (CISC)} & \textbf{ARM64 / AArch64 (RISC)} \\
  \hline
  \text{Instruction Length} & \text{Variable (1 to 15 bytes)} & \text{Fixed (Strictly 4 bytes / 32 bits)} \\
  \text{Memory Operands in ALU} & \text{Supported (e.g. addq (\%rbx), \%rax)} & \text{Forbidden (Strict Load-Store only)} \\
  \text{Function Return Address} & \text{Pushed onto stack by `call`} & \text{Stored in Link Register `X30` (LR) by `BL`} \\
  \text{Function Arguments} & 6 \text{ registers (RDI, RSI, RDX...)} & 8 \text{ registers (X0 - X7)} \\
  \hline
  \end{array}$$

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Godbolt Compiler Explorer Loop
* Write a 3-line C function, compile with `-O2`, and trace the exact assembly instructions (`lea`, register assignments, stack frame prologue/epilogue).

### 2. Top Recommended Resources
* **The Definitive Textbook:** *Computer Systems: A Programmer's Perspective* (Bryant & O'Hallaron), Chapter 3 (Machine-Level Representation of Programs).
* **ARM Architecture:** *Computer Organization and Design ARM Edition* (Patterson & Hennessy).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you evaluate effective address calculations $D(Rb, Ri, S)$ for given register contents?
- [ ] Can you differentiate `leaq` pointer math from `movq` memory dereferencing?
- [ ] Can you classify x86-64 registers into caller-saved vs callee-saved categories?
- [ ] Can you trace ARM64 function calls using `BL`, `X30` (LR), and `STP X29, X30, [SP, #-16]!`?
