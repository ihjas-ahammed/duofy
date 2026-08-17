# Duofy Reusable Lesson Format: x86-64 System Call ABI and Register Conventions

**Target Topic:** `03_Computer_Science_and_IT / 03_Operating_Systems_and_Systems_Programming / System_Programming_and_Assembly / Linux_System_Calls`  
**Lesson Format Type:** `x86_64_system_call_abi_and_register_conventions`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the hardware privilege ring transitions, register parameter passing protocols, and kernel return code mappings of the 64-bit Linux System Call ABI (System V AMD64 ABI; Michael Kerrisk *The Linux Programming Interface* Chapter 3; Bryant & O'Hallaron CS:APP Chapter 8): master the **Hardware `syscall` Instruction Transition** (Ring 3 User Mode $\to$ Ring 0 Kernel Mode), decode the **Exact x86-64 System Call Register Sequence** (**`RAX` [Syscall Number]**, **`RDI` [Arg 1]**, **`RSI` [Arg 2]**, **`RDX` [Arg 3]**, **`R10` [Arg 4]**, **`R8` [Arg 5]**, **`R9` [Arg 6]**), understand why **`R10` replaces `RCX`** (because the `syscall` hardware instruction clobbers `RCX` and `R11`), write a bare-metal assembly `sys_write` and `sys_exit` payload, and analyze kernel error return codes in $[-4095, -1]$ mapped to libc `errno`.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | System V AMD64 Syscall ABI Table, Register Order, & Clobber Invariant Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Bare x86-64 Assembly sys_write (Hello World) Syscall Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | x86-64 Register & Linux System Call ABI Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Name of the 64-Bit Register Used to Pass the 4th System Call Argument in Linux (R10) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Why the Linux Syscall ABI Uses R10 for the 4th Argument Instead of RCX Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State x86-64 Syscall ABI (System V AMD64; TLPI Chapter 3; CS:APP 8):
   - **User-to-Kernel Privilege Transition:** `syscall` instruction switches CPU from Ring 3 to Ring 0.
   - **The Linux x86-64 Syscall Register Convention:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Register} & \textbf{Syscall ABI Role} & \textbf{Standard C Function ABI Role} \\
     \hline
     \mathbf{\text{RAX}} & \mathbf{\text{Syscall Number / Return Value}} & \text{Return Value} \\
     \mathbf{\text{RDI}} & \mathbf{\text{Argument 1}} & \text{Argument 1} \\
     \mathbf{\text{RSI}} & \mathbf{\text{Argument 2}} & \text{Argument 2} \\
     \mathbf{\text{RDX}} & \mathbf{\text{Argument 3}} & \text{Argument 3} \\
     \mathbf{\text{R10}} & \mathbf{\text{Argument 4 (CRITICAL DIFFERENCE!)}} & \text{Caller-saved temp} \\
     \mathbf{\text{R8}} & \mathbf{\text{Argument 5}} & \text{Argument 5} \\
     \mathbf{\text{R9}} & \mathbf{\text{Argument 6}} & \text{Argument 6} \\
     \hline
     \end{array}$$
   - **Hardware Clobbered Registers:** The CPU hardware instruction `syscall` automatically destroys **`RCX`** (stores return RIP) and **`R11`** (stores return RFLAGS).
   - **Return Code Convention:** `RAX` contains return value. Values between $-4095$ and $-1$ represent negative error numbers (e.g. `-EACCES`).
