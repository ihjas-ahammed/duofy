# Duofy Reusable Lesson Format: ARM Cortex-M (Core Architecture, Thumb-2, & Registers)

**Target Topic:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Digital_Electronics_and_Microcontrollers / Microcontrollers_8051_ARM_Architecture`  
**Lesson Format Type:** `arm_cortex_m_core_architecture_thumb2_and_register_set`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the 32-bit ARM Cortex-M processor core architecture (ARMv7-M profile), load-store RISC execution, the Thumb-2 mixed 16/32-bit instruction set, unified 4 GB memory map, and the 16 core internal registers ($R_0 \text{ to } R_{15}$) in embedded systems (Joseph Yiu *The Definitive Guide to ARM Cortex-M3 and Cortex-M4 Processors* Chapters 3, 4; William Hohl *ARM Assembly Language* Chapters 2, 3): master the **ARM Cortex-M Core Register File ($16 \times 32\text{-Bit Registers}$)**:
1. **$R_0 - R_{12}$ (General Purpose Registers):**
   - $R_0 - R_3$: Argument passing and return values in AAPCS (ARM Architecture Procedure Call Standard);
   - $R_4 - R_{11}$: Callee-saved general-purpose data registers;
   - $R_{12}$ (IP): Intra-procedure-call scratchpad register;
2. **$R_{13}$ / $\text{SP}$ (Stack Pointer):** Banked into **Main Stack Pointer ($\text{MSP}$)** (OS kernel & exceptions) and **Process Stack Pointer ($\text{PSP}$)** (User application threads);
3. **$R_{14}$ / $\text{LR}$ (Link Register):** Holds return address for subroutines and special `EXC_RETURN` exception codes;
4. **$R_{15}$ / $\text{PC}$ (Program Counter):** Points to current instruction address $+ 4$ (LSB must always be $1$ to indicate Thumb execution state);
and analyze the **Program Status Register ($\text{xPSR}$)** combining Application PSR ($\text{APSR}$ ALU condition flags: $N, Z, C, V, Q$), Interrupt PSR ($\text{IPSR}$ current ISR exception number), and Execution PSR ($\text{EPSR}$ Thumb state bit $T=1$).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | ARM Cortex-M Register File ($R_0\text{-}R_{15}$, MSP/PSP, LR, PC), Thumb-2 & xPSR Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Execute a C Function Call via AAPCS Register Conventions Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | ARM Core Register / Special State Flag & Technical Hardware Function Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The ARM Cortex-M Register R14 That Stores the Return Address for Subroutines and Exception Returns Is the ___ Register (Link / LR) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | ARM Architecture Problem: Explaining the Dual Stack Pointers MSP and PSP in RTOS Isolation Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State ARM Cortex-M Architecture (Yiu 2013; Hohl 2014):
   - **Cortex-M Register File Formulations:**
     $$\mathbf{\text{Core Registers: } R_0 - R_{15} \quad \Big| \quad R_{13} = \text{SP (MSP / PSP)} \quad \Big| \quad R_{14} = \text{LR} \quad \Big| \quad R_{15} = \text{PC} \quad \Big| \quad \text{xPSR} = \text{APSR} + \text{IPSR} + \text{EPSR}}$$
   - **AAPCS Register Allocation Matrix:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Register} & \textbf{Name} & \textbf{AAPCS Role} & \textbf{Caller/Callee Saved} \\
     \hline
     \mathbf{R_0 - R_3} & \text{Arg / Return} & \text{Passes first 4 input arguments; } R_0\text{-}R_1 \text{ return results} & \mathbf{\text{Caller-Saved (Volatile)}} \\
     \mathbf{R_4 - R_{11}} & \text{Variable Regs} & \text{Local function variables} & \mathbf{\text{Callee-Saved (Preserved)}} \\
     \mathbf{R_{12} \ (\text{IP})} & \text{Intra-Call} & \text{Linker scratchpad} & \text{Caller-Saved} \\
     \mathbf{R_{13} \ (\text{SP})} & \text{Stack Pointer} & \text{Banked Main (MSP) and Process (PSP) stack pointers} & \text{Preserved} \\
     \mathbf{R_{14} \ (\text{LR})} & \text{Link Register} & \text{Stores function return address / EXC\_RETURN} & \text{Preserved in stack} \\
     \mathbf{R_{15} \ (\text{PC})} & \text{Program Counter} & \text{Instruction execution pointer} & \text{Control flow} \\
     \hline
     \end{array}$$
   - **The Thumb State Invariant:** Cortex-M processors execute **strictly Thumb-2 instructions**; attempting to execute in ARM 32-bit state (by clearing the $T$ bit in EPSR or jumping to an even PC address with LSB $=0$) triggers a **HardFault exception**!
2. **Slide 2 (`ordering`):** Provide 5 steps of ARM AAPCS C-function call execution: (1) caller places first 4 arguments into registers $R_0, R_1, R_2, R_3$, (2) caller executes `BL` (Branch with Link) instruction, which copies return address into $R_{14}$ (LR) and jumps to function address, (3) callee function pushes any modified registers ($R_4-R_{11}$ and LR) onto stack via `PUSH {R4, LR}`, (4) callee performs computation and places return value into $R_0$, (5) callee executes `POP {R4, PC}` to restore preserved registers and return to caller simultaneously!
3. **Slide 3 (`matching`):** Pair 4 concepts (Link Register LR / R14, Main Stack Pointer MSP, Program Counter PC / R15, Thumb-2 Technology) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Link (or LR). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on dual stack pointers (MSP vs PSP): In ARM Cortex-M microcontrollers operating under a Real-Time Operating System (RTOS), why are the stack pointers physically banked into two distinct registers: Main Stack Pointer (MSP) and Process Stack Pointer (PSP)? (MSP is dedicated to the OS kernel, interrupt handlers, and exceptions; PSP is assigned to individual user application tasks/threads; This separation provides **hardware memory isolation**: an application task stack overflow cannot corrupt the RTOS kernel or interrupt stack, preventing fatal OS crashes).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "arm_cortex_m_core_architecture_thumb2_and_register_set",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: ARM Cortex-M Architecture \\& Register File (Joseph Yiu)**\n• **Core 32-Bit Register Set ($R_0 - R_{15}$):**\n$$\n\\mathbf{\\text{General: } R_0-R_{12} \\quad \\Big| \\quad \\text{SP (}R_{13}\\text{): MSP / PSP} \\quad \\Big| \\quad \\text{LR (}R_{14}\\text{): Link Reg} \\quad \\Big| \\quad \\text{PC (}R_{15}\\text{): Program Counter}}\n$$\n• **ARM Architecture Procedure Call Standard (AAPCS):**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Register Range} & \\textbf{AAPCS Function} & \\textbf{Preservation Status} \\\\\n\\hline\n\\mathbf{R_0 - R_3} & \\text{First 4 function parameters; } R_0\\text{-}R_1 \\text{ hold return values} & \\mathbf{\\text{Caller-Saved (Volatile)}} \\\\\n\\mathbf{R_4 - R_{11}} & \\text{Local function variables} & \\mathbf{\\text{Callee-Saved (Preserved by PUSH/POP)}} \\\\\n\\mathbf{R_{12} \\ (\\text{IP})} & \\text{Intra-procedure-call scratchpad} & \\text{Caller-Saved} \\\\\n\\mathbf{R_{13} \\ (\\text{SP})} & \\text{Banked Main Stack (MSP) \\& Process Stack (PSP)} & \\text{Preserved} \\\\\n\\mathbf{R_{14} \\ (\\text{LR})} & \\text{Subroutine return address / Exception EXC\\_RETURN} & \\text{Preserved} \\\\\n\\hline\n\\end{array}\n$$\n• **The Thumb State Invariant:** Cortex-M processors support **only the Thumb-2 instruction set**; branch targets must always have bit 0 set to $1$ (LSB $=1$) to maintain the EPSR Thumb state bit ($T=1$), or a **HardFault exception is triggered immediately**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of an ARM Cortex-M C function call and return according to AAPCS conventions.",
      "orderItems": [
        "The calling function loads the first 4 function arguments into registers R0, R1, R2, and R3",
        "The caller executes the Branch with Link (BL) instruction, copying the return address into Link Register R14 (LR)",
        "The called function pushes modified callee-saved registers (R4-R11) and LR onto the stack using PUSH",
        "The called function executes its internal logic and places the final return value into register R0",
        "The function restores registers and returns by popping the saved LR value directly into the Program Counter: POP {R4, PC}"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each ARM Cortex-M Core Register to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Link Register (LR / R14)", "right": "Holds the subroutine return address during function calls and EXC_RETURN code during interrupts" },
        { "left": "Process Stack Pointer (PSP)", "right": "Dedicated stack pointer register assigned to individual user application threads in an RTOS" },
        { "left": "Main Stack Pointer (MSP)", "right": "Default reset stack pointer used by the operating system kernel and all interrupt handlers" },
        { "left": "Program Counter (PC / R15)", "right": "Points to the currently executing instruction address plus pipeline prefetch offset" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The ARM Cortex-M register R14 that stores the return address for subroutines and exception returns is the ___ register.",
      "blankAnswer": "link",
      "blankDistractors": ["stack", "status", "base"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In ARM Cortex-M processors running a Real-Time Operating System (RTOS), why is the physical stack pointer register R13 banked into two separate registers: Main Stack Pointer (MSP) and Process Stack Pointer (PSP)?",
      "options": [
        { "text": "MSP is dedicated exclusively to the RTOS kernel, fault handlers, and interrupt service routines, while PSP is assigned to user-level application threads; this architectural separation guarantees memory isolation so that a stack overflow in a runaway user application task cannot corrupt the operating system kernel stack or interrupt vector execution, preventing total system collapse", "isCorrect": true, "explanation": "Correct! This is Joseph Yiu's fundamental architectural explanation for the dual stack pointer design in the ARM Cortex-M core (*The Definitive Guide to ARM Cortex-M3 and Cortex-M4 Processors* Chapter 3). 1. **The Problem with Single-Stack Architectures:** - In classic microcontrollers (like the 8051 or ARM7TDMI), if a user thread enters deep recursion and exhausts stack memory, it overwrites the kernel data and interrupt return frames, crashing the entire processor. 2. **The Cortex-M Dual Stack Solution:** - **Main Stack Pointer (MSP / $R_{13}$):** Used at boot, during privilege mode, and by **ALL exception/interrupt handlers (ISRs)**. - **Process Stack Pointer (PSP / $R_{13}$):** Used exclusively by **unprivileged user threads/tasks** when configured by the RTOS. 3. **Fault Containment:** - If a user task overflows its stack, the Memory Protection Unit (MPU) catches the violation. The CPU immediately switches to MSP to execute the Fault Handler cleanly without risking kernel stack corruption!" },
        { "text": "Because 32-bit registers can only hold half a stack", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because MSP is used for multiplication and PSP is used for printing", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because ARM processors do not have RAM", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
