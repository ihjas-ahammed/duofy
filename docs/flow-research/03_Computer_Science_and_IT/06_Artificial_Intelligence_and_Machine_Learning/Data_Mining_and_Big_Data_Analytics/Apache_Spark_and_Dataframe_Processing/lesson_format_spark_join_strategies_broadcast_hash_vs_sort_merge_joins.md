# Duofy Reusable Lesson Format: Spark Join Strategies (Broadcast Hash vs Sort-Merge Joins)

**Target Topic:** `03_Computer_Science_and_IT / 06_Artificial_Intelligence_and_Machine_Learning / Data_Mining_and_Big_Data_Analytics / Apache_Spark_and_Dataframe_Processing`  
**Lesson Format Type:** `spark_join_strategies_broadcast_hash_vs_sort_merge_joins`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify distributed join selection, network shuffle elimination, and skew handling in Apache Spark (Michael Armbrust et al. 2015; Bill Chambers & Matei Zaharia *Spark: The Definitive Guide* Chapter 8): analyze the performance hierarchy of distributed join strategies, master the **Broadcast Hash Join (BHJ / Map-Side Join)** (when one table is small [$<10\text{MB}$ by default or forced via `broadcast(df)` hint], Spark copies the entire small dataset to all worker nodes in $\mathcal{O}(M)$ time, joining local large table partitions in RAM with **$100\%$ zero network shuffle on the large table**), contrast BHJ with the **Shuffle Sort-Merge Join (SMJ)** (used for massive-to-massive table joins, where both tables are shuffled on the join key, sorted by key in each partition, and merged via dual pointer scans in $\mathcal{O}(M \log M + N \log N)$), analyze the **Shuffle Hash Join**, evaluate strategies for handling severe **Data Skew** (Salted Keys / Adaptive Query Execution AQE Skew Join optimization), and interact with live Spark RDD Lineage DAG visualizer, Broadcast Hash Join network simulator, and Catalyst Query Tree optimizer widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Broadcast Hash Join vs Sort-Merge Join Architecture Diagram, Complexity Table Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Spark Join Strategy / Optimization Technique & Technical Trade-Off Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 3** | Why Broadcast Hash Join Outperforms Sort-Merge Join on Large-to-Small Table Joins Quiz | `quiz` | Recognition (Phase B) | `content`, `options` (4 options, 1 correct) |
| **Slide 4** | The Function Hint Used to Explicitly Instruct Spark to Execute a Broadcast Hash Join Is ___ (broadcast) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Apache Spark Studio: RDD Lineage DAG, Broadcast Join & Catalyst Optimizer Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "spark_join_strategies_broadcast_hash_vs_sort_merge_joins",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "What is the difference between Broadcast Hash Join and Sort-Merge Join, and when should you use broadcast(df)?",
      "blankAnswer": "Spark Join Strategies (Chambers & Zaharia *Spark Guide* Ch 8): (1) BROADCAST HASH JOIN (BHJ): When joining a large table (e.g. 1TB) with a small dimension table (e.g. 5MB). The Driver collects the small table and broadcasts it to ALL executor nodes. Each executor builds an in-memory hash table of the small dataset and scans its local partition of the large table. Network shuffle on the large table is ZERO (O(M) linear time!). (2) SORT-MERGE JOIN (SMJ): When BOTH tables are massive (e.g. 500GB + 2TB). Both datasets are shuffled across the network on the join key (Wide Dependency), sorted by key within each partition, and joined via linear merge scan (O(M log M + N log N)). (3) BROADCAST THRESHOLD: Configured via spark.sql.autoBroadcastJoinThreshold (default 10MB). If table size is unknown to Catalyst, use explicit hint: large_df.join(broadcast(small_df), 'key')."
    },
    {
      "slideIndex": 2,
      "type": "matching",
      "content": "Match each Spark Join Strategy to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Broadcast Hash Join (BHJ)", "right": "Replicates small table across all executors to execute local in-memory hash joins with zero large table shuffle" },
        { "left": "Sort-Merge Join (SMJ)", "right": "Shuffles both datasets across cluster by join key, sorts each partition, and merges sorted streams" },
        { "left": "Broadcast Hint: broadcast(df)", "right": "Explicit programmatic directive overriding Catalyst table statistics to force a Broadcast Hash Join" },
        { "left": "Key Salting for Skewed Joins", "right": "Appends random integer suffixes (0..K) to skewed join keys to evenly distribute hot keys across partitions" }
      ]
    },
    {
      "slideIndex": 3,
      "type": "quiz",
      "content": "Why does a Broadcast Hash Join (BHJ) execute orders of magnitude faster than a Sort-Merge Join (SMJ) when joining a 1 Terabyte fact table with a 5 Megabyte dimension lookup table?",
      "options": [
        { "text": "In a Sort-Merge Join, Spark must shuffle all 1TB of data across network switches to partition both tables by the join key, write intermediate shuffle files to disk, and execute expensive external sorting on every worker node; in a Broadcast Hash Join, the 5MB table is broadcast once to all executors, allowing each worker node to build a tiny in-memory hash table and join its local slice of the 1TB table in linear time with 100% zero network data transfer and zero disk sorting for the 1TB dataset", "isCorrect": true, "explanation": "Correct! This is one of the most powerful optimization patterns in Apache Spark and distributed database systems (Chambers & Zaharia *Spark: The Definitive Guide* Chapter 8.3; Armbrust et al. SIGMOD 2015). 1. **The Cost of Sort-Merge Join on 1TB + 5MB:** - Step 1: Shuffle $1,000,000\\text{ MB}$ of data across the network switches. - Step 2: Write $1\\text{ TB}$ to local executor disks. - Step 3: Sort $1\\text{ TB}$ of records on disk ($\mathcal{O}(N \\log N)$ CPU operations). - Step 4: Merge scan and output results. Total time: **15 to 30 minutes**! 2. **The Broadcast Hash Join (BHJ) Miracle:** - The Driver broadcasts the $5\\text{ MB}$ lookup table to all $50\\text{ worker nodes}$ (a total network transfer of only $250\\text{ MB}$!). - Each worker loads the $5\\text{ MB}$ table into a fast `java.util.HashMap` in RAM. - As the worker reads its local $20\\text{ GB}$ slice of the 1TB table from HDFS/S3, it looks up each key in the local hash table: `val result = hashMap.get(row.key)`. - Time complexity: **Pure $\mathcal{O}(M)$ linear scan**! 3. **The Result:** Zero shuffle of the 1TB table, zero disk sorting, and the entire job finishes in **30 seconds** instead of 30 minutes!" },
        { "text": "Because Broadcast Hash Joins only work on single-character strings", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Sort-Merge Joins can only be executed in Python while Broadcast Joins run in C++", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Broadcast joins delete all rows that contain missing values", "isCorrect": false, "explanation": "Incorrect." }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "To explicitly instruct the Catalyst optimizer to broadcast a small DataFrame, apply the ___() function hint.",
      "blankAnswer": "broadcast",
      "blankDistractors": ["repartition", "coalesce", "cache"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Apache Spark Studio: RDD Lineage & Join Engine",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Apache Spark Studio</h3><p>Query: <b style=\"color:#38bdf8;\">Transactions (1TB) JOIN Categories (5MB)</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnCat\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Catalyst Predicate Pushdown</button><button id=\"btnBhj\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Broadcast Hash Join (BHJ)</button><button id=\"btnTungsten\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. Tungsten Whole-Stage CodeGen</button></div><div id=\"spkLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to inspect Catalyst optimization plan...</div><script>document.getElementById('btnCat').onclick=()=>{document.getElementById('spkLog').innerHTML='<b>1. CATALYST OPTIMIZER ANALYSIS:</b><br>• Predicate Pushdown: WHERE tx_year=2026 &rarr; Pushed to Parquet!<br>• Projection Pruning: Selected 3 of 40 columns (92% I/O saved)<br>• CBO selected BroadcastHashJoin (5MB < 10MB threshold)';}; document.getElementById('btnBhj').onclick=()=>{document.getElementById('spkLog').innerHTML='<b>2. BROADCAST HASH JOIN EXECUTION:</b><br>• Driver broadcasted 5MB Categories table to all 20 Executors<br>• Built in-memory UnsafeHashedRelation in RAM<br>🚀 <b style=\"color:#10b981;\">1TB Transactions table joined locally with ZERO network shuffle!</b>';}; document.getElementById('btnTungsten').onclick=()=>{document.getElementById('spkLog').innerHTML='<b>3. TUNGSTEN WHOLE-STAGE CODEGEN:</b><br>• Janino compiled Scan &rarr; Filter &rarr; Join into 1 flat loop<br>• Off-heap UnsafeRow format used (0 GC pauses!)<br>• Execution speed: <b style=\"color:#10b981;\">18.4 Million rows/sec in L1 cache</b><br>🎉 <b style=\"color:#10b981;\">Job completed in 14.2 seconds!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
