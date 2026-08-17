# Duofy Reusable Lesson Format: Thoracic Anatomy (Mediastinum & Sternal Angle T4-T5)

**Target Topic:** `05_Medicine_and_Health_Sciences / 01_Pre_Clinical_Sciences / Human_Anatomy_and_Histology / Gross_Anatomy_Head_Neck_Thorax_Abdomen_Limbs`  
**Lesson Format Type:** `mediastinal_compartments_and_sternal_angle_plane`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide medical students through the compartmentalization of the central thoracic cavity, the transverse thoracic plane passing through the **Sternal Angle (Angle of Louis / Manubriosternal Joint) and the T4-T5 Intervertebral Disc**, the six major anatomical structures bifurcating, starting, or terminating at the T4-T5 plane, the division into **Superior Mediastinum** and **Inferior Mediastinum** (subdivided into **Anterior**, **Middle**, and **Posterior Mediastinum**), the viscera, vascular trunks, and nerves occupying each compartment (Middle: Pericardium, Heart, Ascending Aorta, Pulmonary Trunk, Phrenic Nerves C3-C5; Posterior: Descending Thoracic Aorta, Esophagus, Thoracic Duct, Azygos and Hemiazygos Veins, Vagus Nerves CN X, Sympathetic Trunks), and clinical mediastinal mass localization (Keith L. Moore, Arthur F. Dalley, Anne M. R. Agur *Clinically Oriented Anatomy* 8th ed. Chapter 1; Frank H. Netter *Atlas of Human Anatomy* 7th ed. Plates 212-215; Susan Standring *Gray's Anatomy* 42nd ed. Chapter 54): formulate the **Sternal Angle (T4-T5 Plane) Major Anatomical Structures Matrix**:
$$\begin{array}{|l|l|l|}
\hline
\textbf{Anatomical System} & \textbf{Structural Transition at Sternal Angle (T4-T5)} & \textbf{Clinical Significance} \\
\hline
\mathbf{\text{Respiratory Tree}} & \mathbf{\text{Tracheal Bifurcation into Main Bronchi (Carina)}} & \mathbf{\text{Endotracheal tube depth verification on chest X-ray}} \\
\mathbf{\text{Cardiovascular (Arterial)}} & \mathbf{\text{Aortic Arch begins and ends; transforms to Descending Aorta}} & \mathbf{\text{Coarctation of aorta; aortic dissection classification}} \\
\mathbf{\text{Cardiovascular (Venous)}} & \mathbf{\text{Azygos Vein arches over right bronchus to drain into SVC}} & \mathbf{\text{Collateral venous return in SVC obstruction syndrome}} \\
\mathbf{\text{Lymphatic System}} & \mathbf{\text{Thoracic Duct crosses from right to left side of esophagus}} & \mathbf{\text{Chylothorax localization during thoracic surgery}} \\
\mathbf{\text{Skeletal Landmark}} & \mathbf{\text{Attachment of 2nd Costal Cartilage to Sternum}} & \mathbf{\text{Universal clinical reference for counting ribs \& interspaces}} \\
\hline
\end{array}$$
master the **Four Mediastinal Compartments & Contents**:
$$\begin{array}{|l|l|l|}
\hline
\textbf{Mediastinal Compartment} & \textbf{Boundaries} & \textbf{Key Anatomical Viscera \& Neurovascular Contents} \\
\hline
\mathbf{\text{Superior Mediastinum}} & \text{Superior thoracic aperture to T4-T5 plane} & \mathbf{\text{Thymus, Brachiocephalic veins, SVC, Aortic arch, Trachea, Esophagus}} \\
\mathbf{\text{Anterior Mediastinum}} & \text{Sternum to anterior pericardium} & \text{Thymus remnants, internal thoracic lymph nodes, adipose tissue} \\
\mathbf{\text{Middle Mediastinum}} & \text{Pericardial sac} & \mathbf{\text{Heart, Pericardium, Ascending Aorta, Pulmonary Trunk, Phrenic Nerves}} \\
\mathbf{\text{Posterior Mediastinum}} & \text{Posterior pericardium to T5-T12 vertebrae} & \mathbf{\text{Descending Thoracic Aorta, Esophagus, Thoracic Duct, Azygos Vein, Vagus}} \\
\hline
\end{array}$$
(proving that clinical imaging categorizes mediastinal masses based on these four distinct anatomical compartments: anterior thymoma/teratoma/thyroid/lymphoma, middle lymphadenopathy/pericardial cyst, posterior neurogenic tumors).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Sternal Angle (T4-T5 Plane) Landmark, Superior vs Inferior Mediastinum & Middle/Posterior Contents Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution of Tracing Mediastinal Structures Across the Transverse Thoracic Plane Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Mediastinal Compartment / Thoracic Landmark & Technical Clinical Anatomy Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Horizontal Transverse Plane Dividing the Superior and Inferior Mediastinum Passes Anteriorly Through the Sternal Angle and Posteriorly Through the Intervertebral Disc Between Vertebrae T4 and ___ (T5 / Vertebra T5) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Clinical Thoracic Anatomy Problem: Localizing a Mass in the Posterior Mediastinum and Identifying Adjacent Viscera Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Mediastinal Compartments & Sternal Angle Mechanics (Moore 2018; Netter 2019):
   - **Transverse Thoracic Plane Landmarks:**
     $$\mathbf{\text{Sternal Angle Plane (T4-T5): } \begin{cases} \text{1. Tracheal Carina (Bifurcation)} \\ \text{2. Aortic Arch Begin / End} \\ \text{3. Azygos Vein arches into SVC} \\ \text{4. Thoracic Duct crosses Right } \to \text{ Left} \\ \text{5. 2nd Costal Cartilage articulation} \end{cases}}$$
   - **Mediastinal Compartments Invariant:**
     - **Superior:** Above T4-T5 (Arch, Trachea, Esophagus, Brachiocephalic veins);
     - **Anterior:** Pre-pericardial space (Thymus, Lymph nodes);
     - **Middle:** Pericardial space (Heart, Ascending Aorta, Phrenic Nerves C3-C5);
     - **Posterior:** Post-pericardial space (Descending Aorta, Esophagus, Thoracic Duct, Azygos, Vagus CN X)!
2. **Slide 2 (`ordering`):** Provide 5 steps of navigating mediastinal anatomy on cross-sectional CT: (1) identify the sternal angle anteriorly and T4-T5 intervertebral disc posteriorly to establish the transverse thoracic dividing plane, (2) identify the tracheal carina dividing into right and left primary bronchi at this exact axial level, (3) trace the aortic arch as it transitions into the descending thoracic aorta on the left, (4) locate the azygos vein arching over the right main bronchus to empty into the superior vena cava, (5) follow the esophagus and thoracic duct as they descend into the posterior mediastinum!
3. **Slide 3 (`matching`):** Pair 4 concepts (Middle Mediastinum, Posterior Mediastinum, Sternal Angle T4-T5, Thoracic Duct) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of T5 (or Vertebra T5). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on posterior mediastinal anatomy: A chest CT scan reveals a 4-cm neurogenic tumor located in the posterior mediastinum just anterior to the T7-T8 vertebral bodies. Which of the following sets of anatomical structures reside within this same posterior mediastinal compartment adjacent to the mass?
   - Posterior mediastinum contents: Descending thoracic aorta, Esophagus, Thoracic duct, Azygos and hemiazygos veins, Vagus nerves (esophageal plexus), and Sympathetic trunks;
   - Structures in middle mediastinum (Heart, Ascending aorta, Phrenic nerves) are in front of the pericardium;
   - What are the contents of the posterior mediastinum? (Descending thoracic aorta, Esophagus, Thoracic duct, and Azygos vein).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "mediastinal_compartments_and_sternal_angle_plane",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Mediastinal Anatomy \\& Sternal Angle T4-T5 (Keith L. Moore)**\n• **Transverse Thoracic Plane (Sternal Angle / T4-T5) Master Landmarks:**\n$$\n\\mathbf{\\text{Sternal Angle Plane (T4-T5): } \\begin{cases} \\text{1. Tracheal bifurcation into main bronchi (Carina)} \\\\ \\text{2. Aortic arch starts, arches, and terminates} \\\\ \\text{3. Azygos vein arches over right bronchus into SVC} \\\\ \\text{4. Thoracic duct crosses from right to left} \\\\ \\text{5. Articulation of 2nd costal cartilage to sternum} \\end{cases}}\n$$\n• **Four Mediastinal Compartments Hierarchy:**\n  - **Superior Mediastinum:** Above T4-T5 plane (Thymus, Brachiocephalic veins, SVC, Aortic arch, Trachea, Esophagus);\n  - **Anterior Mediastinum:** In front of pericardium (Thymic fat, internal thoracic nodes);\n  - **Middle Mediastinum:** Pericardial sac (Heart, Ascending Aorta, Pulmonary Trunk, Phrenic Nerves);\n  - **Posterior Mediastinum:** Behind pericardium (Descending Thoracic Aorta, Esophagus, Thoracic Duct, Azygos Vein, Vagus Nerves);\n• **The Clinical Partition Invariant:** Mediastinal masses are localized clinically by compartment: **Anterior (4 Ts: Thymoma, Teratoma, Thyroid, Terrible lymphoma)**, **Middle (Pericardial/Bronchogenic cysts)**, and **Posterior (Neurogenic tumors)**!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to identify the transverse thoracic plane and trace mediastinal viscera on a chest CT scan.",
      "orderItems": [
        "Locate the manubriosternal junction (Sternal Angle) anteriorly and the T4-T5 intervertebral disc posteriorly",
        "Identify the tracheal bifurcation (Carina) dividing into the wider right main bronchus and more horizontal left main bronchus",
        "Observe the aortic arch curving posteriorly to transition into the descending thoracic aorta",
        "Trace the azygos vein arching over the root of the right lung to enter the posterior wall of the Superior Vena Cava",
        "Follow the descending aorta, esophagus, and thoracic duct inferiorly into the posterior mediastinal compartment"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Mediastinal Compartment to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Middle Mediastinum", "right": "Pericardial cavity containing the heart, ascending aorta, pulmonary trunk, and bilateral phrenic nerves" },
        { "left": "Posterior Mediastinum", "right": "Paravertebral space (T5-T12) containing descending thoracic aorta, esophagus, thoracic duct, and azygos vein" },
        { "left": "Sternal Angle (Angle of Louis)", "right": "Transverse horizontal plane (T4-T5) marking carina bifurcation, aortic arch boundaries, and 2nd rib articulation" },
        { "left": "Thoracic Duct", "right": "Primary lymphatic vessel ascending from cisterna chyli, crossing right-to-left at T4-T5 to drain into left venous angle" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The horizontal transverse plane dividing the superior and inferior mediastinum passes anteriorly through the sternal angle and posteriorly through the intervertebral disc between vertebrae T4 and ___.",
      "blankAnswer": "T5",
      "blankDistractors": ["T3", "T6", "T12"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A chest CT scan reveals a 4-cm neurogenic schwannoma located in the posterior mediastinum adjacent to the T7-T8 vertebral bodies. Which of the following groups of anatomical structures resides within this same posterior mediastinal compartment?",
      "options": [
        { "text": "Descending Thoracic Aorta, Esophagus, Thoracic Duct, and Azygos Vein (All four traverse the posterior mediastinum behind the fibrous pericardium from T5 to T12)", "isCorrect": true, "explanation": "Correct! Let's review the contents of the posterior mediastinum (Keith L. Moore et al. *Clinically Oriented Anatomy* Chapter 1; Susan Standring *Gray's Anatomy* Chapter 54). 1. **Posterior Mediastinum Boundaries \\& Contents:** - Boundaries: Anteriorly bounded by the posterior pericardium and diaphragm; posteriorly bounded by the bodies of the T5 through T12 thoracic vertebrae. - **Primary Longitudinal Contents:** 1. **Descending Thoracic Aorta** (gives off posterior intercostal and bronchial arteries). 2. **Esophagus** (surrounded by the anterior and posterior vagal nerve plexuses). 3. **Thoracic Duct** (ascends between the aorta on the left and azygos vein on the right). 4. **Azygos and Hemiazygos Venous System** (draining the posterior intercostal spaces). 5. **Thoracic Splanchnic Nerves** (Greater, Lesser, and Least splanchnic sympathetic preganglionics). 2. **Why Other Choices Are Incorrect:** - The Heart, Ascending Aorta, Pulmonary Trunk, and Phrenic Nerves reside in the **Middle Mediastinum**. - The Thymus and Brachiocephalic Veins reside in the **Superior / Anterior Mediastinum**. Flawless posterior mediastinal anatomical localization!" },
        { "text": "Heart, Pericardium, Ascending Aorta, and Phrenic Nerves (Middle mediastinal contents)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Thymus gland, Internal Thoracic Arteries, and Anterior Lymph Nodes (Anterior mediastinal contents)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Brachiocephalic Veins, Trachea, and Aortic Arch (Superior mediastinal contents)", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
