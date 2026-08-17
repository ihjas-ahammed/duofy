# Duofy Reusable Lesson Format: Kubernetes Networking (ClusterIP, NodePort, and Ingress)

**Target Topic:** `03_Computer_Science_and_IT / 09_Web_Mobile_and_Cloud_Computing / Cloud_Computing_and_DevOps / Containerization_Docker_Kubernetes`  
**Lesson Format Type:** `kubernetes_service_networking_clusterip_nodeport_and_ingress`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through cluster IP routing, software-defined overlay networking, service abstraction, and Layer 7 ingress controllers in Kubernetes (Kelsey Hightower et al. *Kubernetes: Up and Running*; Tim Hockin Kubernetes Networking Architecture; Marko Lukša *Kubernetes in Action*): master the foundational **Kubernetes Pod Networking IP-per-Pod Invariant** (every Pod gets its own real unique IP address; all Pods can communicate with all other Pods across nodes without NAT), master the **4 Kubernetes Service Types**: **1. `ClusterIP`** (default internal virtual IP accessible only within the cluster, load-balanced across matching Pod endpoints via `kube-proxy` iptables/IPVS rules), **2. `NodePort`** (exposes a dedicated high port across range `30000-32767` on the physical IP of every worker node in the cluster), **3. `LoadBalancer`** (integrates with cloud provider APIs to provision an external Layer 4 cloud load balancer routing traffic to NodePorts), and **4. `Ingress Controller`** (an in-cluster reverse proxy e.g. NGINX, Envoy, Traefik providing Layer 7 path-based routing `/api`, host-based routing `app.example.com`, and centralized SSL/TLS termination on a single external IP address).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Kubernetes Service Ingress Stack Diagram (ClusterIP $\to$ NodePort $\to$ LoadBalancer $\to$ Ingress) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Packet Traversal from an External HTTPS Request Through Ingress to Target Pod Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Kubernetes Networking Primitive / Service Type & Technical Scope Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Default Kubernetes Service Type Providing an Internal Virtual IP for Inter-Pod Communication Is ___ (ClusterIP) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Architectural Contrast: Why an Ingress Controller Is Economically Superior to 50 Separate Cloud LoadBalancers Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State K8s Networking (Hockin 2019; Hightower 2022):
   - **Service Types Hierarchy:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Service Type} & \textbf{Network Exposure} & \textbf{Port Range / Routing} & \textbf{Primary Use Case} \\
     \hline
     \mathbf{\texttt{ClusterIP}} & \mathbf{\text{Internal cluster ONLY}} & \text{Virtual VIP + port (e.g. 10.96.0.1:80)} & \mathbf{\text{Backend microservices, DBs}} \\
     \mathbf{\texttt{NodePort}} & \text{External via Node IPs} & \mathbf{\text{High port on EVERY node: } \mathbf{30000-32767}} & \text{Direct node access, debugging} \\
     \mathbf{\texttt{LoadBalancer}} & \text{External Cloud Provider} & \text{Provisions dedicated AWS NLB / GCP LB} & \text{Layer 4 TCP/UDP ingress} \\
     \mathbf{\texttt{Ingress}} & \mathbf{\text{Layer 7 HTTP / HTTPS}} & \mathbf{\text{Host/Path routing + SSL on 1 IP}} & \mathbf{\text{Production multi-service web routing}} \\
     \hline
     \end{array}$$
   - **The Pod IP Invariant:** Pod IPs are ephemeral and change on every restart $\implies$ **Services provide a stable DNS name and VIP** that forwards traffic to live endpoints matching label selectors (`app: frontend`)!
