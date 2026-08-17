# Duofy Reusable Lesson Format: Multiple Granularity Locking and Intention Locks (IS, IX, SIX)

**Target Topic:** `03_Computer_Science_and_IT / 04_Database_Management_Systems / Transaction_Management_and_Concurrency_Control / Two_Phase_Locking_2PL_and_Timestamping`  
**Lesson Format Type:** `multiple_granularity_locking_intention_locks_is_ix_six`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through hierarchical resource locking, coarse-vs-fine locking trade-offs, and intention lock compatibility matrices in relational database storage engines (Jim Gray et al. 1975, *Granularity of Locks and Degrees of Consistency in a Shared Data Base*; Silberschatz et al. Chapter 18.3; Elmasri & Navathe Chapter 21.2): master the **Multiple Granularity Hierarchy Tree ($\mathbf{\text{Database} \to \text{Table/File} \to \text{Page} \to \text{Record/Row}}$)**, evaluate the 3 **Intention Lock Types** (**Intention Shared [IS]**, **Intention Exclusive [IX]**, and **Shared + Intention Exclusive [SIX]**), master the **Hierarchical Locking Protocol Rules** (locking root down with intention locks before acquiring child $S/X$ locks; releasing leaf up), and master the **$5 \times 5$ Lock Compatibility Matrix** to eliminate expensive subtree traversal checks.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Multiple Granularity Hierarchy, Intention Lock Concepts, & Compatibility Matrix Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Top-Down Lock Acquisition Path to Update a Single Row Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Lock Mode (IS, IX, S, SIX, X) & Operational Compatibility Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Name of the Hybrid Lock Mode That Grants Shared Read Access to an Entire Subtree While Permitting Explicit Exclusive Locks on Child Nodes (SIX) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Analysis of Why Intention Locks (IS, IX) Prevent Full Table Scan Overheads Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Multiple Granularity Locking (Gray 1975; Silberschatz 18.3):
   - **The Granularity Hierarchy Tree:**
     $$\mathbf{\text{Database}} \ \longrightarrow \ \mathbf{\text{Table}} \ \longrightarrow \ \mathbf{\text{Page}} \ \longrightarrow \ \mathbf{\text{Row (Tuple)}}$$
   - **The Intention Lock Modes:**
     - **IS (Intention Shared):** Indicates intent to acquire $S$-locks lower in the tree.
     - **IX (Intention Exclusive):** Indicates intent to acquire $X$-locks lower in the tree.
     - **SIX (Shared + Intention Exclusive):** Holds $S$-lock on current node and subtree, but intends to acquire $X$-locks on child descendants (e.g. read whole table and update 2 rows).
   - **The $5 \times 5$ Compatibility Matrix:**
     $$\begin{array}{|c|c|c|c|c|c|}
     \hline
     & \mathbf{\text{IS}} & \mathbf{\text{IX}} & \mathbf{\text{S}} & \mathbf{\text{SIX}} & \mathbf{\text{X}} \\
     \hline
     \mathbf{\text{IS}} & \mathbf{\text{YES}} & \mathbf{\text{YES}} & \mathbf{\text{YES}} & \mathbf{\text{YES}} & \text{NO} \\
     \mathbf{\text{IX}} & \mathbf{\text{YES}} & \mathbf{\text{YES}} & \text{NO}  & \text{NO}  & \text{NO} \\
     \mathbf{\text{S}}  & \mathbf{\text{YES}} & \text{NO}  & \mathbf{\text{YES}} & \text{NO}  & \text{NO} \\
     \mathbf{\text{SIX}} & \mathbf{\text{YES}} & \text{NO}  & \text{NO}  & \text{NO}  & \text{NO} \\
     \mathbf{\text{X}}  & \text{NO}  & \text{NO}  & \text{NO}  & \text{NO}  & \text{NO} \\
     \hline
     \end{array}$$
   - **Protocol Rule:** Acquire locks **Top-Down (Root $\to$ Leaf)**; release locks **Bottom-Up (Leaf $\to$ Root)**!
