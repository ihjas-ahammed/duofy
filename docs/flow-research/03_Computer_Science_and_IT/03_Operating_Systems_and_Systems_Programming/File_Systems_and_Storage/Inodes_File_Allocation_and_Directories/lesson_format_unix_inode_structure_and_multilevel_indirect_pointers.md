# Duofy Reusable Lesson Format: UNIX Inode Structure and Multilevel Indirect Pointers

**Target Topic:** `03_Computer_Science_and_IT / 03_Operating_Systems_and_Systems_Programming / File_Systems_and_Storage / Inodes_File_Allocation_and_Directories`  
**Lesson Format Type:** `unix_inode_structure_and_multilevel_indirect_pointers`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the metadata layout, pointer tree hierarchy, and maximum addressable file size calculations of the classic UNIX Index Node (Inode) structure (Ken Thompson & Dennis Ritchie 1974; Marshall Kirk McKusick et al. Berkeley FFS 1984; Remzi Arpaci-Dusseau OSTEP Chapter 40; Abraham Silberschatz et al. Chapter 11): master the **Inode Metadata Fields** (file mode/permissions, owner UID/GID, size, timestamps `atime`/`mtime`/`ctime`, link count `nlink`, and data block pointers), enforce the **Fundamental File Invariant** (the inode **DOES NOT STORE THE FILENAME**; filenames exist solely inside directory tables), formulate the **15-Pointer Multilevel Indexing Tree** (**12 Direct Pointers**, **1 Single Indirect**, **1 Double Indirect**, **1 Triple Indirect**), and derive the mathematical closed-form formula for **Maximum File Size ($\mathbf{\text{Size}_{\text{max}} = [12 + K + K^2 + K^3] \times \text{BlockSize}}$ where $K = \text{BlockSize} / \text{PointerSize}$)**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | UNIX Inode Metadata Fields, Multilevel Pointer Tree, & Max File Size Formulas Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Data Block Lookup for a Double Indirect Offset Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Inode Pointer Level / Metadata Field & Storage Capacity Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Number of Direct Block Pointers Included in a Classic Unix Inode (12) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Calculation of Maximum Addressable File Size for a Given Inode Structure Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State UNIX Inode Architecture & Sizing (Thompson & Ritchie 1974; McKusick 1984; OSTEP 40):
   - **The Inode Metadata Fields (128 or 256 bytes fixed size):**
     - Mode / Type (Regular, Directory, Symlink, Block device),
     - Owner UID / GID,
     - File Size (in bytes),
     - Timestamps: `atime` (access), `mtime` (content modification), `ctime` (inode metadata change),
     - Reference Link Count `nlink` (number of hard links),
     - **15 Block Pointers.**
     - **RULE:** The Inode NEVER stores the file name!
   - **The 15-Pointer Multi-Level Tree Hierarchy:**
     - Let Block Size be $B$ (e.g. 4KB) and Disk Pointer Address Size be $P$ (e.g. 4 bytes).
     - Pointers per indirect block: $\mathbf{K = \frac{B}{P} = \frac{4096}{4} = 1024 = 2^{10}}$.
     - **12 Direct Pointers:** $12 \times B = 48\text{ KB}$ (instant $O(1)$ disk seek for small files).
     - **1 Single Indirect Pointer:** $1 \times K \times B = 1024 \times 4\text{ KB} = 4\text{ MB}$.
     - **1 Double Indirect Pointer:** $1 \times K^2 \times B = (1024)^2 \times 4\text{ KB} = 4\text{ GB}$.
     - **1 Triple Indirect Pointer:** $1 \times K^3 \times B = (1024)^3 \times 4\text{ KB} = \mathbf{4\text{ TB}}$.
   - **Total Maximum Addressable File Size:**
     $$\mathbf{\text{Size}_{\text{max}} = \left[ 12 + K + K^2 + K^3 \right] \times B \approx 4\text{ TB}}$$