2. **Slide 2 (`ordering`):** Provide 5 steps of external HTTPS traffic routing: (1) client browser issues HTTPS GET `https://example.com/api/orders`, (2) DNS resolves domain to Cloud Load Balancer external IP, forwarding request to Ingress Controller pod on port 443, (3) Ingress Controller (NGINX/Envoy) terminates TLS and inspects HTTP path `/api/orders`, (4) Ingress routes request to `orders-service` ClusterIP, (5) `kube-proxy` iptables rules load-balance packet across healthy backend `orders-pod` instances!
3. **Slide 3 (`matching`):** Pair 4 concepts (ClusterIP, NodePort, LoadBalancer, Ingress Controller) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of ClusterIP. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on Ingress vs LoadBalancer economics: In a production Kubernetes cluster hosting 50 distinct microservices, why is deploying a single Ingress Controller (e.g. NGINX/Envoy Ingress) vastly superior in cost and architecture compared to creating 50 separate `type: LoadBalancer` Services? (Creating 50 separate `type: LoadBalancer` Services calls the cloud provider's API to **provision 50 independent cloud load balancers (e.g. 50 AWS ALBs/NLBs), incurring massive monthly cloud infrastructure costs (~$1,200+/month) and exhausting cloud provider elastic IP quotas**; **an Ingress Controller provisions exactly ONE cloud load balancer on a single public IP address, routing traffic intelligently to all 50 internal `ClusterIP` microservices using Layer 7 URL paths (e.g. `/users`, `/checkout`) and domain hostnames while centralizing SSL/TLS certificate termination**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "kubernetes_service_networking_clusterip_nodeport_and_ingress",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Kubernetes Networking \\& Service Ingress Stack (Tim Hockin)**\n• **Kubernetes Service Exposure Taxonomy:**\n$$\n\\begin{array}{|l|l|l|l|}\n\\hline\n\\textbf{Service Primitive} & \\textbf{Network Exposure Scope} & \\textbf{Routing \\& Port Mechanics} & \\textbf{Primary Architectural Role} \\\\\n\\hline\n\\mathbf{\\texttt{ClusterIP}} & \\mathbf{\\text{Internal Cluster ONLY}} & \\text{Stable Virtual VIP (e.g. 10.96.0.10:8080)} & \\mathbf{\\text{Inter-service microservice communication}} \\\\\n\\mathbf{\\texttt{NodePort}} & \\text{External via Worker Node IPs} & \\mathbf{\\text{Static port allocated on ALL nodes: } 30000-32767} & \\text{Low-level external access / testing} \\\\\n\\mathbf{\\texttt{LoadBalancer}} & \\text{External Layer 4 Network} & \\text{Provisions dedicated Cloud Provider LB (AWS/GCP)} & \\text{Dedicated TCP/UDP external ingress} \\\\\n\\mathbf{\\texttt{Ingress}} & \\mathbf{\\text{Layer 7 HTTP / HTTPS}} & \\mathbf{\\text{Path/Host-based routing + SSL Termination on 1 IP}} & \\mathbf{\\text{Production enterprise web traffic routing}} \\\\\n\\hline\n\\end{array}\n$$\n• **The Ephemeral Pod vs Stable Service Law:**\n$$\n\\mathbf{\\text{Pod IPs are Ephemeral (Change on restart)}} \\xrightarrow{\\text{Stabilized By}} \\mathbf{\\text{Service Stable DNS Name (e.g. auth-service.default.svc.cluster.local)}}\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential network packet flow when an external user accesses an internal microservice via https://app.example.com/checkout.",
      "orderItems": [
        "User browser performs DNS lookup for app.example.com, connecting to the cloud external load balancer IP on port 443",
        "Cloud Load Balancer forwards encrypted TLS traffic to the Ingress Controller Pod (NGINX/Envoy) running in the cluster",
        "The Ingress Controller decrypts TLS certificates and parses the Layer 7 HTTP request headers and URL path (/checkout)",
        "The Ingress routing table maps /checkout to the internal ClusterIP service 'checkout-service' on port 80",
        "kube-proxy iptables / IPVS packet rules perform destination NAT, forwarding the TCP packet to a healthy backend checkout Pod IP"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Kubernetes Networking Primitive to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "ClusterIP Service", "right": "Default internal virtual IP load-balancing traffic across pods matching label selectors" },
        { "left": "NodePort Service", "right": "Exposes a service on an identical high port (30000-32767) across every worker node IP" },
        { "left": "LoadBalancer Service", "right": "Provisions a cloud-provider external Layer 4 load balancer routing traffic to NodePorts" },
        { "left": "Ingress Controller", "right": "Layer 7 reverse proxy routing HTTP/HTTPS traffic by host and URL path with SSL termination" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The default Kubernetes service type that provides an internal cluster-only virtual IP is ___.",
      "blankAnswer": "ClusterIP",
      "blankDistractors": ["NodePort", "LoadBalancer", "Ingress"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In a production Kubernetes cluster hosting 50 distinct microservices, why is deploying a single Ingress Controller (such as NGINX or Envoy) vastly superior in cost and architecture compared to creating 50 separate 'type: LoadBalancer' Services?",
      "options": [
        { "text": "Creating 50 separate 'type: LoadBalancer' Services triggers API calls to the public cloud provider (AWS/GCP/Azure) to provision 50 distinct, dedicated cloud load balancers (e.g. 50 AWS NLBs/ALBs), incurring massive monthly infrastructure costs (exceeding $1,200+/month in cloud fees) and exhausting cloud elastic IP quotas; an Ingress Controller provisions exactly ONE cloud load balancer on a single public IP, using Layer 7 reverse proxy routing to direct incoming HTTP traffic to all 50 internal ClusterIP services based on URL paths (/users, /orders) and domain hostnames while centralizing SSL/TLS certificate management", "isCorrect": true, "explanation": "Correct! This is Kelsey Hightower and Tim Hockin's primary architectural justification for the Ingress resource in Kubernetes (*Kubernetes: Up and Running* Chapter 4). 1. **The 'type: LoadBalancer' Cost Explosion:** - In AWS: Each `type: LoadBalancer` provisions an **AWS Application Load Balancer (ALB)** or **Network Load Balancer (NLB)**. - Cost per ALB $= \\sim \\$25/\\text{month} + \\text{LCU fees} \\approx \\$35/\\text{month}$. - For 50 microservices: $50 \\times \\$35 = \\mathbf{\\$1,750/\\text{month (}\\$21,000/\\text{year)!}}$ - You also consume 50 public IPv4 addresses, which are scarce and expensive! 2. **The Ingress Controller Architectural Triumph:** - You create ONE Ingress Controller. - It provisions **ONE single cloud load balancer** on **ONE public IP** (Cost $= \\$35/\\text{month}$ total)! - Inside the cluster: The Ingress Controller (NGINX/Envoy) inspects incoming HTTP traffic: - `GET example.com/users` $\\to$ routes to `users-svc` (ClusterIP). - `GET example.com/orders` $\\to$ routes to `orders-svc` (ClusterIP). - `GET checkout.example.com` $\\to$ routes to `checkout-svc` (ClusterIP). - **Centralized SSL:** Let's Encrypt / Cert-Manager automatically manages TLS certs in one place! - **Result:** Saves thousands of dollars, simplifies DNS, and delivers enterprise Layer 7 routing!" },
        { "text": "Because Kubernetes can only run 3 services at a time", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Cloud LoadBalancers are prohibited from routing JSON data", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because Ingress Controllers convert all web traffic into WebSockets", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
