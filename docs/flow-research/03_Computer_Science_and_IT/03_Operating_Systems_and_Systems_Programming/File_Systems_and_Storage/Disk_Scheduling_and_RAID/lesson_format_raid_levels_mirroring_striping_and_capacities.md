# Duofy Reusable Lesson Format: RAID Levels (Mirroring, Striping, and Capacities)

**Target Topic:** `03_Computer_Science_and_IT / 03_Operating_Systems_and_Systems_Programming / File_Systems_and_Storage / Disk_Scheduling_and_RAID`  
**Lesson Format Type:** `raid_levels_mirroring_striping_and_capacities`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the storage virtualization, block-level striping, data mirroring, and usable capacity calculations of the standard RAID architecture levels (David A. Patterson, Garth Gibson, & Randy H. Katz 1987, *A Case for Redundant Arrays of Inexpensive Disks (RAID)*; Abraham Silberschatz et al. *Operating System Concepts* Chapter 10.7; Remzi Arpaci-Dusseau OSTEP Chapter 38): master **RAID 0 (Block-Level Striping: $N \cdot C$ capacity, 0 fault tolerance, maximum throughput)**, **RAID 1 (100% Data Mirroring: $\frac{N}{2} \cdot C$ capacity, 1 disk per mirror pair fault tolerance, fast reads)**, **RAID 5 (Block Striping with Distributed Parity: $(N - 1) \cdot C$ capacity, 1 disk failure tolerance)**, **RAID 6 (Dual Distributed Parity: $(N - 2) \cdot C$ capacity, 2 disk failures tolerance)**, and **RAID 10 (Striped Mirrors / RAID 1+0: $\frac{N}{2} \cdot C$ capacity, high IOPS and fast rebuilds)**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | RAID Taxonomy, Usable Storage Capacity Formulas, & Fault Tolerance Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Data Block Striping and Parity Distribution Sequence Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | RAID Level & Usable Capacity / Fault Tolerance Specification Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Usable Capacity Formula for a RAID 5 Array of N Disks of Size C ((N - 1) * C) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Architectural Comparison Between Nested RAID 10 (1+0) and RAID 01 (0+1) Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State RAID Levels & Storage Formulas (Patterson, Gibson, & Katz 1987; Silberschatz Chapter 10.7; OSTEP 38):
   - **RAID Master Comparison Table ($N$ disks, each of capacity $C$):**
     $$\begin{array}{|l|l|l|l|l|}
     \hline
     \textbf{RAID Level} & \textbf{Core Technique} & \textbf{Usable Capacity} & \textbf{Fault Tolerance} & \textbf{Storage Efficiency} \\
     \hline
     \mathbf{\text{RAID 0}} & \text{Block Striping} & \mathbf{N \cdot C} & \mathbf{0 \text{ Disks (No redundancy)}} & 100\% \\
     \mathbf{\text{RAID 1}} & \text{Mirroring (Duplication)} & \mathbf{\frac{N}{2} \cdot C} & \frac{N}{2} \text{ Disks (1 per pair)} & 50\% \\
     \mathbf{\text{RAID 5}} & \text{Distributed Parity} & \mathbf{(N - 1) \cdot C} & \mathbf{1 \text{ Disk Failure}} & \frac{N-1}{N} \\
     \mathbf{\text{RAID 6}} & \text{Dual Parity (P+Q)} & \mathbf{(N - 2) \cdot C} & \mathbf{2 \text{ Disk Failures}} & \frac{N-2}{N} \\
     \mathbf{\text{RAID 10}} & \text{Stripe of Mirrors (1+0)} & \mathbf{\frac{N}{2} \cdot C} & \ge 1 \text{ Disk (up to } N/2\text{)} & 50\% \\
     \hline
     \end{array}$$
   - **Why Striping Improves Performance:** Spreads read/write operations across $N$ independent disk arms in parallel ($N\times$ bandwidth!).
