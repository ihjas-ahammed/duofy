# Duofy Reusable Lesson Format: Phylogenetic Tree Reconstruction (Parsimony vs Likelihood)

**Target Topic:** `02_Physical_and_Life_Sciences / 03_Biological_Sciences / Evolutionary_Biology / Phylogenetics_and_Molecular_Evolution`  
**Lesson Format Type:** `phylogenetic_tree_reconstruction_parsimony_vs_likelihood`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the computational algorithms, statistical criteria, and error artifacts of phylogenetic tree inference (Willi Hennig 1966, Joseph Felsenstein 1981, Saitou & Nei 1987): compare non-parametric **Maximum Parsimony (MP)** (minimizing total character-state transition steps via Fitch/Wagner optimization) with distance-based **Neighbor-Joining (NJ)**, probabilistic **Maximum Likelihood (ML)** ($L = P(\text{Data} \mid \text{Tree, Model})$ using GTR+$\Gamma$ substitution models), and **Bayesian Inference (MCMC posterior probabilities)**, evaluate **Long-Branch Attraction (LBA / Felsenstein Zone)** where parsimony produces positively misleading artifacts, and assess clade stability via **Non-Parametric Bootstrapping (Felsenstein 1985)**.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Phylogenetic Inference Algorithms & LBA Artifacts Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Fitch Parsimony Score Evaluation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Tree Reconstruction Method & Algorithmic Feature Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | Branch Support Resampling Metric Percentage Name Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Long-Branch Attraction Parsimony Failure in Felsenstein Zone Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Phylogenetic Tree Reconstruction Paradigms:
   - **The 4 Major Tree-Building Methods:**
     1. **Maximum Parsimony (MP):** Non-parametric optimality criterion. Selects the tree topology requiring the **fewest total evolutionary changes (substitutions)** across all character sites.
     2. **Neighbor-Joining (NJ, Saitou & Nei 1987):** Distance matrix method. Rapidly joins the closest star-like neighbors while correcting for unequal lineage rates ($O(N^3)$ computational complexity).
     3. **Maximum Likelihood (ML, Felsenstein 1981):** Probabilistic method. Computes likelihood $L = P(\text{Sequence Alignment} \mid \text{Tree Topology, Branch Lengths, Substitution Model})$; statistically consistent under correct models.
     4. **Bayesian Inference (MrBayes):** Uses Markov Chain Monte Carlo (MCMC) to sample the posterior probability distribution $P(\text{Tree} \mid \text{Data})$.
   - **Long-Branch Attraction (LBA / The Felsenstein Zone):**
     - Occurs when two non-sister lineages have experienced exceptionally high rates of sequence evolution (long branches).
     - Maximum Parsimony misinterprets convergent homoplasies as shared synapomorphies, **falsely grouping the two long branches together with $100\%$ statistical support**!
     - Maximum Likelihood and Bayesian methods resist LBA by modeling branch length-specific substitution probabilities.
   - **Bootstrapping (Joseph Felsenstein, 1985):** Pseudoreplicates of aligned columns resampled with replacement to assign percentage support values ($>70\%$ considered well-supported).