2. **Slide 2 (`ordering`):** Provide 5 steps of invoking sys_write in x86-64 assembly to print string to stdout: (1) load syscall number 1 (sys_write) into register RAX, (2) load file descriptor 1 (STDOUT_FILENO) into register RDI, (3) load memory address of string buffer into register RSI, (4) load length of string in bytes into register RDX, (5) execute hardware 'syscall' instruction to trap into kernel and transfer control!
3. **Slide 3 (`matching`):** Pair 4 registers (RAX, RDI, R10, RCX/R11) with their exact system call roles.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that R10 passes argument 4. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why R10 is used instead of RCX: In standard x86-64 C function calls, the 4th argument is passed in `RCX`, but in Linux x86-64 system calls, the 4th argument MUST be passed in `R10`. What is the architectural hardware reason for this deviation? (Because the x86-64 CPU hardware **`syscall` instruction automatically saves the user-space return instruction pointer (RIP) into `RCX`** and saves RFLAGS into `R11`; if the kernel ABI passed Argument 4 in `RCX`, the CPU hardware `syscall` instruction would **instantly overwrite and destroy the 4th argument** before kernel code could ever read it).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "x86_64_system_call_abi_and_register_conventions",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Linux x86-64 Syscall ABI (System V AMD64)**\n• **Hardware Trap:** `syscall` instruction executes Ring 3 $\\to$ Ring 0 privilege switch.\n• **Register Marshalling Convention (TLPI Chapter 3):**\n$$\n\\begin{array}{|l|l|}\n\\hline\n\\textbf{Register} & \\textbf{System Call Parameter Role} \\\\\n\\hline\n\\mathbf{\\text{RAX}} & \\mathbf{\\text{Syscall Number } (\\text{e.g. } 0=\\text{read}, 1=\\text{write}, 60=\\text{exit})} \\\\\n\\mathbf{\\text{RDI}} & \\text{Argument 1} \\\\\n\\mathbf{\\text{RSI}} & \\text{Argument 2} \\\\\n\\mathbf{\\text{RDX}} & \\text{Argument 3} \\\\\n\\mathbf{\\text{R10}} & \\mathbf{\\text{Argument 4 (Differs from C Function ABI!)}} \\\\\n\\mathbf{\\text{R8}} & \\text{Argument 5} \\\\\n\\mathbf{\\text{R9}} & \\text{Argument 6} \\\\\n\\hline\n\\end{array}\n$$\n• **Hardware Clobber Invariant:** `syscall` destroys **`RCX`** (stores return RIP) and **`R11`** (stores return RFLAGS)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential assembly instructions to execute sys_write(1, msg, 14) in bare x86-64 Linux assembly.",
      "orderItems": [
        "mov $1, %rax        # Load Linux x86-64 syscall number 1 for sys_write into RAX",
        "mov $1, %rdi        # Load file descriptor 1 (standard output STDOUT_FILENO) into RDI",
        "lea msg(%rip), %rsi # Load 64-bit memory address of string buffer into RSI",
        "mov $14, %rdx       # Load string character length in bytes into RDX",
        "syscall             # Execute hardware instruction to trap into Linux kernel Ring 0"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each x86-64 CPU Register to its exact Linux System Call ABI role.",
      "matchPairs": [
        { "left": "RAX Register", "right": "Holds the numeric system call opcode on entry and the kernel return value / error code on exit" },
        { "left": "RDI Register", "right": "Holds the first argument passed to the system call (e.g. file descriptor or path pointer)" },
        { "left": "R10 Register", "right": "Holds the fourth argument passed to the system call, substituting for hardware-clobbered RCX" },
        { "left": "RCX & R11 Registers", "right": "Clobbered automatically by CPU hardware during the syscall instruction to preserve RIP and RFLAGS" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the Linux x86-64 system call ABI, the fourth argument is passed in register ___.",
      "blankAnswer": "R10",
      "blankDistractors": ["RCX", "RDX", "RBX"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In standard x86-64 C function calling conventions (System V ABI), the 4th argument is passed in register RCX. Why does the Linux kernel System Call ABI require the 4th argument to be passed in register R10 instead?",
      "options": [
        { "text": "Because the x86-64 CPU hardware 'syscall' instruction automatically uses register RCX to save the user-space return Instruction Pointer (RIP) and register R11 to save RFLAGS; if the kernel ABI passed Argument 4 in RCX, the CPU hardware 'syscall' instruction would instantly overwrite and destroy the 4th argument before the kernel could read it", "isCorrect": true, "explanation": "Correct! This is one of the most famous low-level hardware/ABI details in systems programming (TLPI Section 3.1; CS:APP Chapter 8). 1. In standard user-space C function calling conventions, arguments are passed in: `RDI, RSI, RDX, RCX, R8, R9`. 2. However, consider the architectural specification of the x86-64 `syscall` instruction defined by AMD/Intel silicon: - When the CPU executes `syscall`, the processor transitions to Ring 0 privilege. - To remember where to return when the kernel later executes `sysret`, the CPU hardware automatically stores the current `RIP` (return address) into `RCX`! - Symmetrically, the CPU stores the current `RFLAGS` register into `R11`. 3. Because `RCX` is destroyed by the hardware silicon itself on EVERY syscall, user-space cannot pass data to the kernel in `RCX`! 4. The Linux kernel architects therefore substituted `R10` in place of `RCX` for the 4th argument: `RDI, RSI, RDX, R10, R8, R9`. This prevents hardware register clobbering." },
        { "text": "Because register RCX is only 32 bits wide", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because R10 is wired directly to the computer motherboard PCIe bus", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Linux kernels running on AMD processors cannot read RCX", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
