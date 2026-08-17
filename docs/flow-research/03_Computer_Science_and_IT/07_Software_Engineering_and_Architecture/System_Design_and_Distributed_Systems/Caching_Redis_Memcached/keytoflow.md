# Key to Flow: Distributed Caching (Patterns, Redis vs Memcached, & Anomaly Defenses)

**Subject Area:** `03_Computer_Science_and_IT / 07_Software_Engineering_and_Architecture / System_Design_and_Distributed_Systems / Caching_Redis_Memcached`

---

## 📌 Core Concept & Mental Model
**In-Memory Access Latency Optimization ($<1\text{ ms}$ RAM vs $10-50\text{ ms}$ Disk/SQL), Caching Topologies (Cache-Aside, Write-Through, & Write-Back/Behind), Data Structure Store Architecture (Redis Single-Threaded Event Loop, RDB/AOF Persistence, Hashes/Sets/ZSets vs Memcached Multi-Threaded Strings), Eviction Policies (LRU, LFU, FIFO), and Failure Anomaly Immunization (Cache Penetration + Bloom Filters, Cache Avalanche + TTL Jitter, and Cache Breakdown/Stampede + Mutex Locks)** govern distributed caching and high-throughput database protection (Alex Xu *System Design Interview* Volume 1 & 2; Martin Kleppmann *Designing Data-Intensive Applications*; Salvatore Sanfilippo Redis Documentation):
* **1. Caching Flow Patterns:**
  - **Cache-Aside (Lazy Loading):** App queries cache first; on cache miss, reads from DB and writes to cache. Extremely resilient (cache failure doesn't crash app), but vulnerable to stale data.
  - **Write-Through:** App writes to cache; cache synchronously writes to DB before returning success (strong consistency, higher write latency).
  - **Write-Back / Write-Behind:** App writes to cache; cache asynchronously batches updates to DB (blazing fast write throughput, but risks data loss on cache crash).
  - **Write-Around:** Writes bypass cache straight to DB (avoids cache churn for rarely read writes).
* **2. Redis vs Memcached Architecture:**
  $$\begin{array}{|l|l|l|}
  \hline
  \textbf{Architectural Axis} & \textbf{Redis (Remote Dictionary Server)} & \textbf{Memcached} \\
  \hline
  \mathbf{\text{Threading Model}} & \mathbf{\text{Single-Threaded Event Loop (epoll IO)}} & \mathbf{\text{Multi-Threaded (Multi-core scale)}} \\
  \mathbf{\text{Data Types}} & \mathbf{\text{Strings, Hashes, Lists, Sets, ZSets (SkipList), Streams}} & \text{Raw Strings / Serialized Blobs only} \\
  \mathbf{\text{Disk Persistence}} & \mathbf{\text{RDB (Point-in-time) + AOF (Append-Only File)}} & \mathbf{\text{Zero Persistence (Pure volatile RAM)}} \\
  \mathbf{\text{Clustering / HA}} & \text{Redis Sentinel (Failover) + Redis Cluster (16k slots)} & \text{Client-side Consistent Hashing} \\
  \hline
  \end{array}$$
* **3. Eviction Algorithms:**
  - **LRU (Least Recently Used):** Evicts the key accessed least recently (Doubly-Linked List + Hash Map, $O(1)$).
  - **LFU (Least Frequently Used):** Evicts the key with lowest access counter (Min-Heap / Count Frequency List).
* **4. The 3 Classic Caching Anomalies & Solutions:**
  - **Cache Penetration:** Requests for non-existent keys bypass cache and hammer DB. $\implies$ *Solution: Bloom Filter at edge or cache `null` objects with short TTL (e.g. 60s)*.
  - **Cache Avalanche:** Thousands of keys expire simultaneously at the same second, overwhelming DB. $\implies$ *Solution: Add random jitter to expiration times ($\text{TTL} = \text{Base} + \text{rand}(0, 300\text{s})$)*.
  - **Cache Breakdown / Stampede:** A super-hot key expires, and 10,000 concurrent threads simultaneously hit DB to rebuild it. $\implies$ *Solution: Mutex / Distributed Lock (Redlock) or single-flight coalescing*.

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Caching Decision Tree
* Read Heavy $\to$ Cache-Aside (Lazy Loading).
* Strong Consistency $\to$ Write-Through.
* Write Heavy / High Ingestion $\to$ Write-Back (Async batching).
* Complex Types (Leaderboards, Sets) $\to$ Redis ZSet.
* Simple Key-Value on 64-Core CPU $\to$ Memcached.
* Hotspot / Outage Protection $\to$ Bloom Filter + TTL Jitter + Mutex Lock.

### 2. Top Recommended Resources
* **The Blueprint:** *System Design Interview* (Alex Xu, Chapters on Caching & Rate Limiting).
* **The Redis Source:** *Redis Documentation & Internal Data Structures* (redis.io).
* **The Theory:** *Designing Data-Intensive Applications* (Martin Kleppmann, Chapter 3).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you contrast Cache-Aside with Write-Through and Write-Back?
- [ ] Can you differentiate Redis and Memcached across data types, threading, and persistence?
- [ ] Can you explain the difference between Cache Penetration, Avalanche, and Breakdown?
- [ ] Can you implement TTL jitter and Bloom filter defenses against caching failures?
