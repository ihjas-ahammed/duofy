# Key to Flow: IP Addressing, CIDR Subnetting, OSPF Link-State, and BGP Inter-Domain Routing

**Subject Area:** `03_Computer_Science_and_IT / 05_Computer_Networks_and_Security / Network_Protocols_and_Architectures / IP_Addressing_Subnetting_and_Routing_BGP_OSPF`

---

## 📌 Core Concept & Mental Model
**Hierarchical Variable-Length Subnetting (CIDR), Longest Prefix Match (LPM) Forwarding Decisions, Global Link-State Map Synthesis (OSPF Dijkstra SPF), and Policy-Driven Inter-Autonomous System Path-Vector Peering (BGP)** govern Layer 3 internetworking and packet routing (Vint Cerf RFC 791 IPv4; Vince Fuller et al. 1993 RFC 1519 CIDR; John Moy 1998 RFC 2328 OSPFv2; Yakov Rekhter & Tony Li RFC 4271 BGP-4; Kurose & Ross Chapters 4 & 5; Tanenbaum & Wetherall Chapter 5):
* **1. IPv4 Addressing & CIDR Subnetting Math:**
  - **The 32-bit Address Binary Structure:** $\mathbf{\text{Network Prefix (}n\text{ bits)} \ + \ \text{Host Identifier (}32 - n\text{ bits)}}$.
  - **Subnet Calculations for Prefix $/n$:**
    - **Total Addresses:** $2^{32 - n}$.
    - **Usable Host Addresses:** $\mathbf{2^{32 - n} - 2}$ (Subtracting Network ID [all 0s] and Directed Broadcast [all 1s]).
    - **Network Address:** $\text{IP Address} \ \mathbf{\&} \ \text{Subnet Mask}$.
    - **Broadcast Address:** $\text{Network Address} \ \mathbf{|} \ \mathbf{\sim}\text{Subnet Mask}$.
* **2. Router Forwarding & Longest Prefix Match (LPM):**
  - **The LPM Invariant:** When an incoming packet's destination IP matches multiple overlapping routes in the Forwarding Information Base (FIB), the router **ALWAYS selects the route with the most specific (longest) prefix length**!
    - *Example:* Packet to `128.9.16.14` matching both `128.9.0.0/16` and `128.9.16.0/24` $\implies$ Forwarded via `128.9.16.0/24` (longer prefix).
* **3. Intra-Domain Routing: OSPF (Open Shortest Path First, RFC 2328):**
  - **Link-State Routing Protocol:** Every router floods **Link-State Advertisements (LSAs)** to build an identical **Link-State Database (LSDB)** representing the complete topological network graph.
  - **Dijkstra's SPF Algorithm:** Every router independently computes the shortest path tree rooted at itself ($\text{Cost} = \frac{10^8}{\text{Bandwidth in bps}}$).
  - **Hierarchical 2-Level Areas:** Backbone Area 0 (`0.0.0.0`) interconnects non-backbone areas to bound LSA flooding domains.
* **4. Inter-Domain Routing: BGP (Border Gateway Protocol, RFC 4271):**
  - **Path-Vector Protocol:** Routes between autonomous systems (ASes); prevents loops by tracking the explicit **`AS-PATH` attribute** (a list of AS numbers `[AS100, AS200, AS300]`; if local AS is in path, route is discarded!).
  - **eBGP vs iBGP:**
    - **eBGP (External BGP):** Peers between border routers of *different* autonomous systems.
    - **iBGP (Internal BGP):** Distributes external BGP routes *within* the same autonomous system.
  - **Policy-Driven Routing:** BGP path selection prioritizes business contracts and monetary agreements (e.g. `LOCAL_PREF` $\to$ shortest `AS-PATH` $\to$ `MED`) over raw shortest physical distance.

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The 3-Tier Routing Decision Ladder
* Local Subnet Math: $2^{32-n} - 2$.
* Intra-Domain (Interior): OSPF Dijkstra SPF Map.
* Inter-Domain (Exterior): BGP Policy & AS-Path Vector.

### 2. Top Recommended Resources
* **The Routing Bible:** *Computer Networking: A Top-Down Approach* (Kurose & Ross 8th Ed.), Chapters 4 (Network Layer: Data Plane) & 5 (Control Plane).
* **Routing TCP/IP Masterclass:** *Routing TCP/IP Volume 1 & 2* (Jeff Doyle & Jennifer Carroll, Cisco Press).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you calculate the network address, broadcast address, and usable host count for a given `/27` or `/29` subnet?
- [ ] Can you resolve a forwarding decision using Longest Prefix Match (LPM)?
- [ ] Can you trace how OSPF builds the LSDB and computes shortest paths via Dijkstra's algorithm?
- [ ] Can you explain how BGP uses the `AS-PATH` attribute to eliminate inter-domain routing loops?
