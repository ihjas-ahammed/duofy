# Key to Flow: Containerization & Orchestration (Docker & Kubernetes Architecture)

**Subject Area:** `03_Computer_Science_and_IT / 09_Web_Mobile_and_Cloud_Computing / Cloud_Computing_and_DevOps / Containerization_Docker_Kubernetes`

---

## 📌 Core Concept & Mental Model
**Linux OS Isolation Primitives (Kernel Namespaces [PID, NET, MNT, IPC, UTS, USER], Cgroups [CPU/Memory Hard Limits], & OverlayFS Copy-on-Write Image Layers), Declarative Multi-Stage Containerization (Docker Minimal Runtime Artifacts), Distributed Cluster Control Plane Orchestration (kube-apiserver REST Gateway, Raft-Backed etcd Consensus Store, kube-scheduler Constraint Matcher, & kube-controller-manager State Reconcilers), Worker Node Execution Infrastructure (kubelet Node Agent, kube-proxy iptables Packet Router, & CRI Runtimes), and Cluster Networking & Resiliency (Pod Localhost Namespaces, Service Discovery [ClusterIP, NodePort, LoadBalancer], L7 Ingress Controllers, & Liveness/Readiness Probes)** govern modern cloud-native containerized infrastructure (Kelsey Hightower, Brendan Burns, & Joe Beda *Kubernetes: Up and Running* 3rd ed.; Nigel Poulton *Docker Deep Dive*; Marko Lukša *Kubernetes in Action* 2nd ed.):
* **1. Linux Containerization Engine (Docker):**
  - **Namespaces (Isolation):** Isolate what a process can **SEE** (`pid` processes, `net` network interfaces/ports, `mnt` filesystem mount points, `ipc` shared memory).
  - **Cgroups (Resource Limits):** Limit how much a process can **USE** (e.g. max $2.0\text{ CPU cores}$, max $4\text{GB RAM}$ with OOM-killer enforcement).
  - **OverlayFS (Union Filesystem):** Read-only immutable image layers stacked beneath a thin mutable Container Layer.
* **2. Kubernetes Control Plane vs Worker Node Architecture:**
  $$\begin{array}{|l|l|l|}
  \hline
  \textbf{Cluster Tier} & \textbf{Component Name} & \textbf{Core Distributed System Role} \\
  \hline
  \mathbf{\text{Control Plane}} & \mathbf{\texttt{kube-apiserver}} & \mathbf{\text{Central REST API gateway; ONLY component writing to etcd}} \\
  \mathbf{\text{Control Plane}} & \mathbf{\texttt{etcd}} & \mathbf{\text{Strongly consistent distributed key-value store (Raft consensus)}} \\
  \mathbf{\text{Control Plane}} & \mathbf{\texttt{kube-scheduler}} & \text{Assigns unassigned Pods to optimal worker nodes based on constraints} \\
  \mathbf{\text{Control Plane}} & \mathbf{\texttt{kube-controller-manager}} & \mathbf{\text{Reconciliation loops (Desired State } \longleftrightarrow \text{ Actual State)}} \\
  \hline
  \mathbf{\text{Worker Node}} & \mathbf{\texttt{kubelet}} & \mathbf{\text{Node supervisor; communicates with CRI runtime to run Pods}} \\
  \mathbf{\text{Worker Node}} & \mathbf{\texttt{kube-proxy}} & \text{Maintains iptables/IPVS routing rules for Kubernetes Services} \\
  \mathbf{\text{Worker Node}} & \mathbf{\text{CRI Engine (containerd)}} & \text{Pulls container images and executes OCI runtime processes} \\
  \hline
  \end{array}$$
* **3. Kubernetes Service Networking Taxonomy:**
  $$\mathbf{\text{ClusterIP (Internal Cluster VIP)}} \longrightarrow \mathbf{\text{NodePort (Port 30000-32767 on all Nodes)}} \longrightarrow \mathbf{\text{LoadBalancer (Cloud LB)}} \longrightarrow \mathbf{\text{Ingress (L7 Routing, SSL)}}}$$
* **4. Pod Lifecycle & Health Check Invariants:**
  - **Liveness Probe:** *\"Is the application container healthy?\"* If failed $\implies$ `kubelet` terminates and **restarts the container**!
  - **Readiness Probe:** *\"Is the application ready to serve traffic (warmed up)?\"* If failed $\implies$ removes Pod IP from **Service endpoint load balancing pool** without killing the container!

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Cloud-Native Pipeline Hierarchy
* Linux Kernel Substrate $\to$ Namespaces (Visibility) + Cgroups (Resource Throttling) + OverlayFS.
* Packaging $\to$ Multi-Stage Dockerfile $\to$ Scratch/Distroless image artifact.
* Distributed Control Plane $\to$ `kube-apiserver` $\to$ `etcd` (Raft) $\to$ `kube-scheduler` $\to$ `controllers`.
* Node Execution $\to$ `kubelet` $\to$ CRI (`containerd`) $\to$ `kube-proxy` (iptables).
* Networking & High Availability $\to$ ClusterIP / NodePort / Ingress $\to$ Liveness vs Readiness Probes.

### 2. Top Recommended Resources
* **The Kubernetes Standard:** *Kubernetes: Up and Running* (Kelsey Hightower, Brendan Burns, Joe Beda, O'Reilly 3rd ed.).
* **The Hands-on Blueprint:** *Kubernetes The Hard Way* (Kelsey Hightower, GitHub).
* **The Container Internals Guide:** *Docker Deep Dive* (Nigel Poulton).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you trace how Linux PID and NET namespaces isolate Docker processes from the host?
- [ ] Can you diagram all 4 Control Plane components and explain why only `kube-apiserver` talks to `etcd`?
- [ ] Can you configure a multi-stage Dockerfile that reduces image size by $95\%$?
- [ ] Can you contrast `ClusterIP`, `NodePort`, `LoadBalancer`, and Layer 7 `Ingress`?
- [ ] Can you evaluate the exact failure behavior of a Liveness Probe vs a Readiness Probe?
