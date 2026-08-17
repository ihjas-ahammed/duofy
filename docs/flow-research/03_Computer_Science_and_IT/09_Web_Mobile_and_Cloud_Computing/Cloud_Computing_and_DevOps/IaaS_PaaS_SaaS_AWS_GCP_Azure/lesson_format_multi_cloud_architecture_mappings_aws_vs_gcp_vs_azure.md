# Duofy Reusable Lesson Format: Multi-Cloud Architecture (AWS, GCP, and Azure Service Mappings)

**Target Topic:** `03_Computer_Science_and_IT / 09_Web_Mobile_and_Cloud_Computing / Cloud_Computing_and_DevOps / IaaS_PaaS_SaaS_AWS_GCP_Azure`  
**Lesson Format Type:** `multi_cloud_architecture_mappings_aws_vs_gcp_vs_azure`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through multi-cloud architectural equivalencies, interoperability matrices, and vendor taxonomy crosswalks across the Big Three cloud providers (Amazon Web Services [AWS], Google Cloud Platform [GCP], and Microsoft Azure): master the **Multi-Cloud Service Mapping Crosswalk** across Compute (**AWS EC2** $\equiv$ **GCP Compute Engine** $\equiv$ **Azure Virtual Machines**), Object Storage (**AWS S3** $\equiv$ **GCP Cloud Storage** $\equiv$ **Azure Blob Storage**), Serverless FaaS (**AWS Lambda** $\equiv$ **GCP Cloud Functions** $\equiv$ **Azure Functions**), Managed Kubernetes (**AWS EKS** $\equiv$ **GCP GKE** $\equiv$ **Azure AKS**), Managed Relational Databases (**AWS RDS** $\equiv$ **GCP Cloud SQL** $\equiv$ **Azure SQL Database**), and Identity / Access Management (**AWS IAM** $\equiv$ **GCP Cloud IAM** $\equiv$ **Microsoft Entra ID / Azure AD**); analyze multi-cloud networking constructs (AWS VPC vs Azure VNet vs GCP VPC); and evaluate multi-cloud strategies to prevent vendor lock-in.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Big Three Multi-Cloud Equivalency Matrix (AWS vs GCP vs Azure) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Translation of a 3-Tier Enterprise Web Architecture from AWS to GCP and Azure Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Cloud Capability / Service & Provider Equivalent (AWS, GCP, Azure) Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Serverless FaaS Compute Service in Google Cloud Equivalent to AWS Lambda Is Cloud ___ (Functions) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Multi-Cloud Enterprise Strategy: Evaluating the Trade-offs of Cloud-Agnostic Abstraction Layers Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Multi-Cloud Architecture (Erl 2013; Cloud Native Architecture):
   - **The Big Three Multi-Cloud Equivalency Crosswalk:**
     $$\begin{array}{|l|l|l|l|}
     \hline
     \textbf{Cloud Capability} & \textbf{Amazon Web Services (AWS)} & \textbf{Google Cloud Platform (GCP)} & \textbf{Microsoft Azure} \\
     \hline
     \mathbf{\text{Virtual Compute (VM)}} & \mathbf{\text{Amazon EC2}} & \mathbf{\text{Compute Engine (GCE)}} & \mathbf{\text{Azure Virtual Machines}} \\
     \mathbf{\text{Object Storage}} & \mathbf{\text{Amazon S3}} & \mathbf{\text{Cloud Storage (GCS)}} & \mathbf{\text{Azure Blob Storage}} \\
     \mathbf{\text{Serverless FaaS}} & \mathbf{\text{AWS Lambda}} & \mathbf{\text{Cloud Functions}} & \mathbf{\text{Azure Functions}} \\
     \mathbf{\text{Managed Kubernetes}} & \mathbf{\text{Amazon EKS}} & \mathbf{\text{Google Kubernetes Engine (GKE)}} & \mathbf{\text{Azure Kubernetes Service (AKS)}} \\
     \mathbf{\text{Managed RDBMS}} & \mathbf{\text{Amazon RDS / Aurora}} & \mathbf{\text{Cloud SQL / Spanner}} & \mathbf{\text{Azure SQL Database}} \\
     \mathbf{\text{Identity \& Auth}} & \mathbf{\text{AWS IAM}} & \mathbf{\text{Google Cloud IAM}} & \mathbf{\text{Microsoft Entra ID (Azure AD)}} \\
     \hline
     \end{array}$$
   - **Networking Invariant:** AWS and Azure require subnet assignment to a specific Availability Zone; GCP VPCs are global across all regions!
