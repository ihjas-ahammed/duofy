# Duofy Reusable Lesson Format: GPCR Signaling Pathways (Gas, Gai, and Gaq)

**Target Topic:** `02_Physical_and_Life_Sciences / 03_Biological_Sciences / Cell_and_Molecular_Biology / Signal_Transduction_and_Cell_Cycle_Control`  
**Lesson Format Type:** `gpcr_signaling_pathways_gas_gai_and_gaq`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the molecular pharmacology and second messenger cascades of G-Protein Coupled Receptors (Martin Rodbell & Alfred Gilman, Nobel Prize 1994; Robert Lefkowitz & Brian Kobilka, Nobel Prize in Chemistry 2012): contrast the 3 canonical heterotrimeric G-protein $\alpha$-subunit branches (**$G_{\alpha s}$ Stimulatory: Adenylyl Cyclase $\to \text{cAMP} \to \text{PKA} \to \text{CREB}$**, **$G_{\alpha i}$ Inhibitory: blocks Adenylyl Cyclase $\to$ drops $\text{cAMP}$**, and **$G_{\alpha q}$: Phospholipase C-$\beta$ [$\text{PLC}\beta$] cleaving $\text{PIP}_2$ into $\text{IP}_3$ [releasing ER $\text{Ca}^{2+}$] and $\text{DAG}$ [activating $\text{PKC}$]**), examine bacterial toxin mechanisms (**Cholera Toxin** ADP-ribosylating $G_{\alpha s}$ vs **Pertussis Toxin** ADP-ribosylating $G_{\alpha i}$), and trace receptor desensitization by **GRK kinases and $\beta$-Arrestin**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | GPCR Triad ($G_{\alpha s}, G_{\alpha i}, G_{\alpha q}$) Signaling Cascades Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step $G_{\alpha q}$ Phospholipase C Second Messenger Cascade Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | G-Protein Subunit / Toxin & Downstream Effector Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Secondary Messenger Generating Enzyme Adenylate Cyclase Substrate Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Cholera Toxin ADP-Ribosylation Persistent Activation Mechanism Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State GPCR Heterotrimeric Signaling Pathways:
   - **Structure:** 7-transmembrane $\alpha$-helical domain coupled to heterotrimeric $G$-protein ($\alpha, \beta, \gamma$).
   - **The 3 Canonical G-Alpha Branches:**
     1. **$G_{\alpha s}$ (Stimulatory Pathway):**
        - Ligand binds GPCR $\to G_{\alpha s}$ exchanges $\text{GDP} \to \text{GTP} \to$ Activates **Adenylyl Cyclase (AC)**.
        - $\text{AC}$ converts $\text{ATP} \to \mathbf{\text{cAMP}}$ (cyclic AMP).
        - $\text{cAMP}$ binds regulatory subunits of **Protein Kinase A (PKA)**, freeing catalytic subunits to phosphorylate targets and enter nucleus to phosphorylate **CREB**.
     2. **$G_{\alpha i}$ (Inhibitory Pathway):**
        - Inhibits Adenylyl Cyclase $\implies$ Lowers intracellular $[\text{cAMP}]$ and dampens PKA activity.
     3. **$G_{\alpha q}$ (Phospholipase C / Calcium Pathway):**
        - $G_{\alpha q}\text{-GTP}$ activates **Phospholipase C-$\beta$ ($\text{PLC}\beta$)**, which hydrolyzes $\text{PIP}_2$ into two second messengers:
          - **$\text{IP}_3$ (Inositol 1,4,5-trisphosphate):** Water-soluble; diffuses to ER to open $\text{IP}_3$-gated $\text{Ca}^{2+}$ release channels $\implies$ Cytosolic $\text{Ca}^{2+}$ surge.
          - **DAG (Diacylglycerol):** Lipophilic; remains in plasma membrane, activating **Protein Kinase C (PKC)** in concert with $\text{Ca}^{2+}$.
   - **Bacterial Toxins:**
     - **Cholera Toxin:** ADP-ribosylates $G_{\alpha s}$, locking it permanently **ON** (constitutive cAMP $\to$ massive CFTR activation $\to$ secretory diarrhea).
     - **Pertussis Toxin:** ADP-ribosylates $G_{\alpha i}$, locking it permanently **OFF** (cannot inhibit AC $\to$ high cAMP).
