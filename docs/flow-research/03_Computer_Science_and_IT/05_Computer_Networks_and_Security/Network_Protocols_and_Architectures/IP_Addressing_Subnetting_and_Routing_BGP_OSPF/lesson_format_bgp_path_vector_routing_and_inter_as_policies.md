# Duofy Reusable Lesson Format: BGP Path-Vector Routing and Inter-AS Policies

**Target Topic:** `03_Computer_Science_and_IT / 05_Computer_Networks_and_Security / Network_Protocols_and_Architectures / IP_Addressing_Subnetting_and_Routing_BGP_OSPF`  
**Lesson Format Type:** `bgp_path_vector_routing_and_inter_as_policies`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the inter-autonomous system peering protocols, path-vector loop prevention mechanics, and business policy routing decisions of the Border Gateway Protocol (BGP-4) (Yakov Rekhter & Tony Li RFC 4271; Kurose & Ross *Computer Networking* Chapter 5.4; Tanenbaum & Wetherall Chapter 5.6): master the **Path-Vector Protocol Invariants** (advertising reachability with explicit **`AS-PATH` attribute sequences** like `[AS 701, AS 1239, AS 15169]`), decode the **Loop Elimination Rule** (a BGP speaker immediately discards an incoming route advertisement if its own Autonomous System Number [ASN] is present in the `AS-PATH`), contrast **eBGP (External BGP across AS boundaries)** with **iBGP (Internal BGP within an AS)**, master the **BGP Best-Path Decision Algorithm Hierarchy** (**1. Highest `LOCAL_PREF` $\to$ 2. Shortest `AS-PATH` $\to$ 3. Lowest `ORIGIN` $\to$ 4. Lowest `MED` (Multi-Exit Discriminator) $\to$ 5. eBGP over iBGP $\to$ 6. Lowest IGP metric (Hot-Potato Routing) $\to$ 7. Lowest Router ID**), and evaluate BGP route hijacking risks and RPKI validation.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | BGP Path-Vector Architecture, AS-PATH Loop Prevention, & Decision Hierarchy Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step BGP Route Decision Algorithm Evaluation Hierarchy Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | BGP Attribute / Peering Type & Policy Routing Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Name of the Mandatory BGP Attribute Containing the List of Autonomous Systems Traversed (AS_PATH) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Analysis of Why BGP Routes Traffic Based on Commercial Business Policies Rather Than Shortest Path Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State BGP & Path-Vector (RFC 4271; Kurose & Ross 5.4):
   - **Path-Vector Routing Paradigm:**
     - Instead of transmitting raw link costs or distance vectors, BGP advertises:
       $$\mathbf{\text{Prefix } (e.g. \ 198.51.100.0/24) \ + \ \mathbf{\text{AS-PATH Attribute } [AS_{100}, AS_{200}, AS_{300}]}}$$
   - **Loop Detection Invariant:**
     - When Router in $AS_X$ receives an advertisement:
       $$\mathbf{\text{If } AS_X \in \text{AS-PATH} \implies \text{DISCARD ROUTE IMMEDIATELY! (Loop Detected!)}}$$
   - **The 7-Step BGP Best-Path Decision Hierarchy:**
     $$\mathbf{\text{Highest LOCAL\_PREF} \to \text{Shortest AS-PATH} \to \text{Lowest ORIGIN} \to \text{Lowest MED} \to \text{eBGP > iBGP} \to \text{Hot-Potato IGP} \to \text{Lowest Router ID}}$$
   - **eBGP vs iBGP:**
     - eBGP: Exchanges routes between border routers in *different* ASes (over TCP port 179).
     - iBGP: Propagates external routes to all core routers *inside* the same AS (requires full mesh or Route Reflectors).
