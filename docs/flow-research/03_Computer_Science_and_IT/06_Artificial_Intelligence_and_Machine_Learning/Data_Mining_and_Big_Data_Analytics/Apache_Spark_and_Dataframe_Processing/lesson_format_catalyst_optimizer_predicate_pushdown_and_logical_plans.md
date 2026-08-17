# Duofy Reusable Lesson Format: Catalyst Optimizer (Predicate Pushdown and Logical Plans)

**Target Topic:** `03_Computer_Science_and_IT / 06_Artificial_Intelligence_and_Machine_Learning / Data_Mining_and_Big_Data_Analytics / Apache_Spark_and_Dataframe_Processing`  
**Lesson Format Type:** `catalyst_optimizer_predicate_pushdown_and_logical_plans`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the relational query tree optimizations, tree transformation rules, and physical cost modeling of Spark SQL's Catalyst Optimizer (Michael Armbrust et al. 2015, *Spark SQL: Relational Data Processing in Spark*, SIGMOD; Chambers & Zaharia *Spark: The Definitive Guide* Chapter 3): trace the **4 Stages of the Catalyst Optimization Pipeline** (**Stage 1: Analysis** [resolving unresolved logical plan attributes against the Catalog]; **Stage 2: Logical Plan Optimization** [applying deterministic rewrite rules]; **Stage 3: Physical Planning** [generating multiple candidate physical plans and selecting the optimal one using the Cost-Based Optimizer CBO]; **Stage 4: Code Generation**), master core algebraic optimization techniques (**Predicate Pushdown** [pushing `WHERE` filter clauses directly into the Parquet/ORC storage layer to skip entire file row-groups], **Projection Pruning** [reading only referenced columns to minimize memory bandwidth], and **Constant Folding**), and analyze query execution using `df.explain(extended=True)`.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Catalyst 4-Stage Pipeline Flow, Tree Transformation Rule, Predicate Pushdown Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Query Compilation Through Catalyst from Unresolved Plan to Physical Code Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Catalyst Optimization Rule / Plan Stage & Mathematical Tree Transformation Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Optimization Technique Pushing Filter Conditions Down to the Storage Layer Is Predicate ___ (Pushdown) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Analysis of How Predicate Pushdown and Projection Pruning Drastically Cut I/O Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Catalyst Optimizer (Armbrust et al. 2015; Chambers & Zaharia Ch 3):
   - **The 4 Catalyst Compilation Stages:**
     $$\mathbf{\text{Unresolved Logical Plan} \xrightarrow{\text{Analysis (Catalog)}} \text{Analyzed Plan} \xrightarrow{\text{Logical Optimization}} \mathbf{\text{Optimized Logical Plan}} \xrightarrow{\text{Physical Planning}} \text{Physical Plan} \xrightarrow{\text{Codegen}} \mathbf{\text{Java Bytecode}}}$$
   - **Core Tree Transformation Rules:**
     - **Predicate Pushdown:** Moves `Filter(age > 21)` below `Join` and directly into `FileScan(parquet)`.
     - **Projection Pruning:** `Project(name)` eliminates reading 50 unreferenced columns.
     - **Constant Folding:** Replaces `1 + 1` with constant literal `2`.
   - **The I/O Reduction Invariant:** Reads **$0\text{ bytes}$** of filtered Parquet row-groups using columnar metadata!
