# Duofy Reusable Lesson Format: Load Balancing Algorithms (Round Robin, Least Connections, and Consistent Hashing)

**Target Topic:** `03_Computer_Science_and_IT / 07_Software_Engineering_and_Architecture / System_Design_and_Distributed_Systems / Load_Balancers_and_Reverse_Proxies`  
**Lesson Format Type:** `load_balancing_algorithms_round_robin_least_connections_and_consistent_hashing`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through scheduling mathematical properties, connection-aware load distribution, and distributed key partitioning algorithms in Load Balancers (David Karger et al. 1997, *Consistent Hashing and Random Trees: Distributed Caching Protocols for Relieving Hot Spots on the World Wide Web*; Alex Xu *System Design Interview* Volume 1 Chapter 5; Martin Kleppmann *Designing Data-Intensive Applications*): master **Round Robin & Weighted Round Robin** (sequential cycling weighted by server capacity; optimal for stateless, uniform requests), master **Least Connections & Weighted Least Connections** (directing new requests to the backend with the fewest active TCP sockets; optimal for long-lived WebSockets or long-running database queries), analyze why naive modulo hashing ($\mathbf{\text{Server} = \text{hash}(\text{key}) \pmod N}$) causes catastrophic $100\%$ cache stampedes when a node fails, master **Consistent Hashing Rings ($[0, 2^{32}-1]$)** with **Virtual Nodes (vnodes)** (ensuring only $\mathbf{\frac{K}{N}}$ keys are remapped when a node is added/removed while guaranteeing uniform key distribution across asymmetric servers), and evaluate Peak EWMA latency routing.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Scheduling Algorithms Matrix, Consistent Hashing Circular Ring Diagram $[0, 2^{32}-1]$ Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Lookup and Node Eviction Flow on a Consistent Hashing Ring Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Load Balancing Algorithm / Hashing Construct & Operational Characteristic Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In Consistent Hashing, Replicas Placed Along the Ring to Prevent Non-Uniform Key Hotspots Are ___ Nodes (Virtual) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Mathematical Analysis: Why Naive Modulo Hashing Fails Compared to Consistent Hashing Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Load Balancing Algorithms (Karger 1997; Alex Xu Ch 5):
   - **The Scheduling Algorithm Comparison:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Algorithm} & \textbf{Selection Mathematical Formula} & \textbf{Optimal Production Use Case} \\
     \hline
     \mathbf{\text{Round Robin}} & i = (i + 1) \pmod N & \text{Stateless short HTTP requests (homogeneous servers)} \\
     \mathbf{\text{Weighted RR}} & \text{Distributes proportional to } w_k & \text{Heterogeneous server hardware (8-core vs 64-core)} \\
     \mathbf{\text{Least Connections}} & \min_{k} \text{ActiveConnections}(S_k) & \mathbf{\text{Long-lived WebSockets, file uploads, slow DB queries}} \\
     \mathbf{\text{Consistent Hashing}} & \text{Clockwise on ring } [0, 2^{32}-1] & \mathbf{\text{Distributed Caching (Redis/Memcached), Sharded DBs}} \\
     \hline
     \end{array}$$
   - **The Consistent Hashing Remapping Bound:**
     $$\mathbf{\text{Keys Remapped on Node Join/Leave: } \frac{K}{N} \ll K \quad (\text{vs Modulo Hashing: } \approx 100\% \text{ remapped!})}$$