2. **Slide 2 (`ordering`):** Provide 5 steps of the BGP Best-Path selection process: (1) evaluate LOCAL_PREF: select path with highest administrative local preference (e.g. 200 > 100), (2) if tied, evaluate AS-PATH: select route that traverses the fewest Autonomous Systems (shortest AS-PATH length), (3) if tied, evaluate ORIGIN code: prefer IGP over EGP over Incomplete, (4) if tied, evaluate MED (Multi-Exit Discriminator): prefer route with lowest MED advertised by neighbor AS, (5) if tied, prefer eBGP over iBGP path, then apply Hot-Potato routing (lowest internal IGP cost to egress router)!
3. **Slide 3 (`matching`):** Pair 4 BGP terms (AS-PATH Attribute, LOCAL_PREF Attribute, MED Attribute, eBGP Session) with their functions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of the AS_PATH attribute. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on policy routing in BGP: An Internet Service Provider (ISP A, $AS_{100}$) receives two BGP route advertisements for destination prefix `203.0.113.0/24`: Route 1 comes from a paying Customer with `AS-PATH [AS 200, AS 300, AS 400]` (3 hops). Route 2 comes from an expensive Transit Provider with `AS-PATH [AS 500]` (1 hop). Why does ISP A choose Route 1 (3 hops) over Route 2 (1 hop), and how is this configured? (Because BGP is a **Policy-Based Routing protocol governed by business economics rather than shortest physical distance**; customer traffic generates revenue for ISP A while transit provider traffic costs ISP A money; ISP A configures its inbound policy to assign a **higher `LOCAL_PREF` (e.g. 200) to customer routes and lower `LOCAL_PREF` (e.g. 100) to transit routes**, and since `LOCAL_PREF` is evaluated *before* `AS-PATH` length in the BGP decision algorithm, Route 1 wins).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "bgp_path_vector_routing_and_inter_as_policies",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Border Gateway Protocol (BGP-4 RFC 4271)**\n• **Path-Vector Loop Prevention Invariant (Kurose & Ross Chapter 5.4):**\nBGP advertises IP prefixes bundled with an explicit sequence of Autonomous System Numbers (ASNs):\n$$\n\\mathbf{\\text{Prefix: } 198.51.100.0/24 \\qquad \\mathbf{\\text{AS-PATH: } [AS_{100}, AS_{200}, AS_{300}]}}\n$$\n$$\n\\mathbf{\\text{If local } AS_{\\text{local}} \\in \\text{AS-PATH} \\implies \\mathbf{\\text{DISCARD ADVERTISEMENT IMMEDIATELY! (Loop Prevented!)}}}\n$$\n• **BGP Best-Path Decision Hierarchy (Top to Bottom):**\n$$\n\\mathbf{\\mathbf{1. \\ \\text{Highest LOCAL\\_PREF}} \\ \\longrightarrow \\ \\mathbf{2. \\ \\text{Shortest AS-PATH}} \\ \\longrightarrow \\ \\mathbf{3. \\ \\text{Lowest MED}} \\ \\longrightarrow \\ \\mathbf{4. \\ \\text{eBGP > iBGP}} \\ \\longrightarrow \\ \\mathbf{5. \\ \\text{Hot-Potato IGP}}}\n$$\n• **The Business Reality:** BGP routes based on **commercial contracts and monetary policy**, NOT shortest physical latency!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential evaluation steps of the BGP Best-Path Selection Algorithm.",
      "orderItems": [
        "Step 1: Evaluate LOCAL_PREF attribute; select route with the highest local preference value (administrative policy)",
        "Step 2: If LOCAL_PREF is tied, evaluate AS-PATH attribute; select route that traverses the fewest Autonomous Systems (shortest path)",
        "Step 3: If AS-PATH length is tied, evaluate ORIGIN code; prefer routes originated by IGP over EGP over Incomplete",
        "Step 4: If ORIGIN is tied, evaluate MED (Multi-Exit Discriminator); select route with lowest metric from the same neighbor AS",
        "Step 5: If MED is tied, prefer eBGP routes over iBGP routes, and then apply Hot-Potato routing (lowest internal IGP cost to egress border router)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each BGP Protocol Concept to its exact Routing Policy Function.",
      "matchPairs": [
        { "left": "AS-PATH Attribute", "right": "Ordered list of traversed Autonomous Systems used for path-vector loop prevention and shortest-path comparison" },
        { "left": "LOCAL_PREF Attribute", "right": "Locally configured metric that dictates preferred egress path across the entire internal autonomous system" },
        { "left": "MED (Multi-Exit Discriminator)", "right": "Informs an external neighboring AS of the preferred ingress entry link into the local autonomous system" },
        { "left": "Hot-Potato Routing", "right": "Routes traffic to the closest internal egress border router to hand off packets as quickly as possible" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The mandatory BGP attribute containing the sequence of Autonomous Systems a route advertisement has crossed is the ___ attribute.",
      "blankAnswer": "AS_PATH",
      "blankDistractors": ["LOCAL_PREF", "COMMUNITY", "NEXT_HOP"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "An Internet Service Provider (ISP A, AS 100) receives two BGP route advertisements for destination prefix 203.0.113.0/24: Route 1 is advertised by a paying Customer with AS-PATH [AS 200, AS 300, AS 400] (length 3). Route 2 is advertised by an upstream Tier-1 Transit Provider with AS-PATH [AS 500] (length 1). Why does ISP A configure its network to route customer traffic via Route 1 (3 hops) rather than Route 2 (1 hop)?",
      "options": [
        { "text": "Because BGP is a policy-driven routing protocol governed by commercial business economics rather than shortest physical hop count; traffic sent to paying customers generates revenue for ISP A (Customer-Provider relationship), whereas traffic sent to upstream transit providers incurs bandwidth transit fees; ISP A assigns a higher LOCAL_PREF (e.g. 200) to customer routes and a lower LOCAL_PREF (e.g. 100) to transit routes, and because LOCAL_PREF is evaluated before AS-PATH length in the BGP decision algorithm, the customer route is selected", "isCorrect": true, "explanation": "Correct! This is the fundamental commercial economic principle of internet peering and BGP policy routing (Kurose & Ross Section 5.4; Lixin Gao *On Inferring Autonomous System Relationships in the Internet*). 1. **The Commercial Relationships:** - **Customer-to-Provider:** Customer pays ISP A for internet access. When ISP A sends traffic to a customer, ISP A makes money! - **Provider-to-Customer:** ISP A must pay expensive Tier-1 transit providers (like Lumen, NTT, Telia) for every gigabyte of traffic sent through them. 2. **The Policy Goal:** - ISP A always wants to route traffic: **Customer > Peer (Free settlement) > Upstream Provider (Expensive)**. 3. **How BGP Implements This:** - ISP A's network engineers configure route-maps on border routers: - Set `LOCAL_PREF = 200` for all routes received from Customers. - Set `LOCAL_PREF = 150` for routes received from Peers. - Set `LOCAL_PREF = 100` for routes received from Upstream Transit Providers. 4. **Decision Algorithm Execution:** - Step 1 of BGP is `LOCAL_PREF`. - Route 1 has `LOCAL_PREF = 200`. - Route 2 has `LOCAL_PREF = 100`. - Route 1 wins IMMEDIATELY at Step 1! The router never even looks at the `AS-PATH` length (Step 2). BGP routes where the money flows!" },
        { "text": "Because BGP routers can only count up to 1 hop", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because AS 500 is blocked by DNS root servers", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because transit providers do not support IPv4 addresses", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
