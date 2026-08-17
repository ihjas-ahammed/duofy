# Key to Flow: Hadoop Ecosystem (HDFS Storage, MapReduce Computation, & YARN Resource Management)

**Subject Area:** `03_Computer_Science_and_IT / 06_Artificial_Intelligence_and_Machine_Learning / Data_Mining_and_Big_Data_Analytics / Hadoop_HDFS_and_MapReduce`

---

## 📌 Core Concept & Mental Model
**Distributed Block Storage & Master-Slave Metadata Topology (HDFS with 128MB Blocks & Rack Awareness), Data Locality-Driven Functional Computation ($\text{Map} \to \text{Shuffle \& Sort} \to \text{Reduce}$), Bandwidth-Optimized Intermediate Combiners, Dynamic Partitioning ($\text{hash}(k) \pmod R$), and Centralized Cluster Resource Scheduling (YARN ResourceManager, NodeManager, & ApplicationMaster)** govern big data batch processing across commodity server clusters (Jeffrey Dean & Sanjay Ghemawat 2004 *MapReduce*, OSDI; Sanjay Ghemawat et al. 2003 *The Google File System*, SOSP; Tom White *Hadoop: The Definitive Guide* 4th ed.; Doug Cutting & Mike Cafarella 2006 Apache Hadoop):
* **1. HDFS Storage Architecture (Master/Slave):**
  - **NameNode (Master):** Stores all filesystem metadata (namespace tree, block mappings) entirely in memory (`fsimage` checkpoint + continuous `EditLog`).
  - **DataNodes (Slaves):** Store raw physical blocks on local ext4/xfs disks (default block size $\mathbf{128\text{ MB}}$).
  - **The Rack Awareness 3x Replication Policy:**
    - Replica 1: On the local DataNode where client writes.
    - Replica 2: On a different node in a **different remote rack**.
    - Replica 3: On a different node in the **same remote rack** as Replica 2.
    - *Guarantees:* Survives full rack power/switch failures while minimizing inter-switch network bandwidth during writes!
* **2. The MapReduce Computational Paradigm:**
  - Moves computation to data (**Data Locality Principle**):
  - **Map Phase:** $\text{map}: (k_1, v_1) \to \text{list}(k_2, v_2)$ (Operates in parallel per 128MB input split).
  - **The Shuffle and Sort Phase:**
    - Mappers write to an in-memory circular buffer ($100\text{ MB}$, spills at $80\%$).
    - **Combiner (Mini-Reducer):** Performs local aggregation on the mapper node before network transfer.
    - **Partitioner:** Assigns intermediate keys to Reducers: $\mathbf{\text{reducer\_id} = \big(\text{hash}(\text{key}) \ \& \ \text{0x7FFFFFFF}\big) \pmod R}$.
    - Network transfers key groups to Reducers, performing multi-way **External Merge Sort**.
  - **Reduce Phase:** $\text{reduce}: (k_2, \text{list}(v_2)) \to \text{list}(k_3, v_3)$ (Aggregates values per unique key and writes to HDFS).
* **3. YARN (Yet Another Resource Negotiator - Apache Hadoop 2.0+):**
  - Separates resource management from processing models, allowing Spark, Flink, and MapReduce to share cluster resources:
  - **ResourceManager (Central Master):** Arbitrates compute capacity (vCores, RAM) across the cluster via pluggable schedulers (Capacity / Fair Scheduler).
  - **NodeManager (Per-Node Agent):** Launches and monitors resource **Containers** (cgroups) on worker nodes.
  - **ApplicationMaster (Per-Job Project Manager):** Negotiates containers from the ResourceManager, coordinates task execution, and handles fault recovery.
* **4. Fault Tolerance & Speculative Execution:**
  - **Worker Failure:** NodeManager sends heartbeats (every 3s); if dead after 10m, NameNode replicates lost blocks, and ApplicationMaster re-launches lost tasks.
  - **Straggler Mitigation:** If a worker node runs slowly due to degraded hardware, YARN launches a **Speculative Task** duplicate on another node; whichever finishes first is accepted and the other killed.

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Big Data Processing Stack
* Storage Foundation $\to$ HDFS NameNode/DataNode (128MB Block + Rack Awareness 3x).
* Resource Kernel $\to$ YARN (ResourceManager $\to$ NodeManager $\to$ Containers $\to$ AppMaster).
* Compute Engine $\to$ MapReduce ($\text{Map} \to \text{Combiner} \to \text{Shuffle/Sort} \to \text{Reduce}$).
* Performance Optimization $\to$ Combiners (Bandwidth Reduction) + Custom Partitioners + Speculative Execution.

### 2. Top Recommended Resources
* **The Big Data Bible:** *Hadoop: The Definitive Guide* (Tom White, O'Reilly 4th ed.).
* **The Foundational Google Papers:** *MapReduce: Simplified Data Processing on Large Clusters* (Dean & Ghemawat, OSDI 2004); *The Google File System* (Ghemawat et al., SOSP 2003).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you trace HDFS 3x block placement across local and remote racks?
- [ ] Can you diagram the complete Shuffle and Sort pipeline from mapper circular buffer to reducer merge sort?
- [ ] Can you explain why Combiners must be associative and commutative?
- [ ] Can you contrast the roles of YARN's ResourceManager and ApplicationMaster?
