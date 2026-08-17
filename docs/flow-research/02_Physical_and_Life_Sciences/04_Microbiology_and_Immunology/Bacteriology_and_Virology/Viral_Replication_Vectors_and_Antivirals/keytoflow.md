# Key to Flow: Viral Replication, Vectors, and Antivirals (Virology)

**Subject Area:** `02_Physical_and_Life_Sciences / 04_Microbiology_and_Immunology / Bacteriology_and_Virology / Viral_Replication_Vectors_and_Antivirals`

---

## 📌 Core Concept & Mental Model
**Viral Replication Strategies, Vector Engineering, and Antiviral Pharmacology** analyze how obligate intracellular molecular parasites hijack cellular machinery, how engineered viral capsids deliver therapeutic genetic payloads, and how small-molecule drugs selectively arrest viral enzymes (David Baltimore 1975 Nobel, Gertrude Elion 1988 Nobel):
* **The Baltimore Classification Scheme (Groups I–VII):**
  - Unifying principle: All viral genomes must generate **positive-sense messenger RNA ((+)mRNA)** readable by host ribosomes!
    $$\begin{array}{|c|l|l|l|}
    \hline
    \textbf{Group} & \textbf{Genome Type} & \textbf{mRNA Synthesis Pathway} & \textbf{Clinical Examples} \\
    \hline
    \textbf{I} & \text{dsDNA} & \text{Host/viral RNA Pol II} \to \text{(+)mRNA} & \text{Herpesviridae (HSV, CMV), Adenoviridae, Poxviridae} \\
    \textbf{II} & \text{ssDNA} & \text{Host DNA Pol} \to \text{dsDNA} \to \text{(+)mRNA} & \text{Parvoviridae (Parvovirus B19)} \\
    \textbf{III} & \text{dsRNA} & \text{Viral RdRP carries out transcription} & \text{Reoviridae (Rotavirus)} \\
    \textbf{IV} & \text{(+)ssRNA} & \mathbf{\text{Genome is directly infectious as mRNA}} & \text{Coronaviridae (SARS-CoV-2), Picornaviridae (Polio, HAV), Flaviviridae (HCV)} \\
    \textbf{V} & \text{(-)ssRNA} & \mathbf{\text{Must package viral RdRP in virion}} & \text{Orthomyxoviridae (Influenza), Rhabdoviridae (Rabies), Filoviridae (Ebola)} \\
    \textbf{VI} & \text{ssRNA-RT} & \text{Reverse Transcriptase} \to \text{dsDNA} \to \text{Integrase} & \text{Retroviridae (HIV-1, HIV-2, HTLV-1)} \\
    \textbf{VII} & \text{dsDNA-RT} & \text{dsDNA} \to \text{pgRNA (pre-genomic)} \xrightarrow{\text{RT}} \text{DNA} & \text{Hepadnaviridae (Hepatitis B Virus / HBV)} \\
    \hline
    \end{array}$$
* **Viral Vectors for Clinical Gene Therapy:**
  - **Adeno-Associated Virus (AAV):** Non-enveloped, non-integrating parvovirus ($4.7\text{ kb}$ capacity). Flanked by Inverted Terminal Repeats (**ITRs**). Persists as stable **nuclear episomes**; non-pathogenic with high tropism (e.g. AAV9 crosses blood-brain barrier for SMA/Zolgensma; AAV2 for retinal Luxturna).
  - **Lentivirus (LV) & Retrovirus:** Enveloped, integrating vectors derived from HIV-1 ($8-10\text{ kb}$ capacity). Integrates stably into host chromosomal DNA $\implies$ Permanent expression in dividing cells (e.g. CAR-T cell manufacturing).
  - **Adenovirus (AdV):** Large dsDNA ($36\text{ kb}$), non-integrating episomal vector (e.g. COVID-19 vaccines: Oxford/AstraZeneca ChAdOx1, J&J Ad26).
* **Antiviral Pharmacology Mechanisms:**
  - **HIV Combination Antiretroviral Therapy (cART):**
    - **NRTIs (Nucleoside/tide Reverse Transcriptase Inhibitors, e.g. AZT/Zidovudine, Tenofovir, Emtricitabine):** Lack a $3'\text{-OH}$ group; incorporated into growing cDNA chain to cause **obligate chain termination**.
    - **NNRTIs (Non-Nucleoside RTIs, e.g. Efavirenz, Nevirapine):** Allosteric non-competitive inhibitors of RT.
    - **Integrase Strand Transfer Inhibitors (INSTIs, e.g. Dolutegravir, Bictegravir):** Chelate catalytic $\text{Mg}^{2+}$ ions in the active site of HIV Integrase, blocking viral DNA insertion into host chromosome.
    - **Protease Inhibitors (PIs, e.g. Darunavir, Ritonavir; Paxlovid Nirmatrelvir for SARS-CoV-2 $\text{M}^{\text{pro}}$):** Inhibit viral aspartyl/cysteine proteases, blocking polyprotein processing $\implies$ Produces immature, non-infectious virions.
  - **Influenza Antivirals:**
    - **Neuraminidase Inhibitors (Oseltamivir/Tamiflu, Zanamivir):** Transition-state sialic acid analogs inhibiting neuraminidase $\implies$ Newly budded virions remain tethered to cell surface sialic acid, preventing viral dissemination.
    - **Cap-Dependent Endonuclease Inhibitor (Baloxavir marboxil):** Halts viral cap-snatching!

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The (+)mRNA Central Hub & Vector Decision Matrix
* Place (+)mRNA at the center of your page and draw the 7 Baltimore arrows converging on it.
* Map antiviral drugs directly onto the viral life cycle step they interrupt.

### 2. Top Recommended Resources
* **The Virology Authority:** *Principles of Virology* by Jane Flint, Vincent Racaniello, Glenn Rall, Theodora Hatziioannou (ASM Press).
* **Comprehensive Reference:** *Fields Virology* by Peter Howley & David Knipe (LWW).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you determine whether a virus must package its own RNA-dependent RNA polymerase (RdRP) in the virion given its Baltimore group?
- [ ] Can you select the optimal gene therapy vector (AAV vs Lentivirus) based on target tissue dividing status and insert size?
- [ ] Can you explain why NRTIs cause obligate chain termination in viral reverse transcription?
- [ ] Can you diagram the neuraminidase inhibition mechanism of oseltamivir in influenza infections?
