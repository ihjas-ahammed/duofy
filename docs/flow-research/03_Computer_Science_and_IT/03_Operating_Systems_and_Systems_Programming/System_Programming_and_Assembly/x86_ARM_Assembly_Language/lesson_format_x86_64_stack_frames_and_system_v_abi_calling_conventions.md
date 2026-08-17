# Duofy Reusable Lesson Format: x86-64 Stack Frames and System V ABI Calling Conventions

**Target Topic:** `03_Computer_Science_and_IT / 03_Operating_Systems_and_Systems_Programming / System_Programming_and_Assembly / x86_ARM_Assembly_Language`  
**Lesson Format Type:** `x86_64_stack_frames_and_system_v_abi_calling_conventions`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the register allocation rules, activation record layouts, and stack alignment invariants of the 64-bit Unix System V AMD64 ABI (System V Application Binary Interface AMD64 Architecture Processor Supplement; Randal E. Bryant & David R. O'Hallaron CS:APP Chapter 3.7): master the **6-Register Argument Passing Sequence** (**`%rdi`, `%rsi`, `%rdx`, `%rcx`, `%r8`, `%r9`** with arguments 7+ pushed onto the stack in reverse order), classify registers into **Caller-Saved (Volatile: `%rax`, `%rcx`, `%rdx`, `%rsi`, `%rdi`, `%r8`–`%r11`)** vs **Callee-Saved (Preserved: `%rbx`, `%rbp`, `%r12`–`%r15`)**, formulate the **16-Byte Stack Alignment Invariant** (`%rsp + 8` is a multiple of 16 prior to executing a `call` instruction), trace stack frame creation and destruction (`pushq %rbp; movq %rsp, %rbp; ... leave; ret`), and analyze the **128-Byte Red Zone** below `%rsp`.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | System V Calling ABI Taxonomy, Caller vs Callee Saved, & 16-Byte Alignment Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Function Prologue, Execution, and Epilogue Assembly Sequence Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | x86-64 Register & Calling Convention Classification Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Name of the 128-Byte Memory Region Below RSP Usable Without Adjusting the Stack Pointer (Red Zone) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Architectural Analysis of Callee-Saved Register Invariants and Function Calls Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State System V ABI & Stack Frames (System V AMD64; CS:APP Chapter 3.7):
   - **Argument Passing Registers (First 6):**
     $$\mathbf{\text{Arg 1: } \%rdi, \quad \text{Arg 2: } \%rsi, \quad \text{Arg 3: } \%rdx, \quad \text{Arg 4: } \%rcx, \quad \text{Arg 5: } \%r8, \quad \text{Arg 6: } \%r9}$$
   - **Return Value:** `%rax` (64-bit) or `%rax:%rdx` (128-bit).
   - **Caller-Saved vs Callee-Saved Registers:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Category} & \textbf{Registers} & \textbf{Preservation Responsibility} \\
     \hline
     \mathbf{\text{Caller-Saved}} & \\%rax, \\%rcx, \\%rdx, \\%rsi, \\%rdi, \\%r8\text{--}\\%r11 & \text{Caller must save before calling function if needed later} \\
     \mathbf{\text{Callee-Saved}} & \\%rbx, \\%rbp, \\%r12\text{--}\\%r15 & \mathbf{\text{Callee MUST restore original values before returning!}} \\
     \hline
     \end{array}$$
   - **The 16-Byte Stack Alignment Invariant:** Before executing a `call` instruction, `%rsp` must be 16-byte aligned. (When `call` pushes the 8-byte return address, inside the function `%rsp` is 8 mod 16!).
   - **The 128-Byte Red Zone:** Optimization permitting leaf functions to use 128 bytes below `%rsp` without stack pointer adjustment.