2. **Slide 2 (`ordering`):** Provide 5 steps of the Fitch parsimony algorithm calculating character changes on a candidate tree: (1) align homologous nucleotide sequences across all taxa to identify parsimony-informative sites (sites with at least 2 distinct character states, each present in at least 2 taxa), (2) propose a candidate unrooted tree topology connecting the taxa, (3) traverse the tree from the terminal tips toward the root (post-order tree traversal), assigning character state intersection sets to each ancestral node, (4) if two daughter node sets intersect, assign the intersection without adding a step; if they are disjoint, take the union and add 1 evolutionary step, (5) sum the minimum steps across all aligned nucleotide sites to obtain the tree's total parsimony length, selecting the topology with the lowest score!
3. **Slide 3 (`matching`):** Pair 4 phylogenetic methods/concepts (Maximum Parsimony, Maximum Likelihood, Neighbor-Joining, Bootstrap Support) with their mathematical definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the statistical resampling technique used to assess confidence in phylogenetic tree clades is non-parametric bootstrap analysis. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on Long-Branch Attraction in the Felsenstein zone: When two distantly related lineages both undergo rapid nucleotide substitutions (long branches) in a sequence dataset, why does Maximum Parsimony frequently produce a completely wrong phylogenetic tree? (Because **Maximum Parsimony assumes evolutionary changes are rare and cannot account for high rates of homoplasy**, causing it to mistake random convergent substitutions on the long branches for shared synapomorphic derived states, falsely clustering the two long branches together).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "phylogenetic_tree_reconstruction_parsimony_vs_likelihood",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Phylogenetic Tree Reconstruction (Parsimony vs. Likelihood)**\n• **Core Paradigms:**\n  - **Maximum Parsimony (MP):** Minimizes total evolutionary steps (Occam's razor; no explicit substitution model).\n  - **Neighbor-Joining (NJ):** Fast distance-matrix clustering ($O(N^3)$ algorithmic speed).\n  - **Maximum Likelihood (ML, Felsenstein 1981):** Maximizes $L = P(\\text{Data} \\mid \\text{Tree, Model})$ using explicit nucleotide/amino acid models (GTR+$\\Gamma$).\n  - **Bayesian Inference:** Samples posterior probability $P(\\text{Tree} \\mid \\text{Data})$ via MCMC.\n• **Long-Branch Attraction (LBA / Felsenstein Zone):**\n  - Two fast-evolving non-sister lineages accumulate convergent mutations.\n  - **MP fails** by mistaking homoplasy for shared synapomorphy, falsely grouping long branches together!\n• **Bootstrap Support (Felsenstein 1985):** Resamples alignment columns with replacement ($>70\\%$ indicates strong clade support)."
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the steps of evaluating phylogenetic tree topology using Fitch's Maximum Parsimony algorithm.",
      "orderItems": [
        "Align homologous DNA sequences and identify parsimony-informative nucleotide sites across all taxa",
        "Propose a candidate unrooted tree topology connecting the terminal taxa",
        "Traverse the tree from the tips toward the internal ancestral nodes (post-order traversal), calculating character intersection sets",
        "If sister nodes share states, retain the intersection with zero cost; if disjoint, assign the union and add 1 evolutionary step",
        "Sum the minimum required steps across all aligned sequence sites to determine the tree's total parsimony length"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each phylogenetic reconstruction concept to its methodological definition.",
      "matchPairs": [
        { "left": "Maximum Parsimony (MP)", "right": "Optimality criterion seeking the tree topology that minimizes the total number of character state transitions" },
        { "left": "Maximum Likelihood (ML)", "right": "Statistical criterion evaluating the probability of observed sequence alignment given a substitution model and tree" },
        { "left": "Long-Branch Attraction (LBA)", "right": "Systematic parsimony artifact where rapidly evolving lineages artificially group together due to convergent homoplasy" },
        { "left": "Non-Parametric Bootstrapping", "right": "Alignment column resampling with replacement to estimate statistical confidence in individual tree nodes" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In phylogenetic inference, the statistical resampling technique used to measure confidence in individual clades is non-parametric ___ analysis.",
      "blankAnswer": "bootstrap",
      "blankDistractors": ["bayesian", "parsimony", "likelihood"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "Why does Maximum Parsimony fail and produce a false phylogenetic tree in the 'Felsenstein Zone' (when two distant lineages have exceptionally long branch lengths)?",
      "options": [
        { "text": "Maximum Parsimony does not model variable substitution rates along branches, causing it to misinterpret random CONVERGENT BASE SUBSTITUTIONS on the two fast-evolving lineages as shared derived synapomorphies, falsely pulling the long branches together", "isCorrect": true, "explanation": "Correct! In the Felsenstein zone, two long branches accumulate a large number of independent substitutions simply because they have evolved rapidly. Because Maximum Parsimony assumes that evolutionary steps are extremely rare, it treats these random convergent homoplasies as shared derived traits (synapomorphies), leading to the well-known artifact of Long-Branch Attraction (LBA). Model-based methods like Maximum Likelihood avoid this by properly accounting for branch lengths and multiple substitutions at the same site." },
        { "text": "Because fast-evolving DNA turns into RNA inside the computer", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because parsimony algorithms cannot process more than 3 species", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Because long branches destroy all mitochondrial DNA", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
