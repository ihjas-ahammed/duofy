# Duofy Reusable Lesson Format: Concrete Slabs (One-Way vs Two-Way Design & Detailing)

**Target Topic:** `04_Engineering_and_Technology / 03_Civil_and_Structural_Engineering / Reinforced_Concrete_and_Steel_Design / Limit_State_Design_of_RCC_Beams_Slabs`  
**Lesson Format Type:** `one_way_and_two_way_slab_design_and_detailing`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Solidify the structural analysis, load distribution mechanisms, and detailing rules for reinforced concrete floor slabs: classifying **One-Way Slabs** ($L_{\text{long}} / L_{\text{short}} > 2.0$) designed as $1.0\text{ m}$ unit-width continuous beams versus **Two-Way Slabs** ($L_{\text{long}} / L_{\text{short}} \le 2.0$) spanning in orthogonal directions with dish-shaped bending curvature, minimum temperature/shrinkage reinforcement ($A_{s,\text{min}}$), maximum bar spacing ($3h$ or $450\text{ mm}$), and deflection-control thickness limits ($h_{\text{min}} = L/20$ to $L/28$) (James K. Wight *Reinforced Concrete: Mechanics and Design* Chapter 9 & 13; Arthur H. Nilson *Design of Concrete Structures* Chapters 12 & 13; ACI 318-19 Chapters 7 & 8): formulate the **One-Way vs Two-Way Aspect Ratio Classification**:
$$\mathbf{\text{Aspect Ratio } r = \frac{L_y \ (\text{Long Span})}{L_x \ (\text{Short Span})}}$$
$$\mathbf{r = \frac{L_y}{L_x} > 2.0 \implies \mathbf{\text{One-Way Spanning Slab (Bends primarily along short span } L_x\text{)}}}$$
$$\mathbf{r = \frac{L_y}{L_x} \le 2.0 \implies \mathbf{\text{Two-Way Spanning Slab (Carries bending moments in BOTH } X \text{ and } Y \text{ directions)}}}$$
derive the **Shrinkage & Temperature Steel Requirement ($A_{s,\text{temp}}$)**:
$$\mathbf{A_{s,\text{temp}} = 0.0018 \cdot b \cdot h \quad (\text{For Grade 420 / 60 ksi Rebars}) \quad \Big| \quad s_{\text{max}} \le \min(5h, \ 450\text{ mm} \ / \ 18\text{ in})}$$
master the **One-Way Strip Design Procedure**:
- Isolate a representative unit-width design strip ($b = 1000\text{ mm}$);
- Calculate main flexural steel along short span: $A_s = \frac{M_u}{\phi f_y (d - a/2)}$ with $s \le \min(3h, 450\text{ mm})$;
- Place transverse secondary reinforcement ($A_{s,\text{temp}}$) perpendicular to main steel;
and interact with live RCC Whitney stress block calculator, Ductility $\epsilon_t$ and $\phi$ evaluator, 45-Degree truss shear stirrup pitch optimizer, and One-way/Two-way slab aspect ratio explorer widgets.

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Slab Ratio ($L_y/L_x \gtrless 2.0$), 1-Way Strip ($b=1\text{m}$), 2-Way Dish & $A_{s,\text{temp}} = 0.0018 b h$ Setup Flashcard | `flashcard` | Recall (Phase A) | `content` (Front), `blankAnswer` (Back) |
| **Slide 2** | Step-by-Step Analytical Execution to Design Flexural and Temperature Reinforcement for a One-Way RCC Slab Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Slab Type / Reinforcement Entity & Technical Structural Detail Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | A Rectangular Floor Slab Supported on Four Edges with Aspect Ratio $L_y / L_x$ Greater Than 2.0 Behaves Mechanically as a ___-Way Slab (One / 1) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Interactive Reinforced Concrete Studio: Whitney Stress Block, Ductility, Shear Stirrups & Slabs Widget | `custom_html` | Production / Simulation (Phase C) | `content`, `interactiveCanvasHtml` (HTML5+JS) |

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "one_way_and_two_way_slab_design_and_detailing",
  "slides": [
    {
      "slideIndex": 1,
      "type": "flashcard",
      "content": "How do One-Way and Two-Way concrete slabs differ, and how is shrinkage/temperature reinforcement calculated?",
      "blankAnswer": "Concrete Slab Design (Wight & MacGregor; ACI 318-19): (1) ONE-WAY SLAB (Ly/Lx > 2): Bends along the short span; designed as a 1.0 m wide continuous beam. (2) TWO-WAY SLAB (Ly/Lx <= 2): Deflects in a dish shape, carrying bending moments in both orthogonal directions. (3) SHRINKAGE & TEMPERATURE STEEL: As,temp = 0.0018 * b * h (for Grade 60 rebar), placed perpendicular to main steel in one-way slabs to control drying shrinkage cracks. (4) MAX SPACING: Main steel s <= min(3h, 450 mm); Temperature steel s <= min(5h, 450 mm)!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to design a One-Way Reinforced Concrete Floor Slab using the unit-strip method.",
      "orderItems": [
        "Calculate the slab aspect ratio r = Ly / Lx to confirm that r > 2.0 (validating One-Way behavior)",
        "Select minimum slab thickness h (e.g. L/20 for simply supported) to guarantee serviceability deflection control without calculations",
        "Isolate a representative 1.0 m (1000 mm) wide unit design strip along the short span and calculate factored design moment Mu",
        "Calculate main flexural reinforcement area As along the short span and determine bar spacing: s = (A_bar / As) * 1000 \u2264 min(3h, 450 mm)",
        "Calculate transverse shrinkage and temperature reinforcement: As,temp = 0.0018 * b * h and detail perpendicular to main steel"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each Slab Design Entity to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "One-Way Slab (Ly/Lx > 2)", "right": "Slab spanning primarily along short direction, designed as a 1-meter wide rectangular beam" },
        { "left": "Two-Way Slab (Ly/Lx \u2264 2)", "right": "Slab supported on 4 sides exhibiting double-curvature dish deflection with moments in both axes" },
        { "left": "Temperature Steel (0.0018*b*h)", "right": "Secondary reinforcement placed perpendicular to main span to prevent concrete drying shrinkage cracks" },
        { "left": "Main Bar Spacing Limit (\u2264 3h)", "right": "Maximum bar pitch limit (s \u2264 min(3h, 450 mm)) to ensure uniform crack distribution across the slab" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "A rectangular floor slab supported on four perimeter beams with aspect ratio Ly / Lx greater than 2.0 behaves structurally as a ___-way slab.",
      "blankAnswer": "one",
      "blankDistractors": ["two", "three", "waffle"]
    },
    {
      "slideIndex": 5,
      "type": "custom_html",
      "content": "Interactive Reinforced Concrete & Slab Studio",
      "interactiveCanvasHtml": "<div style=\"color:white; display:flex; flex-direction:column; align-items:center; background:#0b0f19; padding:20px; font-family:sans-serif;\"><h3>Reinforced Concrete Design Studio</h3><p>Mechanics: <b style=\"color:#38bdf8;\">Whitney Block, Ductility (\u03b5t), Shear Stirrups & Slabs</b></p><div style=\"display:flex; gap:6px;\"><button id=\"btnWhit\" style=\"padding:6px 10px; background:#3b82f6; color:white; border:none; border-radius:4px; cursor:pointer;\">1. Whitney Stress Block (\u03c6Mn = 240.6kNm)</button><button id=\"btnShr\" style=\"padding:6px 10px; background:#10b981; color:white; border:none; border-radius:4px; cursor:pointer;\">2. Shear Stirrup Sizing (s = 225mm)</button><button id=\"btnSlab\" style=\"padding:6px 10px; background:#f59e0b; color:white; border:none; border-radius:4px; cursor:pointer; font-weight:bold;\">3. One-Way/Two-Way Slabs & As,temp</button></div><div id=\"rccLog\" style=\"margin-top:12px; border:1px solid #475569; padding:10px; border-radius:6px; min-width:340px; font-family:monospace; color:#fbbf24;\">Click step 1 to evaluate Whitney stress block...</div><script>document.getElementById('btnWhit').onclick=()=>{document.getElementById('rccLog').innerHTML='<b>1. WHITNEY STRESS BLOCK \\& CAPACITY:</b><br>• C = 0.85*fc\\\'*a*b = T = As*fy &rarr; a = 92.4 mm<br>• Neutral axis: c = a/\\u03b21 = 108.7 mm (\\u03b5t = 0.0108 &ge; 0.005 &rarr; <b style=\"color:#10b981;\">\\u03c6 = 0.90!</b>)<br>• Design Flexural Capacity: <b style=\"color:#38bdf8;\">\\u03c6Mn = 240.6 kN\\u00b7m!</b>';}; document.getElementById('btnShr').onclick=()=>{document.getElementById('rccLog').innerHTML='<b>2. TRANSVERSE SHEAR DESIGN (45\u00b0 TRUSS):</b><br>• Vc = 127.5 kN (\\u03c6Vc = 95.6 kN)<br>• Vs = Vu/\\u03c6 - Vc = 139.2 kN (2-leg \\u03a610mm Av=157.1 mm^2)<br>• <b style=\"color:#10b981;\">Stirrup Pitch: s = 225 mm (&le; d/2 = 250 mm)!</b>';}; document.getElementById('btnSlab').onclick=()=>{document.getElementById('rccLog').innerHTML='<b>3. ONE-WAY \\& TWO-WAY SLABS:</b><br>• Ly/Lx > 2.0 &rarr; One-Way Strip (b = 1000 mm)<br>• Ly/Lx &le; 2.0 &rarr; Two-Way Dish Deflection<br>• <b style=\"color:#10b981;\">Shrinkage & Temp Steel: As,temp = 0.0018 * b * h!</b><br>🏆 <b style=\"color:#10b981;\">Limit_State_Design_of_RCC_Beams_Slabs 100% COMPLETE!</b>'; if(window.DuoMessageChannel) DuoMessageChannel.postMessage('complete');};</script></div>"
    }
  ]
}
```