2. **Slide 2 (`ordering`):** Provide 5 steps of Catalyst query compilation: (1) parse SQL or DataFrame API expression into an Unresolved Logical Plan tree of abstract syntax nodes, (2) resolve table and column names against the Metastore Catalog to produce an Analyzed Logical Plan, (3) apply pattern-matching rule transformations (predicate pushdown, projection pruning) to yield an Optimized Logical Plan, (4) generate multiple candidate Physical Plans and evaluate cost via Cost-Based Optimizer (CBO), (5) select winning physical plan and generate high-performance Java bytecode via Whole-Stage Code Generation!
3. **Slide 3 (`matching`):** Pair 4 concepts (Unresolved Logical Plan, Predicate Pushdown, Projection Pruning, Cost-Based Optimizer CBO) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Predicate Pushdown. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on how Predicate Pushdown and Projection Pruning optimize queries: When executing a Spark SQL query `SELECT name FROM users WHERE country = 'CA'` against a 10TB Parquet dataset containing 50 columns, how do Predicate Pushdown and Projection Pruning combine to reduce I/O and processing time by over 95%? (Instead of loading all 10TB across the network into memory and filtering rows in Spark JVM, **Projection Pruning instructs the columnar storage reader to scan only the two columns (`name`, `country`), ignoring the remaining 48 columns (a 96% reduction in data volume)**; simultaneously, **Predicate Pushdown passes the condition `country = 'CA'` directly to the Parquet file footer metadata readers (dictionary filtering and min/max statistics), skipping entire row-groups and data blocks that contain no Canadian records without even reading them from disk**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "catalyst_optimizer_predicate_pushdown_and_logical_plans",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Spark SQL Catalyst Optimizer (Armbrust et al. SIGMOD 2015)**\n• **The 4-Phase Tree Compilation Pipeline (Chambers *Spark Guide* Chapter 3):**\n$$\n\\mathbf{\\text{SQL / DataFrame} \\xrightarrow{\\text{Parse}} \\text{Unresolved Plan} \\xrightarrow{\\text{Analysis}} \\text{Analyzed Plan} \\xrightarrow{\\mathbf{\\text{Logical Optimization}}} \\mathbf{\\text{Optimized Plan}} \\xrightarrow{\\text{Physical Planning}} \\mathbf{\\text{Java Bytecode}}}\n$$\n• **The Core Optimization Rewrite Rules:**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Catalyst Rule} & \\textbf{Tree Transformation Action} & \\textbf{Performance Impact} \\\\\n\\hline\n\\mathbf{\\text{Predicate Pushdown}} & \\text{Pushes } \\texttt{WHERE} \\text{ filters down to storage layer} & \\mathbf{\\text{Skips unneeded Parquet row-groups at disk level!}} \\\\\n\\mathbf{\\text{Projection Pruning}} & \\text{Discards unused columns from table scans} & \\text{Drastically slashes memory \\& network bandwidth} \\\\\n\\mathbf{\\text{Constant Folding}} & \\text{Replaces static expressions (e.g. } 1000 \\times 60 \\to 60000) & \\text{Eliminates runtime CPU calculation cycles} \\\\\n\\hline\n\\end{array}\n$$\n• **The Explain Invariant:** Inspect complete plan transformations using $\\mathbf{\\texttt{df.explain(extended=True)}}$!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential compilation phases executed by the Catalyst Optimizer when evaluating a Spark DataFrame query.",
      "orderItems": [
        "Parse the user's DataFrame code or SQL query string into an Unresolved Logical Plan containing unbound relation trees",
        "Consult the Metastore Catalog to verify table existence and resolve column types, producing an Analyzed Logical Plan",
        "Apply deterministic pattern-matching rewrite rules (Predicate Pushdown, Projection Pruning) to construct the Optimized Logical Plan",
        "Generate multiple candidate Physical Plans and evaluate table statistics using the Cost-Based Optimizer (CBO) to select the optimal plan",
        "Compile the winning physical plan into highly optimized JVM Java bytecode using Whole-Stage Code Generation"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Catalyst Optimizer Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Predicate Pushdown", "right": "Pushes filter predicates directly into file format readers (Parquet/ORC) to skip row-groups via metadata statistics" },
        { "left": "Projection Pruning", "right": "Restricts columnar data loading to only the specific attributes referenced in the downstream query" },
        { "left": "Unresolved Logical Plan", "right": "Initial abstract syntax tree representation where column data types and table references are not yet verified" },
        { "left": "Cost-Based Optimizer (CBO)", "right": "Uses collected table statistics (cardinality, histograms) to choose between join algorithms and join orders" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The Catalyst optimization rule that pushes filter conditions down to the storage scan layer is Predicate ___.",
      "blankAnswer": "Pushdown",
      "blankDistractors": ["Pruning", "Folding", "Broadcast"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "When executing a Spark query (SELECT name FROM users WHERE country = 'CA') against a 10TB Parquet dataset with 50 columns, how do Predicate Pushdown and Projection Pruning combine to reduce I/O and runtime by over 95%?",
      "options": [
        { "text": "Projection Pruning instructs the Parquet columnar reader to scan only the two relevant columns ('name' and 'country'), completely ignoring the remaining 48 columns (a 96% reduction in raw data volume); simultaneously, Predicate Pushdown passes the filter country = 'CA' directly into the Parquet file readers, allowing Spark to inspect file footer metadata (min/max column statistics) and skip entire row-groups that contain no Canadian records without ever reading them from disk", "isCorrect": true, "explanation": "Correct! This is Michael Armbrust et al.'s classic demonstration of Catalyst query optimization (Armbrust et al. SIGMOD 2015 *Spark SQL: Relational Data Processing in Spark*; Chambers & Zaharia *Spark Guide* Chapter 3). 1. **The Unoptimized Disaster:** - If you wrote raw RDD code: You would load the entire $10\\text{ TB}$ file into RAM, deserialize all 50 columns into Python/Java objects, and run `filter(lambda row: row['country'] == 'CA')`. - Network bandwidth, disk I/O, and CPU garbage collection would take **hours**! 2. **Projection Pruning in Parquet:** - Parquet is a **columnar storage format** (each column is stored in separate contiguous disk blocks). - Because the query needs only `name` and `country`, Spark reads ONLY those 2 column blocks! - Data read drops immediately from $10\\text{ TB}$ to $\\mathbf{400\\text{ GB}}$ ($96\\%$ data reduction). 3. **Predicate Pushdown in Parquet:** - Every Parquet file contains row-groups of $\\approx 1,000,000\\text{ rows}$ with footer metadata: `[country: min='US', max='US']`. - Predicate Pushdown pushes `country == 'CA'` to the reader before reading data. - The reader reads the $1\\text{ KB}$ footer, sees `min='US', max='US'`, and **SKIPS THE ENTIRE 100MB ROW-GROUP WITHOUT READING IT**! - Actual data transferred to RAM drops from $400\\text{ GB}$ down to only $\\mathbf{15\\text{ GB}}$, completing the query in seconds!" },
        { "text": "Because Catalyst deletes the other 48 columns permanently from the hard drive", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Predicate Pushdown requires converting Parquet files into CSV files", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Spark executes the query on quantum hardware", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
