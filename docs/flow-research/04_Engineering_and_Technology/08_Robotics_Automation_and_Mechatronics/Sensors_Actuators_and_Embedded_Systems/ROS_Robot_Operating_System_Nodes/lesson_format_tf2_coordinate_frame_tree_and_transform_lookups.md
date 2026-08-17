# Duofy Reusable Lesson Format: Spatial Robotics (TF2 Transform Tree & Frame Lookups)

**Target Topic:** `04_Engineering_and_Technology / 08_Robotics_Automation_and_Mechatronics / Sensors_Actuators_and_Embedded_Systems / ROS_Robot_Operating_System_Nodes`  
**Lesson Format Type:** `tf2_coordinate_frame_tree_and_transform_lookups`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the spatial representation and dynamic coordinate frame management in ROS 2 using the **TF2 Transform Library** (`tf2_ros`), standard coordinate frame conventions (REP 105: `map` $\to$ `odom` $\to$ `base_link` $\to$ `laser_link`), the strict **Directed Tree Topology** (each frame has exactly one parent, no cycles), static vs dynamic transform broadcasters (`static_transform_publisher` vs `TransformBroadcaster`), transform composition through matrix multiplication ($^{\text{map}}T_{\text{laser}} = {^{\text{map}}T_{\text{odom}}} \cdot {^{\text{odom}}T_{\text{base}}} \cdot {^{\text{base}}T_{\text{laser}}}$), and time-synchronized buffer queries using `lookupTransform(target_frame, source_frame, time)` (Tully Foote et al. *TF: The Transform Library*; YoonSeok Pyo *ROS 2 Robot Programming*; ROS Enhancement Proposal REP 105): formulate the **TF2 Spatial Transform Composition Master Formulation**:
$$\mathbf{^{A}T_{C}(t) = {^{A}T_{B}(t)} \cdot {^{B}T_{C}(t)} = \begin{bmatrix} R_{AB}(t) & \vec{p}_{AB}(t) \\ \vec{0} & 1 \end{bmatrix} \begin{bmatrix} R_{BC}(t) & \vec{p}_{BC}(t) \\ \vec{0} & 1 \end{bmatrix}}$$
where to transform a 3D sensor point $^{\text{laser}}\vec{p}$ into the global navigation frame `map`:
$$\mathbf{^{\text{map}}\vec{p} = {^{\text{map}}T_{\text{laser}}} \cdot {^{\text{laser}}\vec{p}} = {^{\text{map}}T_{\text{odom}}} \cdot {^{\text{odom}}T_{\text{base\_link}}} \cdot {^{\text{base\_link}}T_{\text{laser}}} \cdot {^{\text{laser}}\vec{p}}}$$
master the **Standard Robotics Coordinate Frame Hierarchy (REP 105)**:
$$\begin{array}{|l|l|l|l|}
\hline
\textbf{Coordinate Frame} & \textbf{Parent Frame} & \textbf{Broadcasting Node} & \textbf{Kinematic Physical Meaning} \\
\hline
\mathbf{\text{map}} & \text{None (Global Origin)} & \mathbf{\text{SLAM / AMCL Localization}} & \mathbf{\text{World-fixed global frame; discontinuous SLAM jumps}} \\
\mathbf{\text{odom}} & \mathbf{\text{map}} & \mathbf{\text{Wheel / Visual Odometry}} & \mathbf{\text{Continuous, smooth local frame; drifts slowly over time}} \\
\mathbf{\text{base\_link}} & \mathbf{\text{odom}} & \text{Robot chassis kinematic center} & \text{Rigidly attached to moving robot body / footprint} \\
\mathbf{\text{laser\_link}} & \mathbf{\text{base\_link}} & \mathbf{\text{Static Transform Publisher}} & \mathbf{\text{Fixed geometric sensor mounting offset (extrinsics)}} \\
\hline
\end{array}$$
(proving that maintaining a single connected acyclic TF2 tree allows any node to transform sensory point clouds, obstacle grids, and navigation vectors into arbitrary reference frames seamlessly).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | TF2 Directed Tree (`map` $\to$ `odom` $\to$ `base_link` $\to$ `sensor`), Transform Composition & Lookup Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Setup TF2 Buffer, Broadcast Transforms, and Lookup a Target Frame Point Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | TF2 Component / REP 105 Frame & Technical Robotics Localization Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In the ROS TF2 Transform Library, the Coordinate Frame Hierarchy Must Form a Strict Directed ___ Topology Where Every Frame Has Exactly One Parent and Cycles Are Prohibited (Tree / Directed Tree) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Robotics Coordinate Transformation Problem: Computing Global Map Coordinates for an Obstacle Detected by LiDAR Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State TF2 Coordinate Frame Architecture (Foote 2013; REP 105):
   - **Homogeneous Composition Formulations:**
     $$\mathbf{^{\text{map}}\vec{p} = {^{\text{map}}T_{\text{odom}}} \cdot {^{\text{odom}}T_{\text{base\_link}}} \cdot {^{\text{base\_link}}T_{\text{laser}}} \cdot {^{\text{laser}}\vec{p}} \quad \Big| \quad \vec{p}_{\text{target}} = \text{lookupTransform}(\dots)}$$
   - **The Single-Parent Tree Invariant:** Every frame in TF2 must have **strictly one parent frame**; publishing two competing parents for `base_link` (e.g. odometry and visual SLAM both publishing `odom -> base_link` simultaneously) creates a loop collision that breaks the TF tree!
