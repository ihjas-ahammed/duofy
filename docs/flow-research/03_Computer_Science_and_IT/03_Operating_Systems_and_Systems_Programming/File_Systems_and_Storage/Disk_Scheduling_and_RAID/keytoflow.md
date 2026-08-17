# Key to Flow: Disk Scheduling and RAID (Elevator SCAN, Head Movement, RAID 0/1/5/6/10, & Small Write Penalty)

**Subject Area:** `03_Computer_Science_and_IT / 03_Operating_Systems_and_Systems_Programming / File_Systems_and_Storage / Disk_Scheduling_and_RAID`

---

## 📌 Core Concept & Mental Model
**Mechanical Actuator Seek Latency Minimization, Directional Track Sweeps, Block-Level Striping, and XOR/Reed-Solomon Parity Reconstruction** govern magnetic disk performance, hardware storage arrays, and high-availability enterprise fault tolerance (P.J. Denning 1967, David A. Patterson, Garth Gibson, & Randy H. Katz 1987, Silberschatz et al. Chapters 10 & 11, OSTEP Chapters 37 & 38):
* **1. Magnetic Disk Access Latency Formulation:**
  $$\mathbf{\text{Total Access Time} = \text{Seek Time } (T_{\text{seek}}) + \text{Rotational Latency } (T_{\text{rot}}) + \text{Transfer Time } (T_{\text{trans}})}$$
  - Mechanical seek time ($T_{\text{seek}} \approx 3\text{--}10\text{ ms}$) dominates over RAM ($100\text{ ns}$) by a factor of $100,000\times$.
* **2. Disk Scheduling Algorithms:**
  - **FCFS (First-Come, First-Served):** Fair, but excessive wild swinging across disk tracks.
  - **SSTF (Shortest Seek Time First):** Greedily services closest track $\implies$ **Starvation Risk** for distant requests!
  - **SCAN (Elevator Algorithm):** Sweeps in one direction to the extreme boundary (cylinder 0 or $\text{Max}$), then reverses.
  - **C-SCAN (Circular SCAN):** Sweeps in one direction, then immediately jumps back to track 0 without servicing on the return $\implies$ **Uniform Wait Time**!
  - **LOOK & C-LOOK:** Optimizations that reverse/reset at the **last pending request** rather than traveling all the way to physical disk boundaries.
* **3. RAID Architecture (Redundant Array of Independent Disks - 1987):**
  $$\begin{array}{|l|l|l|l|l|l|}
  \hline
  \textbf{RAID Level} & \textbf{Mechanism} & \textbf{Capacity} & \textbf{Fault Tolerance} & \textbf{Write Penalty} & \textbf{Best Use Case} \\
  \hline
  \mathbf{\text{RAID 0}} & \text{Striping (Block-level)} & N \cdot C & 0 \text{ Disks (No Redundancy)} & 1\times & \text{High-perf scratch/gaming} \\
  \mathbf{\text{RAID 1}} & \text{Mirroring (100\% Duplication)} & \frac{N}{2} \cdot C & \frac{N}{2} \text{ Disks (1 per pair)} & 2\times & \text{OS boot drives, fast reads} \\
  \mathbf{\text{RAID 5}} & \text{Striping + Distributed Parity} & (N - 1) \cdot C & \mathbf{1 \text{ Disk Failure}} & \mathbf{4\times \text{ Small Write}} & \text{General file storage} \\
  \mathbf{\text{RAID 6}} & \text{Striping + Dual Parity (P+Q)} & (N - 2) \cdot C & \mathbf{2 \text{ Disk Failures}} & \mathbf{6\times \text{ Small Write}} & \text{Large high-density HDDs} \\
  \mathbf{\text{RAID 10}} & \text{Stripe of Mirrors (1 + 0)} & \frac{N}{2} \cdot C & \ge 1 \text{ Disk (up to } N/2\text{)} & 2\times & \text{High-I/O DBs, fast rebuild} \\
  \hline
  \end{array}$$
* **4. The RAID 5 "Small Write Penalty" (4 I/Os):**
  - To overwrite a single block $D_{\text{new}}$:
    $$\mathbf{P_{\text{new}} = (D_{\text{old}} \oplus D_{\text{new}}) \oplus P_{\text{old}}}$$
  - Requires **4 Physical Disk Operations:**
    1. Read $D_{\text{old}}$ (Read 1),
    2. Read $P_{\text{old}}$ (Read 2),
    3. Write $D_{\text{new}}$ (Write 1),
    4. Write $P_{\text{new}}$ (Write 2) $\implies$ **$4\times$ IOPS Penalty!**

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The 1D Number Line Head Trajectory
* Draw tracks on a horizontal axis ($0 \dots 199$). Plot requests and trace arm movements explicitly to calculate $\sum |\text{track}_{i+1} - \text{track}_i|$.

### 2. Top Recommended Resources
* **The OS Standard:** *Operating System Concepts* (Silberschatz, Galvin, Gagne), Chapters 10 & 11.
* **Systems Classic:** *Operating Systems: Three Easy Pieces* (OSTEP), Chapters 37 (Hard Disks) & 38 (RAID).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you calculate Total Head Movement for FCFS, SSTF, SCAN, C-SCAN, LOOK, and C-LOOK?
- [ ] Can you compute storage efficiency and disk fault tolerance across RAID 0, 1, 5, 6, and 10?
- [ ] Can you derive the 4 I/O steps of the RAID 5 small write penalty using XOR algebra?
- [ ] Can you explain why RAID 10 rebuilds are much safer than RAID 5 rebuilds under modern 16TB+ drives?
