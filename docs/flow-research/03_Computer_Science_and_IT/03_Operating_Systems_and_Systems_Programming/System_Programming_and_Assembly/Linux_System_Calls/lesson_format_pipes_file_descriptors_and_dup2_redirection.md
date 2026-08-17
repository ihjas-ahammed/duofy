# Duofy Reusable Lesson Format: Pipes, File Descriptors, and dup2 Redirection

**Target Topic:** `03_Computer_Science_and_IT / 03_Operating_Systems_and_Systems_Programming / System_Programming_and_Assembly / Linux_System_Calls`  
**Lesson Format Type:** `pipes_file_descriptors_and_dup2_redirection`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the kernel file table data structures, anonymous circular buffer pipes, and standard I/O redirection plumbing using `pipe()` and `dup2()` (Michael Kerrisk *The Linux Programming Interface* Chapters 4, 5, & 44; Bryant & O'Hallaron CS:APP Chapter 8.5 & 10): master the **Three-Level Kernel File Representation** (Per-process File Descriptor Table $\to$ Open File Table [file offset, status flags] $\to$ Inode Table), master **Anonymous Unidirectional Pipes via `int pipe(int pipefd[2])`** (`pipefd[0]` for read, `pipefd[1]` for write), master **I/O Redirection via `int dup2(int oldfd, int newfd)`** (atomically closing `newfd` if open and duplicating `oldfd` into `newfd`), and build a complete Unix shell pipeline (`cmd1 | cmd2`) with proper pipe closing to prevent **End-of-File (EOF) Deadlocks** (readers blocking forever if any write end remains unclosed in the parent).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | 3-Level File Table Architecture, Pipe Buffer Semantics, & dup2() Invariant Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Shell Implementation of Pipeline `ls | grep txt` Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | File Descriptor / Syscall Entity & Pipeline Plumbing Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Array Index of the Read End of an Anonymous Pipe Returned by pipe(p) (0) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Analysis of the EOF Read Hang Bug Caused by Forgetting to Close Pipe Write Ends Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State File Descriptors, Pipes & `dup2()` (TLPI Chapters 4, 5, 44; CS:APP 8 & 10):
   - **The 3 Standard Streams:** `0 = STDIN_FILENO`, `1 = STDOUT_FILENO`, `2 = STDERR_FILENO`.
   - **Anonymous Pipes (`pipe(int p[2])`):**
     $$\mathbf{\text{p}[0] \longrightarrow \text{READ End} \qquad \qquad \mathbf{\text{p}[1] \longrightarrow \text{WRITE End}}}$$
     - A unidirectional $64\text{ KB}$ FIFO ring buffer in kernel memory.
   - **Redirection via `dup2(oldfd, newfd)`:**
     $$\mathbf{\text{dup2}(\text{p}[1], \text{STDOUT\_FILENO}) \implies \text{Redirects printf / stdout into pipe write end!}}$$
   - **The Pipe EOF Rule:** A reader reading from `p[0]` receives **EOF (returns 0)** if and only if **ALL write descriptors (`p[1]`) referencing the pipe across ALL processes in the system are CLOSED**! (If the parent forgets to `close(p[1])`, the reader hangs forever!).
2. **Slide 2 (`ordering`):** Provide 5 steps of executing `ls | grep txt` in C: (1) parent creates pipe array `int p[2]` via `pipe(p)`, (2) parent forks Child 1 (`ls`): Child 1 calls `dup2(p[1], STDOUT_FILENO)`, closes both `p[0]` and `p[1]`, and execs `ls`, (3) parent forks Child 2 (`grep`): Child 2 calls `dup2(p[0], STDIN_FILENO)`, closes both `p[0]` and `p[1]`, and execs `grep`, (4) parent closes both its copies of `p[0]` and `p[1]` so EOF can be signaled to grep, (5) parent calls `waitpid()` for both children to reap their exit codes!
3. **Slide 3 (`matching`):** Pair 4 pipeline syscalls/descriptors (pipefd[0], pipefd[1], dup2(p[1], 1), close(p[1]) in parent) with their pipeline functions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that pipefd[0] is the read end. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the pipe EOF hang bug: In a C program creating a pipeline `cmd1 | cmd2`, the parent process creates a pipe `pipe(p)`, forks Child 1 (which writes to `p[1]`), and forks Child 2 (which reads from `p[0]`). What happens if the parent process forgets to call `close(p[1])` before calling `waitpid()`? (Child 2 will read all output produced by Child 1; however, when Child 1 terminates, Child 2's subsequent `read()` call will **NOT return 0 (EOF) because the parent process still holds an open write descriptor `p[1]` pointing to the pipe**; Child 2 will hang blocked forever waiting for more input, resulting in an application deadlock).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "pipes_file_descriptors_and_dup2_redirection",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Pipes, FDs, & dup2() Redirection (TLPI Ch 44)**\n• **Standard File Descriptors:** $0 = \\text{stdin}, \\ 1 = \\text{stdout}, \\ 2 = \\text{stderr}$.\n• **Anonymous Pipe Architecture:**\n$$\n\\mathbf{\\text{pipe}(\\text{int p}[2]) \\implies \\mathbf{\\text{p}[0] = \\text{READ END}} \\ ; \\quad \\mathbf{\\text{p}[1] = \\text{WRITE END}}}\n$$\n• **Atomic Redirection (`dup2`):**\n$$\n\\mathbf{\\text{dup2}(\\text{p}[1], \\text{STDOUT\\_FILENO}) \\implies \\text{Redirects stdout to pipe write end!}}\n$$\n• **The Absolute EOF Rule:** `read(p[0])` returns **EOF (0)** if and only if **EVERY write descriptor `p[1]` referencing the pipe across ALL processes is CLOSED**! (If parent fails to `close(p[1])`, readers hang forever!)."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of implementing a Unix shell pipe 'ls | wc -l' in C.",
      "orderItems": [
        "Create an anonymous kernel pipe buffer by calling pipe(p), obtaining read end p[0] and write end p[1]",
        "Fork Child 1: inside child, call dup2(p[1], STDOUT_FILENO), close both p[0] and p[1], and execve(\"/bin/ls\")",
        "Fork Child 2: inside child, call dup2(p[0], STDIN_FILENO), close both p[0] and p[1], and execve(\"/usr/bin/wc\")",
        "Inside parent shell process, close BOTH p[0] and p[1] to ensure all parent write references are destroyed",
        "Invoke waitpid() twice in parent to reap both child processes and complete the pipeline"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Unix Pipeline Primitive to its exact functional role.",
      "matchPairs": [
        { "left": "pipefd[0]", "right": "The read descriptor end of the pipe; reads return bytes written to pipefd[1]" },
        { "left": "pipefd[1]", "right": "The write descriptor end of the pipe; writes append data to the 64KB kernel ring buffer" },
        { "left": "dup2(pipefd[1], 1)", "right": "Redirects standard output (descriptor 1) so printf writes directly into the pipe buffer" },
        { "left": "Parent close(pipefd[1])", "right": "Crucial cleanup step ensuring EOF is properly signaled to the reader when writer exits" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In an anonymous pipe created via pipe(int p[2]), the read end of the pipe is stored at index p[___].",
      "blankAnswer": "0",
      "blankDistractors": ["1", "2", "3"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In a C program creating a pipeline 'writer | reader', the parent process creates pipe(p), forks the writer child (which writes to p[1]), and forks the reader child (which reads from p[0]). What happens if the parent process forgets to execute close(p[1])?",
      "options": [
        { "text": "The reader child will read all data emitted by the writer child; however, when the writer child terminates, the reader's subsequent read(p[0]) call will NOT return 0 (EOF) because the parent process still holds an active, open write descriptor p[1] referencing the pipe buffer; the reader will block indefinitely waiting for data that will never arrive, causing the pipeline to hang forever", "isCorrect": true, "explanation": "Correct! This is one of the most classic and subtle bugs encountered when writing Unix shells (TLPI Section 44.2; CS:APP Chapter 10). 1. The POSIX kernel semantics for pipes state: A `read()` on a pipe returns `0` (End of File) ONLY when the pipe buffer is empty AND there are ZERO open file descriptors pointing to the write end of the pipe in the entire operating system! 2. When the parent calls `pipe(p)`, the parent possesses an open write descriptor `p[1]`. 3. When the parent forks the writer child, the child inherits a copy of `p[1]`. 4. When the parent forks the reader child, the child inherits copies of both `p[0]` and `p[1]`. 5. When the writer child finishes writing and calls `exit()`, its copy of `p[1]` is closed. 6. BUT because the parent process forgot to call `close(p[1])`, the parent's copy of `p[1]` remains open in the kernel's open file table! 7. The kernel checks: 'Is there still an open write descriptor?' YES (in the parent). 8. Therefore, the kernel refuses to send EOF to the reader! The reader calls `read(p[0])` and sleeps forever waiting for more data. The entire pipeline hangs indefinitely until killed. 9. Always remember: Close all unused pipe ends in both parent and children!" },
        { "text": "The operating system automatically closes all parent descriptors when a child forks", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The reader child crashes immediately with a segmentation fault", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The pipe data is permanently written to the root disk partition", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