2. **Slide 2 (`ordering`):** Provide 5 steps of TF2 transform lookup: (1) publish static sensor extrinsics (`base_link -> laser_link`) via `static_transform_publisher`, (2) broadcast dynamic odometry transform (`odom -> base_link`) at high rate ($50\text{ Hz}$), (3) broadcast global localization correction (`map -> odom`) from AMCL/SLAM, (4) instantiate `tf2_ros::Buffer` and `tf2_ros::TransformListener` inside the consumer node, (5) query `buffer.lookupTransform("map", "laser_link", tf2::TimePointZero)` to transform laser points directly into global coordinates!
3. **Slide 3 (`matching`):** Pair 4 concepts (`map` Frame, `odom` Frame, `base_link` Frame, `lookupTransform`) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Tree (or Directed Tree). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on computing spatial coordinate transform: A 2D LiDAR mounted at position $(x_{\text{sensor}} = +0.200\text{ m}, y_{\text{sensor}} = 0.000\text{ m})$ relative to `base_link` detects an obstacle directly ahead at $(x = +2.000\text{ m}, y = 0.000\text{ m})$ in `laser_link` coordinates. The robot's `base_link` is positioned at $(x_{\text{robot}} = +3.000\text{ m}, y_{\text{robot}} = +1.500\text{ m})$ in the global `map` frame with orientation $\theta = 0.0^\circ$ (aligned with global map axes).
   - In `base_link` frame:
     $x_{\text{base}} = x_{\text{sensor}} + x_{\text{laser}} = 0.200 + 2.000 = \mathbf{2.200\text{ m}}$;
     $y_{\text{base}} = y_{\text{sensor}} + y_{\text{laser}} = 0.000 + 0.000 = \mathbf{0.000\text{ m}}$;
   - In `map` frame (with rotation $R = I$ since $\theta = 0^\circ$):
     $x_{\text{map}} = x_{\text{robot}} + x_{\text{base}} = 3.000 + 2.200 = \mathbf{5.200\text{ m}}$;
     $y_{\text{map}} = y_{\text{robot}} + y_{\text{base}} = 1.500 + 0.000 = \mathbf{1.500\text{ m}}$;
   - What are the global coordinates $(x_{\text{map}}, y_{\text{map}})$ of the detected obstacle in the world map? ($x_{\text{map}} = \mathbf{5.20\text{ m}}$ and $y_{\text{map}} = \mathbf{1.50\text{ m}}$).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "tf2_coordinate_frame_tree_and_transform_lookups",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: TF2 Coordinate Transforms \\& REP 105 (Tully Foote)**\n• **TF2 Transform Composition Master Formulation:**\n$$\n\\mathbf{^{\\text{map}}T_{\\text{laser}}(t) = {^{\\text{map}}T_{\\text{odom}}(t)} \\cdot {^{\\text{odom}}T_{\\text{base\\_link}}(t)} \\cdot {^{\\text{base\\_link}}T_{\\text{laser}}}}\n$$\n• **Standard Robotics Spatial Frame Hierarchy (REP 105):**\n  - **`map` (Global Origin):** World-fixed frame; positions calculated by SLAM/AMCL; exhibits discrete drift-correction jumps;\n  - **`odom` (Local Odometry):** Continuous, smooth, drift-accumulating frame calculated by wheel encoders / IMU;\n  - **`base_link` (Robot Center):** Rigidly attached to the physical robot chassis;\n  - **`sensor_link` (LiDAR / Camera):** Fixed rigidly to `base_link` via static extrinsics;\n• **The Single-Parent Tree Invariant:** The TF2 frame graph must be a **strict directed acyclic tree with exactly one parent per frame**; attempting to publish multiple conflicting parent transforms for `base_link` breaks the TF buffer and crashes navigation!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to broadcast coordinate frames and lookup spatial transforms using the ROS 2 TF2 library.",
      "orderItems": [
        "Broadcast static sensor mounting extrinsics (base_link \u2192 laser_link) using a static_transform_publisher",
        "Broadcast high-rate dynamic odometry transforms (odom \u2192 base_link) from the robot base wheel controller",
        "Broadcast global localization map corrections (map \u2192 odom) from the AMCL particle filter or SLAM node",
        "Instantiate a tf2_ros::Buffer and tf2_ros::TransformListener inside the consumer sensor processing node",
        "Call buffer.lookupTransform(\"map\", \"laser_link\", tf2::TimePointZero) to transform sensory points into global map coordinates"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each TF2 Spatial Entity to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "map Frame", "right": "Global world reference frame where robot coordinates are corrected for accumulated sensor drift via SLAM" },
        { "left": "odom Frame", "right": "Continuous smooth local frame integrated from wheel velocities that drifts slowly over time without jumps" },
        { "left": "base_link Frame", "right": "Coordinate frame rigidly fixed to the geometric center or rotation axis of the robot chassis" },
        { "left": "lookupTransform()", "right": "Buffer query calculating the concatenated homogeneous transform matrix between any two frames in the tree" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In the ROS TF2 transform library, the coordinate frame hierarchy must form a strict directed ___ topology where every frame has exactly one parent and cycles are prohibited.",
      "blankAnswer": "tree",
      "blankDistractors": ["graph", "mesh", "ring"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A LiDAR is mounted at (x = +0.200 m, y = 0.000 m) relative to base_link. It detects an obstacle at (x = +2.000 m, y = 0.000 m) in laser_link coordinates. The robot's base_link is located at (x = +3.000 m, y = +1.500 m) in the global map frame with heading \u03b8 = 0.0\u00b0. In base_link: x_base = 0.200 + 2.000 = 2.200 m. In map: x_map = 3.000 + 2.200 = 5.200 m and y_map = 1.500 + 0.000 = 1.500 m. What are the obstacle's coordinates (x_map, y_map) in the global map?",
      "options": [
        { "text": "x_map = 5.20 m and y_map = 1.50 m (x_map = 3.000 + (0.200 + 2.000) = 5.200 m; y_map = 1.500 + 0 = 1.500 m)", "isCorrect": true, "explanation": "Correct! Let's solve systematically using the TF2 spatial transform composition chain (Tully Foote *TF: The Transform Library*; ROS Enhancement Proposal REP 105). 1. **Identify Frame Relationships \\& Coordinates:** - Sensor mounting offset ($^{\\text{base}}T_{\\text{laser}}$): $x_{\\text{sensor}} = +0.200\\text{ m}, \\quad y_{\\text{sensor}} = 0.000\\text{ m}$. - Detected obstacle in sensor frame ($^{\\text{laser}}\\vec{p}$): $x_{\\text{laser}} = +2.000\\text{ m}, \\quad y_{\\text{laser}} = 0.000\\text{ m}$. - Robot base pose in global map ($^{\\text{map}}T_{\\text{base}}$): $x_{\\text{robot}} = +3.000\\text{ m}, \\quad y_{\\text{robot}} = +1.500\\text{ m}, \\quad \\theta = 0.0^\\circ$. 2. **Transform Obstacle from `laser_link` to `base_link`:** $$x_{\\text{base}} = x_{\\text{sensor}} + x_{\\text{laser}} = 0.200\\text{ m} + 2.000\\text{ m} = \\mathbf{2.200\\text{ m}}$$ $$y_{\\text{base}} = y_{\\text{sensor}} + y_{\\text{laser}} = 0.000\\text{ m} + 0.000\\text{ m} = \\mathbf{0.000\\text{ m}}$$ 3. **Transform Obstacle from `base_link` to `map`:** - Since robot heading $\\theta = 0.0^\\circ$, the rotation matrix is identity ($R = I$). $$x_{\\text{map}} = x_{\\text{robot}} + x_{\\text{base}} = 3.000\\text{ m} + 2.200\\text{ m} = \\mathbf{5.200\\text{ m} = 5.20\\text{ m}}$$ $$y_{\\text{map}} = y_{\\text{robot}} + y_{\\text{base}} = 1.500\\text{ m} + 0.000\\text{ m} = \\mathbf{1.500\\text{ m} = 1.50\\text{ m}}$$ Flawless TF2 coordinate transform composition derivation!" },
        { "text": "x_map = 5.00 m and y_map = 1.50 m (Forgot the 0.200 m sensor mounting offset)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "x_map = 2.20 m and y_map = 0.00 m (Reported base_link coordinates instead of map coordinates)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "x_map = 3.20 m and y_map = 3.50 m", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
