# Key to Flow: KVL, KCL, & Node/Mesh Analysis (Circuit Foundations & Systematic Solvers)

**Subject Area:** `04_Engineering_and_Technology / 02_Electrical_and_Electronics_Engineering / Electric_Circuits_and_Network_Theory / KVL_KCL_and_Node_Mesh_Analysis`

---

## 📌 Core Concept & Mental Model
**Kirchhoff's Current Law (KCL $\sum i_k = 0$, Conservation of Charge at Nodes), Kirchhoff's Voltage Law (KVL $\sum v_k = 0$, Conservation of Energy in Closed Loops), Systematic Nodal Analysis Formulation ($[G][V] = [I]$), Supernode Formulation for Voltage Sources Between Non-Reference Nodes ($v_1 - v_2 = V_s$), Systematic Mesh Analysis Formulation ($[R][I] = [V]$), Supermesh Formulation for Current Sources Shared Between Adjacent Meshes ($i_2 - i_1 = I_s$), Four Types of Dependent Sources (VCVS, CCVS, VCCS, CCCS), and Cramer's Rule Matrix Synthesis for Planar Bridge Networks** govern all linear circuit analysis (Charles K. Alexander, Matthew N.O. Sadiku *Fundamentals of Electric Circuits* Chapters 2 & 3; James W. Nilsson, Susan A. Riedel *Electric Circuits* 11th ed. Chapters 2-4; William H. Hayt, Jack E. Kemmerly *Engineering Circuit Analysis* 9th ed.):
* **1. Kirchhoff's Conservation Laws:**
  $$\mathbf{\text{KCL: } \sum_{k=1}^N i_k = 0 \quad (\text{Conservation of Charge at Node})} \quad \Big| \quad \mathbf{\text{KVL: } \sum_{k=1}^M v_k = 0 \quad (\text{Conservation of Energy in Closed Loop})}$$
* **2. Nodal Analysis & The Supernode Invariant:**
  - Standard Conductance Matrix:
    $$\mathbf{\begin{bmatrix} G_{11} & -G_{12} \\ -G_{21} & G_{22} \end{bmatrix} \begin{bmatrix} v_1 \\ v_2 \end{bmatrix} = \begin{bmatrix} i_1 \\ i_2 \end{bmatrix} \quad \left(G_{kk} = \sum \text{Conductances at node } k, \ G_{jk} = \text{Mutual Conductance}\right)}$$
  - **Supernode Invariant:** When an ideal voltage source is connected between two non-reference nodes $v_1$ and $v_2$, bypass unknown source current by enclosing the source in a **Supernode**, write KCL for the combined boundary, and apply the constraint equation:
    $$\mathbf{v_1 - v_2 = V_{\text{source}}}$$
* **3. Mesh Analysis & The Supermesh Invariant:**
  - Standard Resistance Matrix ($M = B - N + 1$ independent loops):
    $$\mathbf{\begin{bmatrix} R_{11} & -R_{12} \\ -R_{21} & R_{22} \end{bmatrix} \begin{bmatrix} i_1 \\ i_2 \end{bmatrix} = \begin{bmatrix} v_1 \\ v_2 \end{bmatrix} \quad \left(R_{kk} = \sum \text{Resistances in mesh } k, \ R_{jk} = \text{Shared Mutual Resistance}\right)}$$
  - **Supermesh Invariant:** When an ideal current source is shared between two adjacent meshes $i_1$ and $i_2$, bypass the current branch to form a **Supermesh**, write KVL around the outer perimeter, and apply the constraint equation:
    $$\mathbf{i_2 - i_1 = I_{\text{source}}}$$
* **4. Dependent Sources & Matrix Augmentation:**
  - Four Active Control Topologies:
    1. **VCVS:** $v_d = \mu v_x$ (Voltage-Controlled Voltage Source);
    2. **CCVS:** $v_d = r i_x$ (Current-Controlled Voltage Source, Transresistance);
    3. **VCCS:** $i_d = g_m v_x$ (Voltage-Controlled Current Source, Transconductance);
    4. **CCCS:** $i_d = \beta i_x$ (Current-Controlled Current Source, Current Gain).

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Circuit Analysis Problem-Solving Spectrum
* Method Selection $\to$ Count essential nodes $N$ vs planar meshes $M$. If $(N-1) < M$, choose Nodal Analysis; if $M < (N-1)$, choose Mesh Analysis.
* Supernode Check $\to$ Are voltage sources floating between non-reference nodes? If yes, enclose in supernode and write constraint $v_a - v_b = V_s$.
* Supermesh Check $\to$ Are current sources shared between adjacent loops? If yes, remove branch to write supermesh KVL and constraint $i_b - i_a = I_s$.
* Matrix Solution $\to$ Formulate $[A][X] = [B] \to$ Solve using Cramer's Rule $x_k = \frac{\det(A_k)}{\det(A)}$ or Gaussian elimination.

### 2. Top Recommended Resources
* **The Global Standard:** *Fundamentals of Electric Circuits* (Charles K. Alexander, Matthew N.O. Sadiku, McGraw-Hill 7th ed. Chapters 2 & 3).
* **The Engineering Classic:** *Engineering Circuit Analysis* (William H. Hayt, Jack E. Kemmerly, Steven M. Durbin, McGraw-Hill 9th ed. Chapters 2-4).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you apply KCL at a node to express branch currents in terms of node voltages $\frac{v_a - v_b}{R}$?
- [ ] Can you form and solve a Supernode containing an ideal floating voltage source?
- [ ] Can you write a Supermesh KVL equation bypassing a shared current source?
- [ ] Can you handle dependent sources (VCVS, VCCS, CCVS, CCCS) in nodal and mesh matrices?
- [ ] Can you solve a bridge network using Cramer's determinant rule?
