# Key to Flow: Linux System Calls (x86-64 ABI, Process Control, Pipes & dup2, Signals & epoll)

**Subject Area:** `03_Computer_Science_and_IT / 03_Operating_Systems_and_Systems_Programming / System_Programming_and_Assembly / Linux_System_Calls`

---

## 📌 Core Concept & Mental Model
**Hardware Ring 0 Privileged Traps, ABI Register Marshalling (`RAX`, `RDI`, `RSI`, `RDX`, `R10`, `R8`, `R9`), Process Tree Duplication/Overlay (`fork()`/`execve()`), File Descriptor Table Plumbing (`dup2()`), and Async-Signal-Safe Reentrancy** govern user-to-kernel boundary transitions and Linux systems programming (Michael Kerrisk *The Linux Programming Interface* [TLPI] Chapters 3, 4, 5, 20, 24, 63; CS:APP Chapter 8; System V AMD64 ABI):
* **1. The x86-64 Linux System Call Calling Convention:**
  - Invoked via hardware instruction: **`syscall`** (replaces legacy 32-bit `int 0x80`).
  - **Register Parameter Passing Order:**
    $$\mathbf{\text{Syscall Number} \longrightarrow \mathbf{\text{RAX}}}$$
    $$\mathbf{\text{Arg 1} \to \mathbf{\text{RDI}}, \quad \text{Arg 2} \to \mathbf{\text{RSI}}, \quad \text{Arg 3} \to \mathbf{\text{RDX}}, \quad \text{Arg 4} \to \mathbf{\text{R10}}, \quad \text{Arg 5} \to \mathbf{\text{R8}}, \quad \text{Arg 6} \to \mathbf{\text{R9}}}$$
    *(CRITICAL ABI RULE: Arg 4 is **`R10`**, NOT `RCX`, because `syscall` overwrites `RCX` with the return RIP address!)*
  - **Return Value:** Stored in **`RAX`**. Values in $[-4095, -1]$ indicate errors; C library glibc negates `RAX` into `errno` and returns `-1`.
  - Destroyed registers: `RCX` and `R11`.
* **2. Core Process Control System Calls:**
  - **`pid_t fork(void)`:** Clones the calling process using Copy-on-Write (COW). Returns `0` to the child process, returns child PID to the parent process, and returns `-1` on error.
  - **`int execve(const char *pathname, char *const argv[], char *const envp[])`:** Replaces the current process image entirely with a new executable. (Never returns on success; returns only on error!).
  - **`pid_t waitpid(pid_t pid, int *wstatus, int options)`:** Reaps terminated child processes to prevent **Zombie Processes** (`defunct`).
* **3. File Descriptor Manipulation & IPC Pipes (`pipe` + `dup2`):**
  - **`int pipe(int pipefd[2])`:** Creates a unidirectional kernel buffer:
    - `pipefd[0]`: Read end.
    - `pipefd[1]`: Write end.
  - **`int dup2(int oldfd, int newfd)`:** Atomically duplicates `oldfd` into `newfd` (e.g. `dup2(pipefd[1], STDOUT_FILENO)` redirects standard output to the pipe).
* **4. POSIX Signals & Async-Signal Safety (`sigaction`):**
  - **`int sigaction(int signum, const struct sigaction *act, struct sigaction *oldact)`:** Installs reliable signal handlers with explicit signal masks (`sa_mask`) to block nested signals during execution.
  - **Reentrancy & Async-Signal Safety:** Because a signal handler interrupts execution at any arbitrary instruction, **calling non-reentrant functions (e.g. `malloc()`, `free()`, `printf()`) inside a signal handler causes DEADLOCKS or HEAP CORRUPTION!** Only async-signal-safe calls (`write()`, `_exit()`) are permitted!
* **5. I/O Multiplexing Scaling (Select/Poll vs `epoll`):**
  - `select()` / `poll()`: $O(N)$ linear scan of all file descriptors on every event.
  - **`epoll` (`epoll_create1`, `epoll_ctl`, `epoll_wait`):** $O(1)$ event-driven notification backed by a kernel Red-Black tree and ready-list (solves the C10K connection problem).

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Unix Pipeline Mental Model (`cat file | grep text`)
* Step 1: Parent calls `pipe(fd)`.
* Step 2: Parent calls `fork()`.
* Step 3: Child 1 calls `dup2(fd[1], STDOUT_FILENO)`, closes `fd[0]`, and calls `execve("cat")`.
* Step 4: Child 2 calls `dup2(fd[0], STDIN_FILENO)`, closes `fd[1]`, and calls `execve("grep")`.
* Step 5: Parent closes both `fd[0]` and `fd[1]` and calls `waitpid()` twice!

### 2. Top Recommended Resources
* **The Definitive Standard:** *The Linux Programming Interface* (Michael Kerrisk), Chapters 3–5, 20–22, 24–28, 63.
* **Systems Architecture:** *Computer Systems: A Programmer's Perspective* (CS:APP 3rd Ed.), Chapter 8 (Exceptional Control Flow).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you write bare x86-64 assembly executing `sys_write` (RAX=1, RDI=1, RSI=buf, RDX=len, `syscall`)?
- [ ] Can you trace `fork()` return values and write child vs parent execution branches?
- [ ] Can you construct an IPC pipe and redirect stdout using `dup2()`?
- [ ] Can you explain why `printf()` is forbidden inside a `sigaction()` signal handler?