2. **Slide 2 (`ordering`):** Provide 5 steps of the kernel resolving a logical file offset located in the Double Indirect region (e.g. byte offset 50MB): (1) divide byte offset by block size (4KB) to determine target logical block number L, (2) subtract direct blocks (12) and single indirect blocks (1024) to find double indirect relative index D = L - 1036, (3) read the double indirect pointer block from disk to retrieve the first-level pointer array, (4) index into first-level block at index floor(D / 1024) to retrieve the address of the second-level indirect block, (5) index into second-level block at index (D mod 1024) to fetch physical data block pointer and read file data!
3. **Slide 3 (`matching`):** Pair 4 Inode structures (12 Direct Pointers, 1 Single Indirect, 1 Double Indirect, 1 Triple Indirect) with their capacity metrics.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that a classic Unix inode contains 12 direct block pointers. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on calculating max file size with specific parameters: In a Unix file system with 2KB ($2048$ byte) disk blocks, 4-byte disk addresses, 10 direct block pointers, 1 single indirect pointer, 1 double indirect pointer, and 1 triple indirect pointer, what is the maximum addressable file size? (Each indirect block holds $K = 2048 / 4 = 512 = 2^9$ pointers; the maximum addressable capacity is **$(10 \times 2\text{ KB}) + (512 \times 2\text{ KB}) + (512^2 \times 2\text{ KB}) + (512^3 \times 2\text{ KB}) = 20\text{ KB} + 1\text{ MB} + 512\text{ MB} + 256\text{ GB} \approx 256.5\text{ GB}$**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "unix_inode_structure_and_multilevel_indirect_pointers",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The UNIX Inode & Multilevel Indexing (1974)**\n• **Inode Metadata Content (Fixed-Size Record):**\n  - Mode/Permissions, UID/GID, Size, Timestamps (`atime`/`mtime`/`ctime`), Link Count `nlink`.\n  - **CRITICAL INVARIANT:** Inodes **NEVER store the filename** (names reside in directories)!\n• **The 15-Pointer Tree Hierarchy ($B = 4\\text{ KB}, \\ P = 4\\text{ B} \\implies K = B/P = 1024$):**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Pointer Type} & \\textbf{Calculation} & \\textbf{Addressable Capacity} \\\\\n\\hline\n\\mathbf{12 \\text{ Direct}} & 12 \\times 4\\text{ KB} & 48\\text{ KB} \\quad (O(1) \\text{ instant seek}) \\\\\n\\mathbf{1 \\text{ Single Indirect}} & 1024 \\times 4\\text{ KB} & 4\\text{ MB} \\\\\n\\mathbf{1 \\text{ Double Indirect}} & 1024^2 \\times 4\\text{ KB} & 4\\text{ GB} \\\\\n\\mathbf{1 \\text{ Triple Indirect}} & 1024^3 \\times 4\\text{ KB} & \\mathbf{4\\text{ TB}} \\\\\n\\hline\n\\end{array}\n$$\n• **Maximum File Size Formula:** $\\mathbf{\\text{Size}_{\\text{max}} = [12 + K + K^2 + K^3] \\times B \\approx \\mathbf{4\\text{ TB}!}}$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of the OS kernel reading a data block located inside the Double Indirect pointer region of an Inode.",
      "orderItems": [
        "Divide the target byte offset by block size (4096) to calculate the logical block index L",
        "Subtract direct (12) and single indirect (1024) capacities to obtain double indirect relative offset D = L - 1036",
        "Fetch the Double Indirect pointer from the Inode and read the primary indirect index block from disk",
        "Index into the primary block at position floor(D / 1024) to retrieve the address of the secondary indirect block",
        "Read the secondary block from disk and index at position (D mod 1024) to fetch the final physical data block"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Inode pointer level (assuming 4KB blocks and 4-byte addresses) to its addressable capacity.",
      "matchPairs": [
        { "left": "12 Direct Block Pointers", "right": "48 KB addressable capacity providing instant single-seek access for small files" },
        { "left": "1 Single Indirect Pointer", "right": "4 MB addressable capacity via a single intermediate index block containing 1024 pointers" },
        { "left": "1 Double Indirect Pointer", "right": "4 GB addressable capacity via a two-level tree of 1024 x 1024 block pointers" },
        { "left": "1 Triple Indirect Pointer", "right": "4 TB addressable capacity via a three-level tree of 1024 x 1024 x 1024 block pointers" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "A classic Unix filesystem Inode contains exactly ___ direct block pointers for fast small-file access.",
      "blankAnswer": "12",
      "blankDistractors": ["10", "15", "8"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In a Unix file system with 2KB (2048 bytes) disk blocks, 4-byte disk block pointers, 10 direct pointers, 1 single indirect pointer, 1 double indirect pointer, and 1 triple indirect pointer, what is the maximum addressable file size?",
      "options": [
        { "text": "Each indirect block contains K = 2048 / 4 = 512 pointers; the maximum file size is (10 * 2KB) + (512 * 2KB) + (512^2 * 2KB) + (512^3 * 2KB) = 20 KB + 1 MB + 512 MB + 256 GB = 256.513 GB", "isCorrect": true, "explanation": "Correct! This is the standard mathematical calculation for inode addressability (Silberschatz Chapter 11; OSTEP Chapter 40). 1. Block Size $B = 2048\\text{ bytes} = 2\\text{ KB}$. 2. Pointer Address Size $P = 4\\text{ bytes}$. 3. Number of pointers stored per indirect block: $K = \\frac{B}{P} = \\frac{2048}{4} = 512 = 2^9\\text{ pointers}$. 4. Direct capacity: $10 \\times 2\\text{ KB} = 20\\text{ KB}$. 5. Single indirect capacity: $1 \\times 512 \\times 2\\text{ KB} = 1024\\text{ KB} = 1\\text{ MB}$. 6. Double indirect capacity: $1 \\times 512^2 \\times 2\\text{ KB} = 262,144 \\times 2\\text{ KB} = 524,288\\text{ KB} = 512\\text{ MB}$. 7. Triple indirect capacity: $1 \\times 512^3 \\times 2\\text{ KB} = 134,217,728 \\times 2\\text{ KB} = 268,435,456\\text{ KB} = 262,144\\text{ MB} = 256\\text{ GB}$. 8. Summing all tiers: $\\text{Total} = 20\\text{ KB} + 1\\text{ MB} + 512\\text{ MB} + 256\\text{ GB} = 256.513\\text{ GB}$ (approximately $256.5\\text{ GB}$)." },
        { "text": "The maximum file size is exactly 4 Terabytes", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The maximum file size is 2 Gigabytes", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The maximum file size is 10 Megabytes", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