2. **Slide 2 (`ordering`):** Provide 5 steps of standard function prologue, body, and epilogue: (1) caller sets up arguments in %rdi, %rsi, %rdx and executes 'call func', pushing return RIP onto stack, (2) callee prologue pushes old frame pointer 'pushq %rbp' and establishes new frame 'movq %rsp, %rbp', (3) callee pushes any callee-saved registers it intends to use (e.g. 'pushq %rbx'), (4) callee executes computation and places final return value into %rax, (5) callee restores callee-saved registers ('popq %rbx'), executes 'leave' (restoring %rsp and %rbp), and executes 'ret'!
3. **Slide 3 (`matching`):** Pair 4 registers (%rdi, %rax, %rbx, %rsp) with their calling convention roles.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of the 128-byte red zone. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on callee-saved register invariants: If function $F$ needs to use register `%rbx` to store an intermediate loop counter across multiple internal function calls, what must function $F$ do to adhere to the System V AMD64 ABI? (Because `%rbx` is a **Callee-Saved register**, function $F$ must **push `%rbx` onto the stack in its prologue** before modifying it, and **pop/restore the original `%rbx` value from the stack in its epilogue** before executing `ret`, ensuring the caller finds its `%rbx` unchanged).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "x86_64_stack_frames_and_system_v_abi_calling_conventions",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: System V AMD64 Calling ABI (CS:APP 3.7)**\n• **Argument Register Passing Order (First 6):**\n$$\n\\mathbf{\\text{Arg 1: } \\%rdi \\ \\longrightarrow \\ \\text{Arg 2: } \\%rsi \\ \\longrightarrow \\ \\text{Arg 3: } \\%rdx \\ \\longrightarrow \\ \\text{Arg 4: } \\%rcx \\ \\longrightarrow \\ \\text{Arg 5: } \\%r8 \\ \\longrightarrow \\ \\text{Arg 6: } \\%r9}\n$$\n• **Caller-Saved vs Callee-Saved Invariant:**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Convention} & \\textbf{Register Set} & \\textbf{ABI Contract} \\\\\n\\hline\n\\mathbf{\\text{Caller-Saved}} & \\%rax, \\%rcx, \\%rdx, \\%rsi, \\%rdi, \\%r8\\text{--}\\%r11 & \\text{Volatile; callee is free to overwrite} \\\\\n\\mathbf{\\text{Callee-Saved}} & \\mathbf{\\%rbx, \\%rbp, \\%r12\\text{--}\\%r15} & \\mathbf{\\text{Callee MUST preserve/restore before ret!}} \\\\\n\\hline\n\\end{array}\n$$\n• **The 16-Byte Stack Alignment Rule:** `%rsp` must be a multiple of 16 immediately prior to any `call` instruction (enforcing SIMD SSE/AVX vector memory alignment)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential assembly steps executed during an x86-64 function call adhering to the System V ABI.",
      "orderItems": [
        "Caller places arguments into %rdi, %rsi, %rdx and invokes 'call target_func', pushing return RIP onto stack",
        "Callee executes prologue: 'pushq %rbp' (saves old frame pointer) and 'movq %rsp, %rbp' (sets new base)",
        "Callee pushes any callee-saved registers (%rbx, %r12-%r15) that it will overwrite onto the stack",
        "Callee executes function logic, allocates local variables on stack, and stores the return result into %rax",
        "Callee pops callee-saved registers, executes 'leave' (resets stack), and invokes 'ret' (pops RIP to return)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each x86-64 Register to its exact System V ABI Calling Convention classification.",
      "matchPairs": [
        { "left": "%rdi & %rsi", "right": "Caller-saved registers dedicated to passing the 1st and 2nd integer/pointer function arguments" },
        { "left": "%rax", "right": "Caller-saved register dedicated to holding the 64-bit integer or pointer return value of a function" },
        { "left": "%rbx & %r12-%r15", "right": "Callee-saved registers; any function that modifies them must save and restore their original values" },
        { "left": "%rsp", "right": "Dedicated Stack Pointer pointing to the top of the runtime activation stack (grows downwards)" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The 128-byte memory space below RSP in x86-64 that leaf functions can use without adjusting the stack pointer is the ___ zone.",
      "blankAnswer": "red",
      "blankDistractors": ["green", "dead", "free"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Suppose function F() is written in x86-64 assembly and needs to use register %rbx to maintain an internal loop accumulator across several nested sub-function calls. According to the System V AMD64 ABI, what MUST function F() do with %rbx?",
      "options": [
        { "text": "Because %rbx is a Callee-Saved register, function F() must save the original value of %rbx (e.g. via 'pushq %rbx') in its function prologue before writing to it, and must restore the original value (e.g. via 'popq %rbx') in its function epilogue immediately prior to returning via 'ret'", "isCorrect": true, "explanation": "Correct! This is the foundational contract of Callee-Saved registers under the System V ABI (CS:APP Section 3.7.3). 1. The System V AMD64 ABI categorizes registers into: - **Caller-Saved:** `%rax, %rdi, %rsi, %rdx, %rcx, %r8, %r9, %r10, %r11`. A function may overwrite these registers freely without restoring them. If the caller needs their values preserved across a call, the caller must push them to the stack. - **Callee-Saved:** `%rbx, %rbp, %r12, %r13, %r14, %r15`. The caller assumes these registers will retain their exact values across any function call! 2. Therefore, if function $F()$ chooses to overwrite `%rbx`: - $F()$ must execute `pushq %rbx` in its prologue to save whatever value the caller had in `%rbx`. - $F()$ can now freely use `%rbx` for its loop counter and call other sub-functions (the sub-functions will also preserve `%rbx`!). - Before returning, $F()$ must execute `popq %rbx` to restore the caller's original value. 3. If $F()$ failed to restore `%rbx`, the caller's variables stored in `%rbx` would be silently corrupted, violating the ABI." },
        { "text": "Function F() must disable hardware interrupts before reading %rbx", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Function F() cannot use %rbx because only the Linux kernel can access %rbx", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Function F() must pass %rbx as an argument to exit()", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
