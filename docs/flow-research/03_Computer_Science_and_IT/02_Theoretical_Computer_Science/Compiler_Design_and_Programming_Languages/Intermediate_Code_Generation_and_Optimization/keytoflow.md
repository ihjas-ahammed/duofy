# Key to Flow: Intermediate Code Generation and Optimization (SSA Form, CFGs, Dataflow Analysis, & Register Allocation)

**Subject Area:** `03_Computer_Science_and_IT / 02_Theoretical_Computer_Science / Compiler_Design_and_Programming_Languages / Intermediate_Code_Generation_and_Optimization`

---

## 📌 Core Concept & Mental Model
**Linearized Three-Address Code, Static Single Assignment (SSA) $\phi$-Placement, Basic Block Partitioning, Iterative Gen-Kill Fixed-Point Lattices, and Interference Graph Register Coloring** govern compiler intermediate representation, global optimizations, and machine code synthesis (Ron Cytron et al. 1991, Gary A. Kildall 1973, Gregory Chaitin 1981, Alfred V. Aho, Monica S. Lam, Ravi Sethi, & Jeffrey D. Ullman *The Dragon Book* Chapters 6, 8, & 9):
* **1. Intermediate Representations & SSA Form:**
  - **Three-Address Code (TAC):** Linearized instructions of form $x = y \text{ op } z$ (at most 3 memory/register addresses per instruction). Represented via Quadruples, Triples, or Indirect Triples.
  - **Static Single Assignment (SSA Form - Cytron et al. 1991):**
    - Every variable is assigned **EXACTLY ONCE**.
    - $\mathbf{\phi\text{-Function (Phi-Node)}}:$ Placed at control-flow merge points to select value based on which predecessor branch executed:
      $$\mathbf{x_3 = \phi(x_1, x_2)}$$
    - **Dominance Frontiers:** Optimal placement of $\phi$-nodes occurs at the dominance frontiers of basic blocks where definitions occur!
* **2. Control Flow Graphs (CFG) & Basic Blocks:**
  - **Basic Block:** A sequence of consecutive TAC instructions with **Single-Entry, Single-Exit** (execution enters only at first instruction and leaves only at the last without stopping or branching in the middle).
  - **The Leaders Algorithm (Partitioning):**
    1. Instruction 1 is a Leader.
    2. Any target of a conditional or unconditional jump is a Leader.
    3. Any instruction immediately following a jump is a Leader.
  - **Dominator Trees:** Block $d$ dominates block $n$ ($d \text{ dom } n$) if every path from entry to $n$ must pass through $d$.
* **3. Dataflow Analysis Frameworks (Kildall 1973):**
  - Iterative fixed-point equations based on **Gen** (facts created) and **Kill** (facts invalidated):
    $$\begin{array}{|l|l|l|l|l|}
    \hline
    \textbf{Analysis Name} & \textbf{Direction} & \textbf{Meet / Confluence} & \textbf{Transfer Equation} & \textbf{Optimization Use} \\
    \hline
    \mathbf{\text{Reaching Definitions}} & \text{Forward} & \bigcup \ (\text{May}) & \text{OUT}[B] = \text{GEN}[B] \cup (\text{IN}[B] \setminus \text{KILL}[B]) & \text{Constant Propagation} \\
    \mathbf{\text{Available Expressions}} & \text{Forward} & \bigcap \ (\text{Must}) & \text{OUT}[B] = \text{GEN}[B] \cup (\text{IN}[B] \setminus \text{KILL}[B]) & \text{Common Subexpr Elim (CSE)} \\
    \mathbf{\text{Live Variables}} & \mathbf{\text{Backward}} & \bigcup \ (\text{May}) & \text{IN}[B] = \text{USE}[B] \cup (\text{OUT}[B] \setminus \text{DEF}[B]) & \text{Dead Code Elim / Reg Alloc} \\
    \hline
    \end{array}$$
* **4. Register Allocation via Graph Coloring (Chaitin 1981 / Kempe's Heuristic):**
  - Maps infinite virtual variables to $K$ physical hardware registers.
  - **Interference Graph $G = (V, E)$:** Nodes are variable live ranges; edge $(u, v) \in E$ exists if variables $u$ and $v$ are **simultaneously live** at some program point (cannot share the same physical register).
  - **Kempe's $K$-Coloring Heuristic (Build-Simplify-Spill-Select):**
    - If node $u$ has $\text{degree}(u) < K$, remove $u$ and push to stack (it can always be colored later!).
    - If all nodes have $\text{degree} \ge K$, pick a candidate to **spill to memory** (stack frame).

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Dataflow Direction Rule of Thumb
* Looking forward to see what *might reach* $\to$ Forward + Union (Reaching Defs).
* Looking forward to see what *must be computed* $\to$ Forward + Intersection (Available Exprs).
* Looking backward to see what *is needed later* $\to$ Backward + Union (Live Variables).

### 2. Top Recommended Resources
* **The Compiler Standard:** *Compilers: Principles, Techniques, and Tools* (The Dragon Book), Chapters 8 & 9.
* **Modern Compilers:** *Engineering a Compiler* by Keith Cooper & Linda Torczon.

---

## 🎯 Problem-Solving Checklist
- [ ] Can you partition a sequence of Three-Address Code instructions into Basic Blocks using the Leaders algorithm?
- [ ] Can you place $\phi$-functions and rename variables to convert code into SSA form?
- [ ] Can you write and solve Gen-Kill transfer equations for Live Variable Analysis?
- [ ] Can you construct an Interference Graph and execute Chaitin's $K$-register coloring algorithm?
