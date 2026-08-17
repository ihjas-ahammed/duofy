# Duofy Reusable Lesson Format: Kubernetes Architecture (Control Plane and Worker Nodes)

**Target Topic:** `03_Computer_Science_and_IT / 09_Web_Mobile_and_Cloud_Computing / Cloud_Computing_and_DevOps / Containerization_Docker_Kubernetes`  
**Lesson Format Type:** `kubernetes_control_plane_architecture_and_worker_nodes`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through distributed consensus, declarative reconciliation loops, cluster orchestration, and node execution agents in Kubernetes (Kelsey Hightower, Brendan Burns, Joe Beda *Kubernetes: Up and Running* 3rd ed.; Marko Lukša *Kubernetes in Action* 2nd ed.; *Kubernetes The Hard Way*): master the **4 Control Plane Components**: **1. `kube-apiserver`** (the central REST API gateway and stateless orchestrator; the **ONLY** cluster component that communicates directly with `etcd`), **2. `etcd`** (strongly consistent distributed key-value store using the Raft consensus algorithm maintaining full desired cluster state), **3. `kube-scheduler`** (assigns newly created, unscheduled Pods to optimal worker nodes based on resource requests/limits, affinity/anti-affinity, and taints/tolerations), and **4. `kube-controller-manager`** (runs asynchronous reconciliation control loops comparing **Desired State vs Actual State**); master the **Worker Node Architecture**: **1. `kubelet`** (node supervisor agent communicating with container runtimes via CRI), **2. `kube-proxy`** (maintains network routing and iptables/IPVS rules for ClusterIP Services), and **3. Container Runtime Interface (CRI)** (e.g. `containerd`, CRI-O).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Kubernetes Cluster Architecture Diagram (Control Plane vs Worker Nodes) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Chronological Execution of 'kubectl apply -f deployment.yaml' Across the Cluster Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Kubernetes Architecture Component / Control Plane Daemon & Technical Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In Kubernetes, the Distributed Raft-Based Key-Value Store That Holds the Authoritative Cluster State Is ___ (etcd) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Distributed Systems Analysis: Why Only kube-apiserver Communicates Directly with etcd Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State K8s Architecture (Burns, Beda, Hightower 2022):
   - **Control Plane vs Worker Node Matrix:**
     $$\begin{array}{|l|l|l|}
     \hline
     \textbf{Cluster Tier} & \textbf{Daemon / Component} & \textbf{Distributed System Function} \\
     \hline
     \mathbf{\text{Control Plane}} & \mathbf{\texttt{kube-apiserver}} & \mathbf{\text{Stateless REST API gateway, auth, validation, schema registry}} \\
     \mathbf{\text{Control Plane}} & \mathbf{\texttt{etcd}} & \mathbf{\text{Distributed consistent KV store (Raft consensus, cluster state)}} \\
     \mathbf{\text{Control Plane}} & \mathbf{\texttt{kube-scheduler}} & \text{Filters/scores nodes and binds unassigned Pods to worker nodes} \\
     \mathbf{\text{Control Plane}} & \mathbf{\texttt{kube-controller-manager}} & \mathbf{\text{Executes reconciliation loops (Desired State } \longleftrightarrow \text{ Actual State)}} \\
     \hline
     \mathbf{\text{Worker Node}} & \mathbf{\texttt{kubelet}} & \mathbf{\text{Node agent; drives Container Runtime Interface (CRI)}} \\
     \mathbf{\text{Worker Node}} & \mathbf{\texttt{kube-proxy}} & \text{Maintains iptables/IPVS service packet forwarding rules} \\
     \mathbf{\text{Worker Node}} & \mathbf{\text{CRI Runtime (containerd)}} & \text{Pulls container images, manages cgroups/namespaces} \\
     \hline
     \end{array}$$
   - **Reconciliation Invariant:**
     $$\mathbf{\text{Loop: } \text{Observe Actual State}} \longrightarrow \mathbf{\text{Compare with Desired State}} \longrightarrow \mathbf{\text{Execute Mutations to Converge!}}$$
