# Duofy Reusable Lesson Format: Process Control Syscalls (fork, execve, and waitpid)

**Target Topic:** `03_Computer_Science_and_IT / 03_Operating_Systems_and_Systems_Programming / System_Programming_and_Assembly / Linux_System_Calls`  
**Lesson Format Type:** `process_control_syscalls_fork_execve_and_waitpid`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the process lifecycle mechanics, address space cloning with Copy-on-Write (COW), executable overlays, and zombie reaping across the classical Unix process control triad (Michael Kerrisk *The Linux Programming Interface* Chapters 24, 26, & 27; Bryant & O'Hallaron CS:APP Chapter 8.4; Abraham Silberschatz et al.): master **`pid_t fork(void)`** (returning `0` to the child, child PID to the parent, and `-1` on failure; creating an exact duplicate via Copy-on-Write), master **`int execve(path, argv, envp)`** (completely replacing the current process image, text, stack, and heap with a new binary; never returning on success), master **`pid_t waitpid(pid, &wstatus, options)`** (synchronizing termination, decoding exit status via `WIFEXITED` / `WEXITSTATUS`, and eliminating **Zombie Processes [`defunct`]** vs **Orphan Processes** re-parented to `init`/`systemd`), and write robust shell process execution pipelines.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Process Control Triad (fork, execve, waitpid), COW Semantics, & Zombie Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Shell Execution Lifecycle for Running `/bin/ls` Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Process Control System Call / Macro & Exact System Function Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Name of a Terminated Process Whose Parent Has Not Yet Called waitpid() (Zombie) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Trace and Output Analysis of Nested fork() Calls in C Programs Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Process Control Syscalls (TLPI Chapters 24, 26, 27; CS:APP 8.4):
   - **The Classic Process Triad:**
     1. **`pid_t fork(void)`:** Creates child clone via Copy-on-Write (COW).
        - Returns **`0` in the child** process.
        - Returns **`child_pid > 0` in the parent** process.
        - Returns **`-1` on failure** (`errno = EAGAIN`/`ENOMEM`).
     2. **`int execve(const char *pathname, char *const argv[], char *const envp[])`:**
        - Overwrites address space with new program. **NEVER returns on success!**
     3. **`pid_t waitpid(pid_t pid, int *wstatus, int options)`:**
        - Collects exit status and reaps terminated child.
   - **Zombies vs Orphans:**
     - **Zombie Process (`<defunct>`):** Child terminated, but parent hasn't called `wait()`. Retains PCB entry in kernel process table!
     - **Orphan Process:** Parent died while child still running. Re-parented to PID 1 (`init` / `systemd`), which automatically reaps it.
2. **Slide 2 (`ordering`):** Provide 5 steps of a shell executing command '/bin/ls': (1) shell reads command line string and parses arguments into argv array, (2) shell invokes fork() to create child process clone, (3) child process branch executes execve('/bin/ls', argv, envp), replacing its image, (4) parent shell executes waitpid(child_pid, &status, 0), blocking until child completes, (5) child finishes; kernel reaps child and wakes parent shell to display next prompt!
3. **Slide 3 (`matching`):** Pair 4 process syscalls/macros (fork(), execve(), waitpid(), WEXITSTATUS(status)) with their functions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that an un-reaped terminated process is a zombie process. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on tracing nested `fork()` tree execution: A C program executes the code: `fork(); fork(); printf("Duofy\n");`. How many total times will the string "Duofy" be printed to the terminal? (A single `fork()` doubles the number of processes: the initial 1 process creates 1 child ($2^1 = 2$ processes); the second `fork()` is executed by BOTH existing processes, doubling the count again ($2^2 = \mathbf{4\text{ total processes}}$); each of the 4 concurrent processes executes `printf()`, printing "Duofy" exactly **4 times**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "process_control_syscalls_fork_execve_and_waitpid",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Unix Process Control Triad (TLPI Ch 24-27)**\n• **The 3 Foundational System Calls:**\n$$\n\\begin{array}{|l|l|}\n\\hline\n\\textbf{System Call} & \\textbf{Operational Semantics} \\\\\n\\hline\n\\mathbf{\\text{fork}()} & \\text{Clones process via COW: returns } \\mathbf{0} \\text{ to child, } \\mathbf{\\text{PID}} \\text{ to parent} \\\\\n\\mathbf{\\text{execve}(\\text{path}, \\text{argv}, \\text{envp})} & \\mathbf{\\text{Overlays address space with new ELF binary; NEVER returns!}} \\\\\n\\mathbf{\\text{waitpid}(\\text{pid}, \\&\\text{status}, \\text{opt})} & \\text{Synchronizes with child termination and reaps kernel PCB} \\\\\n\\hline\n\\end{array}\n$$\n• **Zombies vs Orphans (CS:APP Chapter 8):**\n  - **Zombie (`<defunct>`):** Child died, parent hasn't reaped via `waitpid()`. Leaks PID table entry!\n  - **Orphan:** Parent died while child active. Adopted and reaped automatically by PID 1 (`init`/`systemd`)."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed by a Unix shell running the command '/bin/ls -la'.",
      "orderItems": [
        "Parse command line input tokens into an argument array: argv = {\"/bin/ls\", \"-la\", NULL}",
        "Invoke the fork() system call to duplicate the shell into an identical child process",
        "Inside child branch (pid == 0), invoke execve(\"/bin/ls\", argv, envp) to load executable binary",
        "Inside parent branch (pid > 0), invoke waitpid(pid, &status, 0) to suspend until child finishes",
        "Kernel terminates child, delivers SIGCHLD, and unblocks parent shell to print next prompt"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Process Control System Call / Macro to its exact kernel behavior.",
      "matchPairs": [
        { "left": "fork() System Call", "right": "Clones calling process using Copy-on-Write; returns 0 in child and child PID in parent" },
        { "left": "execve() System Call", "right": "Replaces text, data, heap, and stack segments with new binary; never returns on success" },
        { "left": "waitpid() System Call", "right": "Suspends caller until specific child terminates, reclaiming its PCB and clearing zombie state" },
        { "left": "WEXITSTATUS(wstatus)", "right": "Macro extracting the low-order 8 bits of the return status passed by child to exit()" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "A terminated process whose exit status has not yet been collected by its parent via waitpid() is called a ___ process.",
      "blankAnswer": "zombie",
      "blankDistractors": ["orphan", "daemon", "reaper"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Consider the following C program execution trace: int main() { fork(); fork(); printf(\"Duofy\\n\"); return 0; } How many total times will the string 'Duofy' be printed to the standard output?",
      "options": [
        { "text": "4 times; the first fork() creates 1 child process, resulting in 2 active processes; both of these processes then execute the second fork(), each spawning another child process (2 * 2 = 4 total processes); all 4 concurrent processes subsequently execute printf(\"Duofy\\n\"), outputting exactly 4 lines", "isCorrect": true, "explanation": "Correct! This is a classic systems programming process-tree question (CS:APP Chapter 8.4). 1. Initially, there is 1 parent process ($P_0$). 2. Step 1 (`fork()`): - $P_0$ forks and creates child $P_1$. - Active processes: $\\{P_0, P_1\\}$ (Total = $2^1 = 2$). 3. Step 2 (`fork()`): - $P_0$ executes the second `fork()` and creates child $P_2$. - Symmetrically, $P_1$ ALSO executes the second `fork()` and creates child $P_3$. - Active processes: $\\{P_0, P_1, P_2, P_3\\}$ (Total = $2^2 = 4$). 4. Step 3 (`printf(\"Duofy\\n\")`): - All 4 independent running processes reach the print statement and output 'Duofy'. 5. Total output lines $= 4$. In general, $n$ consecutive `fork()` calls create $2^n$ processes." },
        { "text": "2 times", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "3 times", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "8 times", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