2. **Slide 2 (`ordering`):** Provide 5 steps of Consistent Hashing execution: (1) hash incoming request key (e.g. user_id: 'alice99') using MD5/MurmurHash3 onto $[0, 2^{32}-1]$ integer ring, (2) traverse the hash ring clockwise until the first virtual node token is encountered, (3) map the virtual node to its physical server instance and route request, (4) physical server Node 2 crashes and is removed from the ring, (5) subsequent lookups for keys previously assigned to Node 2 naturally fall to the next clockwise server Node 3, with zero disruption to remaining servers!
3. **Slide 3 (`matching`):** Pair 4 concepts (Round Robin, Least Connections, Consistent Hashing, Virtual Nodes) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Virtual Nodes. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on Consistent Hashing vs Modulo Hashing: Why does naive modulo hashing ($\text{server} = \text{hash}(\text{key}) \pmod N$) cause a catastrophic cache stampede in a distributed caching cluster when a single server crashes, whereas Consistent Hashing prevents it? (With naive modulo hashing, when the cluster size changes from $N$ to $N-1$, **virtually all keys are remapped to completely different servers because the modulo denominator changes ($key \pmod 4 \neq key \pmod 3$), causing nearly $100\%$ cache misses across the entire system that overwhelm backend databases**; Consistent Hashing maps keys to a circular ring so that when a server fails, **only the $\approx \frac{1}{N}$ fraction of keys originally mapped to that failed server are remapped to the next clockwise server, leaving the remaining $\frac{N-1}{N}$ keys completely unaffected**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "load_balancing_algorithms_round_robin_least_connections_and_consistent_hashing",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Load Balancing Scheduling Algorithms (Karger et al. 1997; Alex Xu)**\n• **Algorithm Scheduling \\& Trade-Off Taxonomy:**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Algorithm} & \\textbf{Mathematical Selection Logic} & \\textbf{Primary Production Scenario} \\\\\n\\hline\n\\mathbf{\\text{Round Robin}} & i = (i + 1) \\pmod N & \\text{Stateless REST requests; identical hardware} \\\\\n\\mathbf{\\text{Least Connections}} & \\min_{k \\in [1, N]} \\text{ActiveSockets}(S_k) & \\mathbf{\\text{Long-lived WebSockets, streaming, file uploads}} \\\\\n\\mathbf{\\text{Naive Modulo}} & \\text{Server} = \\text{Hash}(K) \\pmod N & \\mathbf{\\text{FAILED ANTI-PATTERN: Remaps 100% on scale!}} \\\\\n\\mathbf{\\text{Consistent Hashing}} & \\text{Clockwise search on circular ring } [0, 2^{32}-1] & \\mathbf{\\text{Distributed Caches (Redis/Memcached), Sharded DBs}} \\\\\n\\hline\n\\end{array}\n$$\n• **Consistent Hashing Remapping Bound:** Adding/removing 1 node remaps only $\\mathbf{\\frac{K}{N}}$ keys ($0\\%$ stampede)!\n• **Virtual Nodes (vnodes):** Each physical server maps to $V$ points (e.g. $V=100-300$) on the ring to **guarantee uniform load distribution and eliminate hotspot clustering**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed when a client key is routed and handled during a server failure on a Consistent Hashing ring.",
      "orderItems": [
        "Hash the incoming request key (e.g. MurmurHash3('user_42')) to calculate its integer position on the [0, 2^32 - 1] ring",
        "Traverse the circular ring clockwise from the key's position until encountering the first virtual node token",
        "Map the virtual node token to its parent physical server instance and route the request to that server",
        "Physical server Node 2 experiences hardware failure and its virtual node tokens are removed from the ring",
        "Subsequent queries for keys previously held by Node 2 fall clockwise to the next available server Node 3, leaving all other server keys unaffected"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Load Balancing Algorithm to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Round Robin", "right": "Cycles sequentially through a static list of backend workers without inspecting server load" },
        { "left": "Least Connections", "right": "Dispatches traffic dynamically to the backend node currently holding the lowest active TCP socket count" },
        { "left": "Consistent Hashing Ring", "right": "Circular integer space where key lookups and server nodes are mapped to minimize repartitioning" },
        { "left": "Virtual Nodes (vnodes)", "right": "Replicated tokens per physical node ensuring statistical uniformity and preventing data skew hotspots" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In Consistent Hashing, multiple replicas assigned to each physical server along the hash ring to prevent load skew are ___ nodes.",
      "blankAnswer": "virtual",
      "blankDistractors": ["real", "shadow", "proxy"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does naive modulo hashing (server = hash(key) mod N) trigger a catastrophic distributed cache stampede when a single server crashes in a 10-node caching cluster, whereas Consistent Hashing prevents it?",
      "options": [
        { "text": "With naive modulo hashing, when the active server count drops from 10 to 9, the modulo denominator changes for every calculation; because hash(key) mod 10 != hash(key) mod 9 for virtually all keys, nearly 100% of cached keys are immediately remapped to incorrect servers, resulting in a total cache invalidation that causes millions of client requests to stampede downstream SQL databases simultaneously; with Consistent Hashing, keys are mapped to a circular ring so that when a server fails, only the ~10% (1/N) of keys belonging to that failed server are remapped to the next clockwise neighbor, leaving the remaining 90% of cached keys fully valid and untouched", "isCorrect": true, "explanation": "Correct! This is David Karger and Alex Xu's foundational proof for Consistent Hashing (Karger et al. 1997; Alex Xu *System Design Interview* Volume 1 Chapter 5 *Design Consistent Hashing*). 1. **The Math of Modulo Hashing Catastrophe:** - Suppose you have $1,000,000\\text{ cached user profiles}$ across $10\\text{ Redis nodes}$. - Key `user_1` has hash $55$: $55 \\pmod{10} = \\mathbf{5}$ (Stored on Node 5). - Key `user_2` has hash $56$: $56 \\pmod{10} = \\mathbf{6}$ (Stored on Node 6). - Node 9 crashes. Now $N = 9$: - $55 \\pmod{9} = \\mathbf{1}$ (Now looked up on Node 1 $\\implies$ **MISS!**). - $56 \\pmod{9} = \\mathbf{2}$ (Now looked up on Node 2 $\\implies$ **MISS!**). - **Over $90\\%$ of all 1,000,000 keys suddenly produce cache misses!** The database melts under the stampede. 2. **The Consistent Hashing Ring Triumph:** - Hash ring has size $2^{32} - 1$. Node 5 is at $1,000,000$; Node 6 is at $2,000,000$. - Key $55$ is at $1,500,000 \\implies$ routes clockwise to Node 6. - If Node 9 (at $9,000,000$) crashes: **Key $55$ does not move!** - Only keys located between Node 8 and Node 9 move to the next node. - $90\\%$ of your cache remains completely warm and valid!" },
        { "text": "Because modulo hashing only works when computers are connected via USB", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Consistent Hashing makes all database queries return 0", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because modulo operators are illegal in modern programming languages", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