2. **Slide 2 (`ordering`):** Provide 5 steps of migrating an AWS 3-tier architecture to GCP: (1) AWS Route 53 DNS and CloudFront CDN map to GCP Cloud DNS and Cloud CDN, (2) AWS Application Load Balancer (ALB) maps to GCP Cloud Load Balancing, (3) AWS EC2 Auto Scaling web servers map to GCP Compute Engine Managed Instance Groups (MIGs), (4) AWS RDS PostgreSQL maps to GCP Cloud SQL for PostgreSQL, (5) AWS S3 static media bucket maps to GCP Cloud Storage (GCS) bucket!
3. **Slide 3 (`matching`):** Pair 4 concepts (AWS Lambda $\equiv$ GCP Cloud Functions $\equiv$ Azure Functions, AWS S3 $\equiv$ GCS $\equiv$ Blob Storage, AWS EKS $\equiv$ GKE $\equiv$ AKS, AWS IAM $\equiv$ Cloud IAM $\equiv$ Entra ID) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Functions. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on cloud-agnostic abstraction tradeoffs: In enterprise cloud architecture, what is the major architectural and financial trade-off of designing a strictly \"cloud-agnostic\" architecture (restricting software to the lowest common denominator e.g. self-managed PostgreSQL on raw VMs across AWS/GCP) to prevent vendor lock-in? (While a strictly cloud-agnostic architecture enables easier migration between cloud providers, **it forces the engineering organization to sacrifice high-value native managed cloud capabilities (such as AWS Aurora global multi-region replication, GCP BigQuery serverless analytics, and Azure Cosmos DB multi-master write consistency), significantly inflating operational maintenance overhead, infrastructure maintenance engineering costs, and development time to maintain parity across providers**; smart architects balance portable containers [Docker/Kubernetes] with selective high-leverage managed cloud services).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "multi_cloud_architecture_mappings_aws_vs_gcp_vs_azure",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: The Multi-Cloud Architecture Crosswalk (AWS, GCP, Azure)**\n• **Core Cloud Service Mapping Matrix:**\n$$\n\\begin{array}{|l|l|l|l|}\n\\hline\n\\textbf{Service Domain} & \\textbf{Amazon Web Services (AWS)} & \\textbf{Google Cloud Platform (GCP)} & \\textbf{Microsoft Azure} \\\\\n\\hline\n\\mathbf{\\text{IaaS Virtual Machines}} & \\mathbf{\\text{Amazon EC2}} & \\mathbf{\\text{Compute Engine (GCE)}} & \\mathbf{\\text{Azure Virtual Machines}} \\\\\n\\mathbf{\\text{Object Storage (REST)}} & \\mathbf{\\text{Amazon S3}} & \\mathbf{\\text{Cloud Storage (GCS)}} & \\mathbf{\\text{Azure Blob Storage}} \\\\\n\\mathbf{\\text{Serverless FaaS}} & \\mathbf{\\text{AWS Lambda}} & \\mathbf{\\text{Cloud Functions}} & \\mathbf{\\text{Azure Functions}} \\\\\n\\mathbf{\\text{Managed Kubernetes}} & \\mathbf{\\text{Amazon EKS}} & \\mathbf{\\text{Google Kubernetes Engine (GKE)}} & \\mathbf{\\text{Azure Kubernetes Service (AKS)}} \\\\\n\\mathbf{\\text{Managed SQL Engine}} & \\mathbf{\\text{Amazon RDS / Aurora}} & \\mathbf{\\text{Cloud SQL / Cloud Spanner}} & \\mathbf{\\text{Azure SQL Database}} \\\\\n\\mathbf{\\text{Enterprise Identity}} & \\mathbf{\\text{AWS IAM}} & \\mathbf{\\text{Google Cloud IAM}} & \\mathbf{\\text{Microsoft Entra ID (Azure AD)}} \\\\\n\\hline\n\\end{array}\n$$\n• **VPC Networking Invariant:**\n  - AWS / Azure Subnets are bound to a single Availability Zone (AZ);\n  - GCP Virtual Private Clouds (VPC) are **Global** across all worldwide regions by default!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the architectural service translation steps when migrating an AWS 3-tier web application to Google Cloud Platform (GCP).",
      "orderItems": [
        "DNS and Edge Layer: Migrate AWS Route 53 and CloudFront CDN to GCP Cloud DNS and Cloud CDN",
        "Ingress Load Balancing: Translate AWS Application Load Balancer (ALB) to GCP Global External HTTPS Load Balancer",
        "Compute Layer: Migrate AWS EC2 Auto Scaling Groups to GCP Compute Engine Managed Instance Groups (MIGs)",
        "Database Layer: Migrate AWS Aurora / RDS PostgreSQL to GCP Cloud SQL for PostgreSQL",
        "Storage Layer: Transfer static media assets from Amazon S3 buckets to Google Cloud Storage (GCS) buckets"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Cloud Capability to its Big Three Provider Service Triad.",
      "matchPairs": [
        { "left": "Serverless FaaS", "right": "AWS Lambda | GCP Cloud Functions | Azure Functions" },
        { "left": "Object Storage", "right": "AWS S3 | GCP Cloud Storage | Azure Blob Storage" },
        { "left": "Managed Kubernetes", "right": "AWS EKS | GCP GKE | Azure AKS" },
        { "left": "Enterprise Identity & IAM", "right": "AWS IAM | GCP Cloud IAM | Microsoft Entra ID" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The Google Cloud Platform serverless FaaS service equivalent to AWS Lambda is Cloud ___.",
      "blankAnswer": "Functions",
      "blankDistractors": ["Run", "Compute", "Storage"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "In enterprise multi-cloud strategy, what is the primary operational trade-off of designing a strictly 'cloud-agnostic' application (avoiding all proprietary cloud features to prevent vendor lock-in)?",
      "options": [
        { "text": "Designing a strictly cloud-agnostic architecture restricts an enterprise to the lowest common denominator of cloud capabilities (such as running self-managed databases and generic VMs across providers); while this maximizes portability, it forces the engineering organization to sacrifice powerful high-leverage cloud-native managed capabilities (such as Amazon Aurora global multi-region storage, GCP BigQuery serverless analytics, and Azure Cosmos DB multi-master writes), significantly increasing operational maintenance overhead, DevOps team headcount costs, and engineering complexity", "isCorrect": true, "explanation": "Correct! This is Gregor Hohpe's defining thesis in *The Software Architect Elevator: Cloud Strategy*. 1. **The 'Lowest Common Denominator' Trap:** - If an enterprise mandates: *\"Our code must run identically on AWS, GCP, and Azure without modification\"*: - You CANNOT use AWS DynamoDB (proprietary). - You CANNOT use GCP BigQuery (proprietary). - You CANNOT use AWS Aurora Serverless. - You are forced to deploy raw Linux VMs and manage your own PostgreSQL clusters, Kafka clusters, and Redis shards manually! 2. **The Hidden Cost:** - You saved yourself from *vendor lock-in*, BUT you created massive **operational lock-in**! - Your DevOps team must now spend hundreds of hours managing backups, failovers, OS patches, and monitoring on raw VMs that AWS/GCP would have handled automatically for pennies! 3. **The Recommended Hybrid Strategy:** - Package application logic in portable Docker containers / Kubernetes (GKE/EKS). - Standardize with Infrastructure as Code (Terraform). - But **leverage high-value managed cloud services (like S3/GCS object storage and RDS/Cloud SQL)** where the operational ROI is overwhelmingly positive!" },
        { "text": "Because multi-cloud architectures are prohibited by the IEEE", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because cloud providers disable accounts that use Terraform", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because running on multiple clouds causes electromagnetic interference", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