2. **Slide 2 (`ordering`):** Provide 5 steps of `kubectl apply -f deployment.yaml`: (1) `kubectl` sends HTTP POST to `kube-apiserver`, which authenticates request and writes Deployment object to `etcd`, (2) `DeploymentController` (in controller-manager) detects new Deployment and creates a `ReplicaSet` object with 3 Pod specifications, (3) `kube-scheduler` detects 3 unassigned Pods (`nodeName: ""`), evaluates node CPU/RAM capacities, and writes node assignments back to apiserver, (4) `kubelet` on assigned worker nodes detects newly scheduled Pods via apiserver watch API, (5) `kubelet` instructs local CRI (`containerd`) to pull container image, create cgroups/namespaces, and launch the Pod containers!
3. **Slide 3 (`matching`):** Pair 4 concepts (`kube-apiserver`, `etcd`, `kube-scheduler`, `kubelet`) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of etcd. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on why only apiserver talks to etcd: In Kubernetes cluster design, why is `kube-apiserver` the ONLY component permitted to communicate directly with `etcd`, while all other components (scheduler, controllers, kubelets) are strictly prohibited from touching `etcd`? (If multiple independent distributed components executed concurrent raw read/write queries directly against `etcd`, **data validation logic, admission webhooks, RBAC authorization, and optimistic locking mechanisms would be bypassed, resulting in schema corruption, race conditions, and split-brain states; `kube-apiserver` acts as a single centralized mediator and gatekeeper that enforces schema validation, mutation admission controllers, role-based access control [RBAC], and optimistic concurrency control [using `resourceVersion` tags] before writing any state change into `etcd`**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "kubernetes_control_plane_architecture_and_worker_nodes",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Kubernetes Cluster Architecture (Kelsey Hightower; Joe Beda)**\n• **Control Plane vs Worker Node Hierarchy:**\n$$\n\\begin{array}{|l|l|l|}\n\\hline\n\\textbf{Cluster Plane} & \\textbf{Component} & \\textbf{Core Distributed System Role} \\\\\n\\hline\n\\mathbf{\\text{Control Plane}} & \\mathbf{\\texttt{kube-apiserver}} & \\mathbf{\\text{Central REST Gateway; ONLY component allowed to write to etcd!}} \\\\\n\\mathbf{\\text{Control Plane}} & \\mathbf{\\texttt{etcd}} & \\mathbf{\\text{Distributed consistent KV store governed by Raft consensus}} \\\\\n\\mathbf{\\text{Control Plane}} & \\mathbf{\\texttt{kube-scheduler}} & \\text{Filters/scores nodes and binds unscheduled Pods to worker nodes} \\\\\n\\mathbf{\\text{Control Plane}} & \\mathbf{\\texttt{kube-controller-manager}} & \\mathbf{\\text{Runs reconciliation loops driving Actual State } \\to \\text{ Desired State}} \\\\\n\\hline\n\\mathbf{\\text{Worker Node}} & \\mathbf{\\texttt{kubelet}} & \\mathbf{\\text{Node agent driving Container Runtime Interface (CRI) for Pod execution}} \\\\\n\\mathbf{\\text{Worker Node}} & \\mathbf{\\texttt{kube-proxy}} & \\text{Manages iptables / IPVS packet forwarding rules for Services} \\\\\n\\mathbf{\\text{Worker Node}} & \\mathbf{\\text{CRI Engine (containerd)}} & \\text{Pulls images and initializes isolated cgroups/namespaces} \\\\\n\\hline\n\\end{array}\n$$\n• **The Declarative Reconciliation Invariant:**\n$$\n\\mathbf{\\text{Observe Actual State}} \\xrightarrow{\\text{Diff}} \\mathbf{\\text{Desired State (etcd)}} \\implies \\mathbf{\\text{Mutate Cluster to Converge State!}}\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps executed across a Kubernetes cluster during the deployment of a 3-replica application (kubectl apply -f deployment.yaml).",
      "orderItems": [
        "kubectl dispatches HTTP POST with deployment manifest to kube-apiserver, which authenticates and saves it to etcd",
        "DeploymentController inside kube-controller-manager detects new deployment and creates a ReplicaSet with 3 Pod manifests",
        "kube-scheduler detects 3 unscheduled Pods, filters worker nodes by capacity/affinity, and binds them to selected nodes via apiserver",
        "The kubelet agent on each assigned worker node detects its newly scheduled Pods via the apiserver watch stream",
        "kubelet commands the local CRI (containerd) to pull container images, set up network namespaces, and launch the Pod containers"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Kubernetes Architecture Component to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "kube-apiserver", "right": "Stateless REST API gateway validating, mutating, and persisting cluster object state" },
        { "left": "etcd Cluster", "right": "Raft-backed distributed key-value store holding the single source of truth for cluster state" },
        { "left": "kube-scheduler", "right": "Decision engine scoring worker node capacities and constraints to assign pending pods" },
        { "left": "kubelet Agent", "right": "Node supervisor registering the node, executing PodSpecs via CRI, and reporting health status" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The distributed Raft-based key-value store that acts as the single source of truth for Kubernetes cluster state is ___.",
      "blankAnswer": "etcd",
      "blankDistractors": ["redis", "consul", "zookeeper"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why is the kube-apiserver strictly designed as the ONLY component allowed to communicate directly with etcd in a Kubernetes cluster?",
      "options": [
        { "text": "If multiple independent cluster daemons (such as the scheduler, controllers, and thousands of worker node kubelets) were permitted to read and write directly to etcd, central validation, schema migrations, Admission Webhooks, and RBAC authorization policies would be bypassed; this would cause catastrophic race conditions, concurrent write conflicts, and schema corruption; the kube-apiserver acts as a single authoritative gatekeeper enforcing authentication, schema validation, mutating/validating webhooks, and optimistic concurrency control (via resourceVersion tracking) before any data mutation is committed to etcd", "isCorrect": true, "explanation": "Correct! This is Brendan Burns and Joe Beda's foundational design decision for Kubernetes (*Kubernetes: Up and Running* Chapter 2). 1. **Why Direct Access to etcd Is Dangerous:** - `etcd` is a simple, low-level distributed key-value store. It does NOT understand Kubernetes schemas, PodSpecs, or RBAC security! - If a `kubelet` could write directly to `etcd`: A compromised worker node could overwrite cluster certificates or grant itself root cluster-admin privileges! 2. **The kube-apiserver Gatekeeper Role:** - Every request must pass through a strict, multi-stage pipeline inside `kube-apiserver`: - **Step 1: Authentication** (TLS certs, Webhook tokens). - **Step 2: Authorization** (RBAC: Does this user have permission to delete Pods?). - **Step 3: Mutating Webhooks** (Injecting sidecars/labels). - **Step 4: Schema Validation** (Are the CPU/RAM numbers valid integers?). - **Step 5: Validating Webhooks** (Security policies like OPA Gatekeeper). - **Step 6: Optimistic Concurrency Control** (Checks `resourceVersion` to prevent lost updates!). - Only after passing ALL checks does the apiserver execute `etcd.put()`. 3. **The Result:** Rock-solid cluster security, data consistency, and architectural cleanliness!" },
        { "text": "Because etcd can only be installed on single-core computers", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because other Kubernetes components are written in Python and cannot talk to etcd", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because direct etcd communication causes hardware hard drives to overheat", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