2. **Slide 2 (`ordering`):** Provide 5 steps of the $G_{\alpha q}$ signaling pathway: (1) an extracellular agonist (e.g. Angiotensin II, Vasopressin $V_1$) binds a $G_q$-coupled GPCR, (2) the receptor acts as a GEF, causing $G_{\alpha q}$ to exchange GDP for GTP and dissociate from the $G_{\beta\gamma}$ dimer, (3) $G_{\alpha q}\text{-GTP}$ activates Phospholipase C-$\beta$ on the inner leaflet of the plasma membrane, (4) $\text{PLC}\beta$ hydrolyzes phosphatidylinositol 4,5-bisphosphate ($\text{PIP}_2$) into membrane-bound DAG and soluble $\text{IP}_3$, (5) $\text{IP}_3$ diffuses to the endoplasmic reticulum to open $\text{IP}_3$-receptor $\text{Ca}^{2+}$ channels, triggering a cytoplasmic $\text{Ca}^{2+}$ surge that coordinates with DAG to fully activate Protein Kinase C (PKC)!
3. **Slide 3 (`matching`):** Pair 4 GPCR components (G_alpha_s, G_alpha_q, Cholera Toxin, Pertussis Toxin) with their biochemical mechanisms.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that Adenylyl Cyclase synthesizes the second messenger cyclic AMP (cAMP) directly from ATP. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the molecular pathology of Vibrio cholerae infection: How does cholera toxin produced by *Vibrio cholerae* cause massive, life-threatening watery diarrhea in infected patients? (The toxin enzymatically **ADP-ribosylates the $G_{\alpha s}$ subunit, completely abolishing its intrinsic GTPase activity and locking $G_{\alpha s}$ in a permanently active state**, causing continuous overproduction of $\text{cAMP}$ that hyper-activates PKA and opens CFTR chloride channels in intestinal enterocytes, flooding the gut lumen with chloride and water).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "gpcr_signaling_pathways_gas_gai_and_gaq",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: GPCR Signaling Cascades (Gas, Gai, and Gaq)**\n• **$G_{\\alpha s}$ Stimulatory Pathway:**\n  - Agonist $\\to G_{\\alpha s}\\text{-GTP} \\to$ Activates **Adenylyl Cyclase (AC)** $\\to$ Converts $\\text{ATP} \\to \\mathbf{\\text{cAMP}} \\to$ Activates **PKA** $\\to$ Phosphorylates **CREB**.\n• **$G_{\\alpha i}$ Inhibitory Pathway:**\n  - Inhibits Adenylyl Cyclase $\\implies$ Drops intracellular $[\\text{cAMP}]$ and dampens PKA.\n• **$G_{\\alpha q}$ Phospholipase C Pathway:**\n  - $G_{\\alpha q}\\text{-GTP} \\to$ Activates **$\\text{PLC}\\beta$**, which cleaves $\\text{PIP}_2$ into two second messengers:\n    1. **$\\text{IP}_3$:** Diffuses to ER, opening $\\text{IP}_3$-gated $\\text{Ca}^{2+}$ channels $\\implies$ **$\\text{Ca}^{2+}$ Surge**.\n    2. **$\\text{DAG}$:** Remains in membrane $\\implies$ Cooperates with $\\text{Ca}^{2+}$ to activate **PKC**.\n• **Bacterial Toxin Diagnostics:**\n  - **Cholera Toxin:** ADP-ribosylates $G_{\\alpha s}$, locking it permanently **ON** (lethal cAMP storm).\n  - **Pertussis Toxin:** ADP-ribosylates $G_{\\alpha i}$, locking it permanently **OFF**."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential molecular steps of the G_alpha_q - Phospholipase C signaling cascade.",
      "orderItems": [
        "Ligand binding to a Gq-coupled GPCR triggers exchange of GDP for GTP on the G_alpha_q subunit",
        "Activated G_alpha_q-GTP binds and stimulates Phospholipase C-beta (PLC_beta) at the inner plasma membrane leaflet",
        "PLC_beta cleaves phosphatidylinositol 4,5-bisphosphate (PIP2) into soluble IP3 and membrane-bound DAG",
        "IP3 diffuses to the endoplasmic reticulum and binds ligand-gated IP3 receptors to release Ca²⁺ into the cytosol",
        "Elevated cytosolic Ca²⁺ and membrane-bound DAG synergistically recruit and activate Protein Kinase C (PKC)"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each G-protein pathway component to its downstream biochemical action.",
      "matchPairs": [
        { "left": "G_alpha_s Subunit", "right": "Stimulates Adenylyl Cyclase to synthesize cAMP and activate Protein Kinase A (PKA)" },
        { "left": "G_alpha_q Subunit", "right": "Stimulates Phospholipase C-beta to generate IP3 (Ca²⁺ release) and DAG (PKC activation)" },
        { "left": "Cholera Toxin", "right": "ADP-ribosylates G_alpha_s, disabling GTPase hydrolysis and locking the G-protein permanently ON" },
        { "left": "Pertussis Toxin", "right": "ADP-ribosylates G_alpha_i, preventing receptor coupling and locking the inhibitory G-protein OFF" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "Adenylyl Cyclase catalyzes the cyclization of intracellular ATP into the ubiquitous second messenger cyclic ___ (cAMP).",
      "blankAnswer": "amp",
      "blankDistractors": ["gmp", "ctp", "utp"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "What is the precise biochemical mechanism by which Cholera Toxin causes massive secretory diarrhea in the human intestine?",
      "options": [
        { "text": "It catalyzes ADP-ribosylation of G_alpha_s, preventing GTP hydrolysis and locking G_alpha_s in a permanently active state; this causes continuous adenylyl cyclase activation, sky-high cAMP levels, and constitutive PKA phosphorylation of CFTR chloride channels, flooding the intestinal lumen with salt and water", "isCorrect": true, "explanation": "Correct! Cholera toxin transfers an ADP-ribose group from NAD+ onto an essential arginine residue on the G_alpha_s subunit. This modification blocks the intrinsic GTPase activity of G_alpha_s, preventing it from hydrolyzing GTP to GDP. Trapped in the active state, G_alpha_s continuously stimulates adenylyl cyclase, causing intracellular cAMP to skyrocket. PKA becomes hyperactive and permanently phosphorylates CFTR chloride channels in intestinal crypt cells, dumping massive quantities of Cl- and osmotic water into the gut." },
        { "text": "It destroys all GPCR proteins in the body within 5 seconds", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "It blocks ATP synthase inside mitochondria", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "It turns cAMP into crystalline glucose", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