2. **Slide 2 (`ordering`):** Provide 5 steps of acquiring locks to update a single row in Table T: (1) acquire IX (Intention Exclusive) lock on Database root node, (2) traverse down and acquire IX lock on Table T node, (3) traverse down and acquire IX lock on Page P containing the target row, (4) acquire X (Exclusive) lock on the target Row R within Page P, (5) perform write update on Row R; upon transaction commit, release locks bottom-up (Row R -> Page P -> Table T -> Database)!
3. **Slide 3 (`matching`):** Pair 4 lock modes (IS, IX, SIX, X) with their compatibility and semantic roles.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of the SIX lock mode. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why Intention Locks prevent expensive tree traversals: Why did Jim Gray invent Intention Locks (IS, IX) in Multiple Granularity Locking rather than having transactions directly lock individual rows? (If a transaction $T_1$ modifies a single row by acquiring an Exclusive lock on that row without intention locks on ancestors, and another transaction $T_2$ later wants to lock the entire Table $T$ exclusively (e.g. for schema alteration `ALTER TABLE`), $T_2$ would have to **traverse and inspect every single page and row in the entire million-row table to check for existing locks**; with Intention Locks, $T_1$ places an `IX` lock on the Table node, allowing $T_2$ to **immediately detect the conflict at the table level in $O(1)$ time without scanning any child pages**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "multiple_granularity_locking_intention_locks_is_ix_six",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Multiple Granularity Locking (Gray 1975)**\n• **Hierarchical Resource Granularity Tree (Silberschatz Chapter 18.3):**\n$$\n\\mathbf{\\text{Database} \\ \\longrightarrow \\ \\text{Table} \\ \\longrightarrow \\ \\text{Page} \\ \\longrightarrow \\ \\text{Row (Tuple)}}\n$$\n• **Intention Lock Semantics:**\n  - **IS (Intention Shared):** Indicates intent to lock child descendants in Shared ($S$) mode.\n  - **IX (Intention Exclusive):** Indicates intent to lock child descendants in Exclusive ($X$) mode.\n  - **SIX (Shared + Intention Exclusive):** Holds $S$ lock on current subtree + $IX$ intent on child items.\n• **The Master $5 \\times 5$ Lock Compatibility Matrix:**\n$$\n\\begin{array}{|c|c|c|c|c|c|}\n\\hline\n& \\mathbf{\\text{IS}} & \\mathbf{\\text{IX}} & \\mathbf{\\text{S}} & \\mathbf{\\text{SIX}} & \\mathbf{\\text{X}} \\\\\n\\hline\n\\mathbf{\\text{IS}} & \\mathbf{\\text{Yes}} & \\mathbf{\\text{Yes}} & \\mathbf{\\text{Yes}} & \\mathbf{\\text{Yes}} & \\text{No} \\\\\n\\mathbf{\\text{IX}} & \\mathbf{\\text{Yes}} & \\mathbf{\\text{Yes}} & \\text{No} & \\text{No} & \\text{No} \\\\\n\\mathbf{\\text{S}} & \\mathbf{\\text{Yes}} & \\text{No} & \\mathbf{\\text{Yes}} & \\text{No} & \\text{No} \\\\\n\\mathbf{\\text{SIX}} & \\mathbf{\\text{Yes}} & \\text{No} & \\text{No} & \\text{No} & \\text{No} \\\\\n\\mathbf{\\text{X}} & \\text{No} & \\text{No} & \\text{No} & \\text{No} & \\text{No} \\\\\n\\hline\n\\end{array}\n$$\n• **Protocol Rule:** Acquire locks **Top-Down (Root $\\to$ Leaf)**; release locks **Bottom-Up**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of acquiring hierarchical locks under Multiple Granularity Locking to modify a single row.",
      "orderItems": [
        "Request and acquire an Intention Exclusive (IX) lock on the top-level Database root node",
        "Traverse down the hierarchy and acquire an Intention Exclusive (IX) lock on the target Table node",
        "Traverse down and acquire an Intention Exclusive (IX) lock on the specific Page containing the target record",
        "Acquire a fine-grained Exclusive (X) lock on the specific target Row (Tuple) to perform the data update",
        "Upon transaction commit, release locks in reverse order: Row -> Page -> Table -> Database (Bottom-Up)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Multiple Granularity Lock Mode to its exact operational definition.",
      "matchPairs": [
        { "left": "IS (Intention Shared)", "right": "Signals intent to acquire shared read locks on descendant nodes lower in the resource tree" },
        { "left": "IX (Intention Exclusive)", "right": "Signals intent to acquire exclusive write locks on descendant nodes lower in the resource tree" },
        { "left": "SIX (Shared + Intention Exclusive)", "right": "Grants shared read access to the entire subtree while permitting exclusive writes to specific child nodes" },
        { "left": "X (Exclusive Lock)", "right": "Provides exclusive access to the target node and all its descendants, conflicting with all other lock modes" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The hybrid lock mode that locks an entire table in Shared mode while holding Intention Exclusive locks for child rows is ___.",
      "blankAnswer": "SIX",
      "blankDistractors": ["IS", "IX", "SHARED"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why was the Intention Lock protocol (IS, IX, SIX) invented by Jim Gray rather than having transactions simply acquire locks directly on individual rows or pages?",
      "options": [
        { "text": "If a transaction T1 modifies a single row by acquiring an Exclusive (X) lock on that row without placing intention locks on parent nodes, and another transaction T2 later attempts to acquire a coarse-grained Exclusive (X) lock on the entire Table (e.g. for ALTER TABLE or a full table dump), T2 would have to recursively traverse and inspect every single page and row in the entire 100-million-row table to verify whether any fine-grained locks exist; with Intention Locks, T1 places an IX lock on the Table node, allowing T2 to immediately detect the conflict at the table level in O(1) time without scanning any child pages", "isCorrect": true, "explanation": "Correct! This is the classic justification for Multiple Granularity Locking (Jim Gray et al. 1975; Silberschatz Section 18.3; Elmasri & Navathe Section 21.2). 1. **The Traversal Problem without Intention Locks:** - Suppose Table `Orders` has 50 million rows. - Transaction $T_1$ updates row #42,100,500 by placing an $X$ lock directly on that row. - A database administrator executes `ALTER TABLE Orders ADD COLUMN notes VARCHAR(100);` via Transaction $T_2$, which requires an $X$ lock on the ENTIRE `Orders` table. - How can the database engine know if it is safe to give $T_2$ the table lock? - Without intention locks, the engine would have to scan ALL 50 MILLION ROWS to see if any row has an active $X$ lock! This would cause massive I/O and take minutes. 2. **The Intention Lock Solution:** - Before $T_1$ locks row #42,100,500, $T_1$ MUST acquire an `IX` (Intention Exclusive) lock on the `Orders` table. - When $T_2$ requests an `X` lock on the `Orders` table, the engine checks the table's lock list. - The engine sees `IX` held by $T_1$. - Looking up the compatibility matrix: `X` and `IX` conflict! - $T_2$ is immediately blocked in **$O(1)$ constant time** without inspecting a single child page or row!" },
        { "text": "Because B-Trees cannot support row-level locks without intention locks", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because SQL standards forbid having more than 5 columns in a table", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because intention locks automatically eliminate all CPU cache misses", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