2. **Slide 2 (`ordering`):** Provide 5 steps of writing data block stream D0, D1, D2, D3 into a 4-disk RAID 5 array: (1) partition incoming file stream into fixed-size logical data blocks (D0, D1, D2, D3), (2) on Stripe 0, write data block D0 to Disk 0, D1 to Disk 1, D2 to Disk 2, (3) compute parity block P0 = D0 xor D1 xor D2 and write P0 to Disk 3, (4) advance to Stripe 1, rotating the parity position leftward so that Disk 2 holds parity block P1, (5) write remaining data blocks D3, D4, D5 across Disks 0, 1, and 3, distributing parity uniformly across all drives!
3. **Slide 3 (`matching`):** Pair 4 RAID levels (RAID 0 Striping, RAID 1 Mirroring, RAID 5 Distributed Parity, RAID 6 Dual Parity) with their capacity and fault tolerance formulas.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the usable capacity of a RAID 5 array with N disks of size C is (N - 1) * C. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why RAID 10 (Stripe of Mirrors) is vastly superior in reliability compared to RAID 01 (Mirror of Stripes): Why is RAID 10 (RAID 1+0) universally preferred over RAID 01 (RAID 0+1) in enterprise storage systems even though both use the same number of disks and provide 50% usable capacity? (In RAID 01, if a single disk fails, its entire stripe of $N/2$ disks is completely disabled, leaving the array as an **unprotected single stripe where ANY second disk failure anywhere destroys the entire array**; in RAID 10, each mirror pair operates independently, so after a single disk failure, **the array can survive ANY subsequent disk failure as long as it does not hit the single paired mirror of the failed disk**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "raid_levels_mirroring_striping_and_capacities",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: RAID Architecture & Storage Formulas (1987)**\n• **Master RAID Specifications ($N$ disks, capacity $C$ each):**\n$$\n\\begin{array}{|l|l|l|l|}\n\\hline\n\\textbf{Level} & \\textbf{Usable Capacity} & \\textbf{Fault Tolerance} & \\textbf{Primary Feature} \\\\\n\\hline\n\\mathbf{\\text{RAID 0}} & N \\cdot C & \\mathbf{0 \\text{ Disks (Zero safety)}} & \\text{Max throughput striping} \\\\\n\\mathbf{\\text{RAID 1}} & \\frac{N}{2} \\cdot C & 1 \\text{ disk per pair} & \\text{Full mirroring duplication} \\\\\n\\mathbf{\\text{RAID 5}} & \\mathbf{(N - 1) \\cdot C} & \\mathbf{1 \\text{ Disk Failure}} & \\text{Single distributed parity} \\\\\n\\mathbf{\\text{RAID 6}} & \\mathbf{(N - 2) \\cdot C} & \\mathbf{2 \\text{ Disk Failures}} & \\text{Dual parity (P+Q)} \\\\\n\\mathbf{\\text{RAID 10}} & \\frac{N}{2} \\cdot C & \\ge 1 \\text{ (up to } N/2\\text{)} & \\text{Stripe of mirrors (1+0)} \\\\\n\\hline\n\\end{array}\n$$\n• **Storage Efficiency:** RAID 5 achieves $\\frac{N-1}{N} \\approx 80\\text{--}90\\%$ usable storage vs RAID 1's strict $50\\%$!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of writing a data stream across a 4-disk RAID 5 storage array with rotating distributed parity.",
      "orderItems": [
        "Partition the incoming file data stream into fixed-size logical block chunks (D0, D1, D2, D3...)",
        "On Stripe 0, assign data blocks D0, D1, D2 across Disk 0, Disk 1, and Disk 2 respectively",
        "Compute parity block P0 = D0 xor D1 xor D2 and write P0 to the designated parity drive for Stripe 0 (Disk 3)",
        "On Stripe 1, rotate the parity position leftward, writing parity block P1 to Disk 2",
        "Write subsequent data blocks D3, D4, D5 across the remaining active drives (Disk 0, Disk 1, Disk 3)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each RAID level to its exact usable capacity and fault tolerance profile.",
      "matchPairs": [
        { "left": "RAID 0 (Striping)", "right": "Capacity: N * C | Fault Tolerance: 0 Disks (Any drive failure causes total catastrophic data loss)" },
        { "left": "RAID 1 (Mirroring)", "right": "Capacity: (N / 2) * C | Fault Tolerance: 1 Disk per mirror pair (100% data replication overhead)" },
        { "left": "RAID 5 (Distributed Parity)", "right": "Capacity: (N - 1) * C | Fault Tolerance: 1 Disk failure tolerated across the entire array" },
        { "left": "RAID 6 (Dual Parity)", "right": "Capacity: (N - 2) * C | Fault Tolerance: 2 Simultaneous disk failures tolerated via P+Q parity" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In a RAID 5 array of N disks each of capacity C, the usable storage capacity is equal to N minus ___ times C.",
      "blankAnswer": "1",
      "blankDistractors": ["2", "0", "N/2"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is RAID 10 (RAID 1+0: a Stripe of Mirrors) universally preferred over RAID 01 (RAID 0+1: a Mirror of Stripes) in enterprise database infrastructure?",
      "options": [
        { "text": "In RAID 01, if a single disk fails, its entire stripe of N/2 disks becomes completely inaccessible, leaving the system running on a single vulnerable stripe where ANY second disk failure destroys the entire array; in RAID 10, disks are mirrored in independent pairs first, so after one disk fails, the array can survive any subsequent disk failure as long as it does not hit the specific mirrored partner of the failed drive", "isCorrect": true, "explanation": "Correct! This is a classic storage engineering question (Silberschatz Section 10.7; OSTEP Chapter 38). Consider an array of 6 disks ($D_0, D_1, D_2, D_3, D_4, D_5$): 1. In RAID 01 (Mirror of Stripes): We create two 3-disk RAID 0 stripes ($S_A = [D_0, D_1, D_2]$ and $S_B = [D_3, D_4, D_5]$) and mirror them. If disk $D_0$ fails, the entire stripe $S_A$ is dead! The storage array now relies solely on stripe $S_B$. If ANY single disk in $S_B$ ($D_3$, $D_4$, or $D_5$) suffers an error during rebuild, the entire array is destroyed (3 out of 5 remaining disks are lethal single points of failure). 2. In RAID 10 (Stripe of Mirrors): We create three 2-disk mirrors ($M_1 = [D_0, D_1]$, $M_2 = [D_2, D_3]$, $M_3 = [D_4, D_5]$) and stripe across them. If disk $D_0$ fails, ONLY mirror $M_1$ is degraded. If a second disk fails in $M_2$ or $M_3$ (e.g. $D_3$ or $D_5$), the array continues operating normally! The ONLY lethal disk is $D_1$ (1 out of 5 remaining disks). Thus, RAID 10 provides vastly higher reliability and significantly faster rebuild times." },
        { "text": "Because RAID 10 provides 90% usable capacity while RAID 01 provides only 10%", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because RAID 01 requires optical laser disks to operate", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because RAID 10 does not require RAID controller hardware", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
