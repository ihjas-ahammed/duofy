# Key to Flow: CI/CD Pipelines & DevOps (Trunk-Based CI, Blue-Green/Canary, & DORA Metrics)

**Subject Area:** `03_Computer_Science_and_IT / 07_Software_Engineering_and_Architecture / Software_Testing_and_Quality_Assurance / CI_CD_Pipelines`

---

## 📌 Core Concept & Mental Model
**Trunk-Based Fast-Feedback Automation (Continuous Integration CI), Release-Ready Artifact Promotion with Gated Deployment (Continuous Delivery vs Continuous Deployment), Zero-Downtime Traffic Routing Strategies (Blue-Green Switch, Canary $1\% \to 100\%$ Traffic Shifting, Kubernetes Rolling Updates), Declarative Reconciliation (GitOps), and High-Performance Engineering Telemetry (The 4 DORA Metrics: Deployment Frequency, Lead Time for Changes, Change Failure Rate, & MTTR)** govern modern automated release engineering (Jez Humble & David Farley 2010 *Continuous Delivery*; Nicole Forsgren, Jez Humble, Gene Kim 2018 *Accelerate*; Martin Fowler *Continuous Integration*; Gene Kim et al. *The DevOps Handbook*):
* **1. Continuous Integration (CI) & Trunk-Based Development:**
  - Developers merge small code increments into `main`/trunk multiple times per day (avoiding long-lived feature branch merge hell).
  - Every push triggers an automated build pipeline:
    $$\mathbf{\text{Git Push}} \to \mathbf{\text{Static Analysis/Lint}} \to \mathbf{\text{Compile}} \to \mathbf{\text{Unit Tests (ms)}} \to \mathbf{\text{Integration Tests}} \to \mathbf{\text{Immutable Docker OCI Image Digest}}$$
  - *The 10-Minute Rule:* The automated pipeline must provide definitive pass/fail feedback in **$<10\text{ minutes}$**!
* **2. Continuous Delivery (CD) vs Continuous Deployment:**
  - **Continuous Delivery:** Automated pipeline creates a release-ready artifact deployed automatically to Staging; production deployment is triggered via a **manual one-click business approval gate**.
  - **Continuous Deployment:** Every commit that passes the automated pipeline is **automatically deployed straight to production with ZERO human intervention**.
* **3. Zero-Downtime Deployment Strategies:**
  - **Blue-Green Deployment:** Two identical environments (Blue = Live Production v1.0, Green = New Staging v2.0). Router flips $100\%$ traffic instantly from Blue to Green. Rollback is instant by flipping the router back.
  - **Canary Deployment:** Routes a tiny fraction of live user traffic ($1\% \to 5\% \to 25\% \to 100\%$) to new canary instances while monitoring APM metrics (Prometheus error rates, P99 latency). Auto-rolls back if error budget burns.
  - **Rolling Update:** Gradually replaces old Pods/VMs with new versions with configured `maxSurge` and `maxUnavailable` (Zero extra hardware cost).
* **4. The 4 DORA Performance Metrics (*Accelerate* - Forsgren, Humble, Kim):**
  $$\begin{array}{|l|l|l|l|}
  \hline
  \textbf{DORA Metric} & \textbf{Measurement Dimension} & \textbf{Elite Performance} & \textbf{Low Performance} \\
  \hline
  \mathbf{\text{1. Deployment Frequency (DF)}} & \text{How often code is deployed to prod} & \mathbf{\text{Multiple deploys per day}} & \text{Once per 6 months} \\
  \mathbf{\text{2. Lead Time for Changes (LTTC)}} & \text{Time from code commit to running in prod} & \mathbf{\text{Less than 1 hour}} & \text{1 to 6 months} \\
  \mathbf{\text{3. Change Failure Rate (CFR)}} & \text{\% of prod deployments causing outages} & \mathbf{0 - 15\%} & 46 - 60\% \\
  \mathbf{\text{4. Time to Restore Service (MTTR)}} & \text{Time to recover from a production outage} & \mathbf{\text{Less than 1 hour}} & \text{1 week to 1 month} \\
  \hline
  \end{array}$$

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The CI/CD Pipeline Spectrum
* Source Flow $\to$ Trunk-Based Development (Merging daily into main).
* Automated CI $\to$ Compile $\to$ Unit Tests $\to$ Security Scan $\to$ Immutable Docker Digest.
* Delivery Model $\to$ Continuous Delivery (One-Click Gate) vs Continuous Deployment (Automated).
* Release Strategy $\to$ Blue-Green (Instant Flip) vs Canary (Gradual Traffic).
* Performance Measurement $\to$ 4 DORA Metrics (Throughput vs Stability).

### 2. Top Recommended Resources
* **The Foundation Book:** *Continuous Delivery: Reliable Software Releases through Build, Test, and Deployment Automation* (Jez Humble & David Farley, Addison-Wesley 2010).
* **The Scientific Benchmark:** *Accelerate: The Science of Lean Software and DevOps* (Nicole Forsgren, Jez Humble, Gene Kim, IT Revolution 2018).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you distinguish Continuous Delivery (manual business gate) from Continuous Deployment (zero human gate)?
- [ ] Can you diagram a Blue-Green deployment vs a Canary deployment?
- [ ] Can you list and define the 4 DORA metrics and explain the trade-off between throughput and stability?
- [ ] Can you trace how an immutable Docker image digest prevents "works on my machine" bugs across staging and prod?
