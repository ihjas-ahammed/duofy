# Key to Flow: Memory Allocation (Malloc, Free, Free Lists, Boundary Tags, & Buddy System)

**Subject Area:** `03_Computer_Science_and_IT / 03_Operating_Systems_and_Systems_Programming / Memory_Management / Memory_Allocation_Malloc_Free`

---

## 📌 Core Concept & Mental Model
**Inline Embedded Metadata, Bitwise Chunk Size/Alloc Flags, Boundary Tag Bidirectional Traversal, Free List Topologies (Implicit, Explicit, Segregated), and Power-of-2 Buddy XOR Bit-Flipping** govern user-space heap allocators and kernel memory management (Donald E. Knuth 1973 *The Art of Computer Programming Vol 1*; Kenneth C. Knowlton 1965 Buddy Allocator; Doug Lea `dlmalloc` 1996; glibc `ptmalloc2`; Jason Evans `jemalloc`; Randal E. Bryant & David R. O'Hallaron *CS:APP* Chapter 9.9; OSTEP Chapter 17):
* **1. The Heap & OS System Calls (`sbrk` vs `mmap`):**
  - **`brk(addr)` / `sbrk(incr)`:** Grows or shrinks the process's contiguous data segment by moving the `brk` pointer upwards in virtual address space.
  - **`mmap(NULL, size, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)`:** Maps a discrete, independent virtual memory region (used by `malloc` for large chunks $> 128\text{ KB}$ so they can be independently returned to the OS via `munmap()`).
* **2. Chunk Memory Layout & Bitwise Encoding:**
  - Because heap blocks must be aligned (e.g., 8-byte or 16-byte alignment), the lowest bits of the block size are ALWAYS zero ($000_2$).
  - **Bit Packing Trick:** The lowest bit ($b_0$) is repurposed as the **Allocated Bit ($a = 1$ allocated, $a = 0$ free)**:
    $$\mathbf{\text{Header Word} = \text{BlockSize} \mid a}$$
    - To extract size: $\mathbf{\text{Size} = \text{Header} \ \& \ \sim 0x7}$.
    - To extract allocation flag: $\mathbf{\text{Alloc} = \text{Header} \ \& \ 0x1}$.
* **3. Donald Knuth's Boundary Tags ($O(1)$ Coalescing - 1973):**
  - Problem: Finding the *next* chunk is easy ($\text{ptr} + \text{size}$), but finding the *previous* chunk requires scanning the entire heap from the beginning ($O(N)$).
  - **Solution:** Add a **Footer (Boundary Tag)** at the bottom of each free chunk that is an exact mirror copy of the header!
  - **The 4 Coalescing Cases:**
    1. Case 1: Prev allocated, Next allocated $\implies$ No coalescing.
    2. Case 2: Prev allocated, Next free $\implies$ Merge current with next ($O(1)$).
    3. Case 3: Prev free, Next allocated $\implies$ Merge current with prev ($O(1)$).
    4. Case 4: Prev free, Next free $\implies$ Merge prev, current, and next ($O(1)$).
* **4. Free List Architectures & Search Policies:**
  $$\begin{array}{|l|l|l|l|}
  \hline
  \textbf{Free List Type} & \textbf{Data Structure} & \textbf{Search Time} & \textbf{Memory Overhead} \\
  \hline
  \mathbf{\text{Implicit List}} & \text{Header chain across all blocks (free + alloc)} & O(N) \text{ (All blocks)} & \text{Lowest (Header + Footer)} \\
  \mathbf{\text{Explicit List}} & \text{Doubly linked list embedded in free payloads} & O(F) \text{ (Free blocks only)} & \text{Min 16B free chunk payload} \\
  \mathbf{\text{Segregated List}} & \text{Array of free lists indexed by size classes} & \mathbf{O(1) \text{ to } O(\log N)} & \text{High throughput (jemalloc standard)} \\
  \hline
  \end{array}$$
  - **Placement Policies:** First Fit (fast), Next Fit (balances fragmentation), Best Fit (minimal internal fragmentation, slower search).
* **5. The Buddy Allocator (Knowlton 1965):**
  - Allocates blocks in powers of 2 ($2^k$).
  - **Instant Buddy Address Computation via XOR:**
    $$\mathbf{\text{Buddy Address} = \text{Address} \oplus 2^k}$$
  - On `free()`, check if buddy is free; if yes, merge and repeat recursively!

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Inline Payload Metaphor
* When a block is **allocated**, the application owns the payload bytes.
* When a block is **freed**, the allocator re-uses the exact same payload memory to store `prev` and `next` pointers for the explicit free list!

### 2. Top Recommended Resources
* **The Systems Standard:** *Computer Systems: A Programmer's Perspective* (CS:APP 3rd Ed.), Bryant & O'Hallaron (Section 9.9).
* **OSTEP Dynamic Memory:** *Operating Systems: Three Easy Pieces*, Chapter 17 (Free-Space Management).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you extract block size and allocation status from an integer header using bitwise masking?
- [ ] Can you trace the 4 coalescing cases using Knuth boundary tags in $O(1)$ time?
- [ ] Can you compute the buddy address for a block of size $2^k$ using the XOR formula $A \oplus 2^k$?
- [ ] Can you differentiate between internal and external memory fragmentation?
