# Key to Flow: Computer Architecture and Hardware

**Subject Area:** `03_Computer_Science_and_IT / 08_Computer_Architecture_and_Hardware`

---

## 📌 Core Concept & Mental Model
Computer Architecture bridges digital hardware logic with software instruction sets, designing CPUs, pipelines, memory hierarchies, and buses for maximum execution performance ($T_{\text{exec}} = \text{Instructions} \times \text{CPI} \times \text{Clock Cycle Time}$).

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. Digital Logic & Instruction Set Architecture (ISA)
* **Digital Logic:** Boolean Algebra, K-Maps, Muxes, Adders, ALU, Flip-Flops, Sequential State Machines.
* **ISA (RISC vs CISC):** RISC-V / ARM (Fixed length instructions, load-store architecture) vs x86 (Variable length instructions).

### 2. Pipelining & Memory Hierarchy
* **5-Stage RISC Pipeline:** Instruction Fetch (IF), Instruction Decode (ID), Execute (EX), Memory Access (MEM), Write Back (WB).
* **Pipeline Hazards:**
  * **Structural Hazards:** Resource conflicts.
  * **Data Hazards:** RAW (Read-After-Write) resolved by **Data Forwarding** / Bypassing.
  * **Control Hazards:** Branching delay resolved by **Branch Predictors** (2-bit saturating counters, Tournament predictors).
* **Memory Hierarchy:** Registers $\to$ L1/L2/L3 Caches $\to$ RAM $\to$ SSD. Cache Mapping (Direct-mapped, Set-associative, Fully-associative).

### 3. Top Recommended Resources
* **The Computer Architecture Bible:** *Computer Organization and Design (RISC-V Edition)* by Patterson & Hennessy.
* **Advanced Architecture Classic:** *Computer Architecture: A Quantitative Approach* by Hennessy & Patterson.

---

## 🎯 Problem-Solving Checklist
- [ ] Can you minimize Boolean functions using Karnaugh Maps (K-Maps)?
- [ ] Can you trace instruction execution through a 5-stage RISC pipeline and detect data/control hazards?
- [ ] Can you calculate Average Memory Access Time (AMAT = $\text{Hit Time} + \text{Miss Rate} \times \text{Miss Penalty}$)?
- [ ] Can you map memory addresses to Tag, Index, and Offset fields in cache lookup?
