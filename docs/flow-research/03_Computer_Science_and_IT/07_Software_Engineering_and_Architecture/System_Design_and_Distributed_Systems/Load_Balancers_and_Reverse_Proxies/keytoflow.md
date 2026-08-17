# Key to Flow: Load Balancing & Proxies (L4 vs L7, Hashing Algorithms, & NGINX/Envoy)

**Subject Area:** `03_Computer_Science_and_IT / 07_Software_Engineering_and_Architecture / System_Design_and_Distributed_Systems / Load_Balancers_and_Reverse_Proxies`

---

## 📌 Core Concept & Mental Model
**Traffic Decoupling (Forward vs Reverse Proxy), OSI Transport vs Application Multiplexing (Layer 4 vs Layer 7 Load Balancing), Algorithmic Work Distribution (Round Robin, Least Connections, and Consistent Hashing Rings with Virtual Nodes), Edge Security & Acceleration (TLS Termination, Rate Limiting, & Caching via NGINX/Envoy), and Active-Active High Availability (VRRP Virtual IP & BGP Anycast Routing)** govern high-throughput web architecture and resilient distributed traffic distribution (Alex Xu *System Design Interview* Volume 1 & 2; Martin Kleppmann *Designing Data-Intensive Applications*; NGINX & Envoy Architecture Guides):
* **1. Forward Proxy vs Reverse Proxy vs Load Balancer:**
  - **Forward Proxy:** Acts on behalf of clients (e.g. corporate egress proxy hiding client IPs, bypassing geo-blocks, content filtering).
  - **Reverse Proxy:** Acts on behalf of backend servers (e.g. NGINX, HAProxy, Envoy: single public entry point hiding internal server IPs, terminating TLS, rate limiting, and caching).
  - **Load Balancer:** Distributes inbound concurrent traffic across a horizontal pool of backend worker servers.
* **2. Layer 4 (L4) vs Layer 7 (L7) Load Balancing:**
  $$\begin{array}{|l|l|l|l|l|}
  \hline
  \textbf{OSI Layer} & \textbf{Inspection Level} & \textbf{Routing Criteria} & \textbf{Throughput / Latency} & \textbf{Typical Technologies} \\
  \hline
  \mathbf{\text{Layer 4 (Transport)}} & \text{TCP / UDP Packets} & \text{Source/Dest IP + Port} & \mathbf{\text{Line-Rate (Millions req/s, <1ms)}} & \text{AWS NLB, LVS/IPVS, HAProxy TCP} \\
  \mathbf{\text{Layer 7 (Application)}} & \mathbf{\text{HTTP / TLS / gRPC Body}} & \mathbf{\text{URL Path, Headers, Cookies}} & \text{High CPU (Terminates TCP/TLS)} & \mathbf{\text{AWS ALB, NGINX, Envoy, Traefik}} \\
  \hline
  \end{array}$$
* **3. Load Balancing Scheduling Algorithms:**
  - **Round Robin & Weighted Round Robin:** Deterministic sequential cycling; weighted by backend CPU/memory capability.
  - **Least Connections:** Routes new requests to the backend worker with the fewest active TCP connections (ideal for long-lived WebSockets or uneven request processing times).
  - **Consistent Hashing:** Hashes keys and server nodes onto a circular $2^{32}-1$ hash ring with **Virtual Nodes (vnodes)**; adding/removing a server remaps only $\frac{K}{N}$ keys rather than all keys!
* **4. Edge Capabilities & High Availability:**
  - **TLS Termination:** Offloads expensive asymmetric cryptography (RSA/ECDSA handshakes) at the proxy edge, allowing backend microservices to communicate over fast plaintext HTTP.
  - **Rate Limiting:** Token Bucket / Leaky Bucket algorithms preventing DDoS and API starvation.
  - **High Availability (HA):** Active-Passive failover via **VRRP (Virtual Router Redundancy Protocol / Keepalived)** with shared floating Virtual IP (VIP), or Active-Active scale via **BGP Anycast Routing**.

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Traffic Routing Spectrum
* Proxy Role $\to$ Forward (Client side) vs Reverse (Server side).
* Network Depth $\to$ Layer 4 (Packet/Port) vs Layer 7 (HTTP/Path/Cookie).
* Scheduling Algorithm $\to$ Round Robin vs Least Connections vs Consistent Hashing Ring.
* Edge Acceleration $\to$ TLS Termination + Rate Limiting (Token Bucket).
* High Availability $\to$ Floating VIP (Keepalived VRRP) + BGP Anycast.

### 2. Top Recommended Resources
* **The Interview Bible:** *System Design Interview – An Insider's Guide* (Alex Xu, ByteByteGo Volume 1 & 2).
* **The Distributed Data Bible:** *Designing Data-Intensive Applications* (Martin Kleppmann, O'Reilly 2017).
* **The Production Manual:** *Mastering NGINX* & *Envoy Proxy Architecture Guide*.

---

## 🎯 Problem-Solving Checklist
- [ ] Can you contrast Layer 4 (packet-level) with Layer 7 (content-aware) load balancing?
- [ ] Can you explain why Consistent Hashing with virtual nodes prevents cache stampedes during scaling?
- [ ] Can you explain how TLS termination improves backend microservice performance?
- [ ] Can you diagram an Active-Passive Keepalived VRRP floating IP failover topology?
