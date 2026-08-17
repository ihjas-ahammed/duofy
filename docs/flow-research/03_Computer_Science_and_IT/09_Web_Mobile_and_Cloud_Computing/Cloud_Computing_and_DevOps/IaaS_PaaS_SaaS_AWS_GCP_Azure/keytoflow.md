# Key to Flow: Cloud Computing Architecture (IaaS, PaaS, SaaS, & Multi-Cloud Services)

**Subject Area:** `03_Computer_Science_and_IT / 09_Web_Mobile_and_Cloud_Computing / Cloud_Computing_and_DevOps / IaaS_PaaS_SaaS_AWS_GCP_Azure`

---

## 📌 Core Concept & Mental Model
**Cloud Delivery Service Abstractions (NIST SP 800-145 IaaS vs PaaS vs SaaS vs Serverless FaaS), Security Ownership Division (The Shared Responsibility Model: Customer Security "IN the Cloud" vs Cloud Provider Security "OF the Cloud"), Storage Architecture Taxonomy (Block Storage [EBS/PD] vs Object Storage [S3/GCS] vs Shared File Storage [EFS/Filestore]), Multi-Cloud Service Equivalent Mapping (AWS vs GCP vs Azure Compute, Storage, Networking, and IAM), and High Availability Engineering (Multi-AZ Fault Domains, Geographic Regions, RTO [Recovery Time Objective], & RPO [Recovery Point Objective])** govern resilient enterprise cloud infrastructure (NIST Special Publication 800-145; AWS Well-Architected Framework; Thomas Erl *Cloud Computing: Concepts, Technology & Architecture*):
* **1. Cloud Service Delivery & Shared Responsibility Spectrum:**
  $$\begin{array}{|l|l|l|l|}
  \hline
  \textbf{Service Model} & \textbf{Customer Manages} & \textbf{Cloud Provider Manages} & \textbf{Canonical Examples} \\
  \hline
  \mathbf{\text{IaaS (Infrastructure)}} & \mathbf{\text{OS, Middleware, Runtime, Data, App}} & \text{Virtualization, Servers, Storage, DC Networking} & \mathbf{\text{AWS EC2, GCP GCE, Azure VMs}} \\
  \mathbf{\text{PaaS (Platform)}} & \mathbf{\text{Application Code \& Data ONLY}} & \text{OS, Patching, Runtime, Capacity Scaling, HW} & \mathbf{\text{AWS Elastic Beanstalk, App Engine}} \\
  \mathbf{\text{Serverless (FaaS)}} & \mathbf{\text{Stateless Event Functions \& Data}} & \text{Instant Scaling to Zero, Execution Sandboxes} & \mathbf{\text{AWS Lambda, Cloud Functions}} \\
  \mathbf{\text{SaaS (Software)}} & \mathbf{\text{User Access \& Configuration ONLY}} & \text{100\% of the entire application and infrastructure} & \mathbf{\text{Google Workspace, Microsoft 365}} \\
  \hline
  \end{array}$$
  - **The Shared Responsibility Law:** **Data classification and IAM Access Identity are 100% the customer's responsibility** across ALL cloud models!
* **2. Cloud Storage Taxonomy Matrix:**
  $$\begin{array}{|l|l|l|l|l|}
  \hline
  \textbf{Storage Class} & \textbf{Access Protocol} & \textbf{Attachment Topology} & \textbf{Durability \& IOPS} & \textbf{Primary Use Case} \\
  \hline
  \mathbf{\text{Block Storage}} & \text{Raw SCSI / NVMe blocks} & \mathbf{\text{1:1 Dedicated VM Mount}} & \text{Sub-ms, 100K+ IOPS (EBS/PD)} & \mathbf{\text{Databases, OS Boot Disks}} \\
  \mathbf{\text{Object Storage}} & \mathbf{\text{REST APIs (HTTP GET/PUT)}} & \mathbf{\text{N:All Global REST Clients}} & \mathbf{99.999999999\% \text{ (11 9's S3/GCS)}} & \mathbf{\text{Static Assets, Backups, Data Lakes}} \\
  \mathbf{\text{File Storage}} & \text{NFS v4 / SMB} & \mathbf{\text{N:M Concurrent Multi-Mount}} & \text{Shared posix file locks (EFS)} & \mathbf{\text{Legacy CMS, Shared configs}} \\
  \hline
  \end{array}$$
* **3. Multi-Cloud Provider Mapping:**
  $$\mathbf{\text{Compute: EC2 } \equiv \text{ Compute Engine } \equiv \text{ Azure VM} \quad \Big| \quad \text{Storage: S3 } \equiv \text{ Cloud Storage } \equiv \text{ Blob Storage} \quad \Big| \quad \text{FaaS: Lambda } \equiv \text{ Cloud Functions } \equiv \text{ Azure Functions}}$$
* **4. Cloud Resilience & Disaster Recovery:**
  - **Availability Zones (AZs):** Distinct physical data centers within a region isolated on separate power grids, cooling, and floodplains.
  - **RTO (Recovery Time Objective):** Maximum acceptable duration of downtime before system recovery.
  - **RPO (Recovery Point Objective):** Maximum acceptable data loss volume measured in elapsed time.

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Cloud Architecture Spectrum
* Governance Model $\to$ NIST 800-145 (IaaS $\to$ PaaS $\to$ FaaS $\to$ SaaS) $\to$ Shared Responsibility.
* Storage Slicing $\to$ Block (Raw IOPS) vs Object (11 9's Durability REST) vs File (NFS Concurrent).
* Provider Interoperability $\to$ AWS vs GCP vs Azure Canonical Service Crosswalk.
* Business Continuity $\to$ Multi-AZ Architecture $\to$ RTO / RPO Disaster Recovery Strategies.

### 2. Top Recommended Resources
* **The Official Standard:** *NIST SP 800-145: The NIST Definition of Cloud Computing* (Peter Mell & Timothy Grance).
* **The Architecture Framework:** *AWS Well-Architected Framework: Reliability & Security Pillars* (Amazon Web Services).
* **The Multi-Cloud Guide:** *Cloud Computing: Concepts, Technology & Architecture* (Thomas Erl et al., Prentice Hall).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you delineate customer vs provider responsibilities in the Shared Responsibility Model for IaaS vs PaaS?
- [ ] Can you select whether an application requires Block (EBS), Object (S3), or File (EFS) storage?
- [ ] Can you map an AWS architecture into GCP and Azure equivalents?
- [ ] Can you design a Multi-AZ active-passive failover meeting an RTO $< 5\text{ mins}$ and RPO $= 0$?
- [ ] Can you contrast cold start vs scaling dynamics in Serverless FaaS (AWS Lambda)?
