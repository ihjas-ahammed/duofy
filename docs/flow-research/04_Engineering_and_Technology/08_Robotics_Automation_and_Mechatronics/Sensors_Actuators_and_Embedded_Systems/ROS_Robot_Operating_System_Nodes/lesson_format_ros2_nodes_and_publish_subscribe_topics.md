# Duofy Reusable Lesson Format: ROS 2 Architecture (Nodes & Publish-Subscribe Topics)

**Target Topic:** `04_Engineering_and_Technology / 08_Robotics_Automation_and_Mechatronics / Sensors_Actuators_and_Embedded_Systems / ROS_Robot_Operating_System_Nodes`  
**Lesson Format Type:** `ros2_nodes_and_publish_subscribe_topics`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the distributed software architecture of the Robot Operating System (ROS 2), the concept of autonomous **Nodes** (`rclcpp::Node` / `rclpy.node.Node`), the asynchronous many-to-many **Publish-Subscribe Topic** communication paradigm, standard message types (`geometry_msgs/msg/Twist`, `sensor_msgs/msg/LaserScan`, `nav_msgs/msg/Odometry`), Data Distribution Service (DDS) **Quality of Service (QoS)** policies (Reliability: `RELIABLE` vs `BEST_EFFORT`; Durability: `VOLATILE` vs `TRANSIENT_LOCAL`), and command-line diagnostics using `ros2 topic`, `ros2 node`, and `rqt_graph` (YoonSeok Pyo et al. *ROS 2 Robot Programming*; Open Robotics Documentation; Morgan Quigley *Programming Robots with ROS*): formulate the **ROS 2 Topic Data Throughput Master Formulation**:
$$\mathbf{\dot{D}_{\text{topic}} = f_{\text{publish}} \cdot S_{\text{msg}} \quad \left[\frac{\text{Bytes}}{\text{sec}}\right]}$$
where:
1. **$f_{\text{publish}}$:** Topic publishing rate in Hertz ($\text{Hz}$);
2. **$S_{\text{msg}}$:** Serialized message payload size in Bytes;
master the **ROS 2 Quality of Service (QoS) Compatibility Matrix**:
$$\begin{array}{|l|l|l|l|}
\hline
\textbf{QoS Policy} & \textbf{Publisher Setting} & \textbf{Subscriber Setting} & \textbf{Connection Compatibility Result} \\
\hline
\mathbf{\text{Reliability}} & \mathbf{\text{RELIABLE}} & \mathbf{\text{BEST\_EFFORT}} & \mathbf{\text{COMPATIBLE (Subscriber accepts reliable stream)}} \\
\mathbf{\text{Reliability}} & \mathbf{\text{BEST\_EFFORT}} & \mathbf{\text{RELIABLE}} & \mathbf{\text{INCOMPATIBLE ERROR (Connection blocked!)}} \\
\mathbf{\text{Durability}} & \mathbf{\text{TRANSIENT\_LOCAL}} & \mathbf{\text{VOLATILE}} & \mathbf{\text{COMPATIBLE (Late subscriber ignores history)}} \\
\mathbf{\text{Durability}} & \mathbf{\text{VOLATILE}} & \mathbf{\text{TRANSIENT\_LOCAL}} & \mathbf{\text{INCOMPATIBLE ERROR (Connection blocked!)}} \\
\hline
\end{array}$$
(proving that in ROS 2 DDS, a subscriber requesting high QoS guarantees cannot connect to a publisher offering weaker guarantees, preventing silent data drops).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | ROS 2 Nodes, Asynchronous Pub/Sub Topics & DDS Quality of Service (QoS) Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Create a Velocity Publisher Node, Subscribe to Odometry, and Verify QoS Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | ROS 2 Middleware Entity / CLI Diagnostic Tool & Technical Robotics Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In ROS 2 Topic Communication, if a Publisher Offers `BEST_EFFORT` Reliability While a Subscriber Requests `RELIABLE` Reliability, the DDS Middleware Considers the Connection In-___ and No Data Will Be Received (Compatible / Incompatible) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Robotics Software Architecture Problem: Selecting Topic vs Service vs Action and Configuring QoS for a 100 Hz IMU Stream Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State ROS 2 Architecture & Pub/Sub Mechanics (Pyo 2020; Quigley 2015):
   - **Computational Graph Formulations:**
     $$\mathbf{\text{Node } A \xrightarrow{\text{Publish on } /\text{topic}} \text{DDS Middleware} \xrightarrow{\text{Subscribe}} \text{Node } B \quad \Big| \quad \dot{D} = f_{\text{hz}} \cdot S_{\text{bytes}}}$$
   - **Canonical Topics Standard:**
     - `/cmd_vel`: `geometry_msgs/msg/Twist` ($v_x, v_y, \omega_z$ motion commands);
     - `/scan`: `sensor_msgs/msg/LaserScan` (2D LiDAR ranges);
     - `/odom`: `nav_msgs/msg/Odometry` (Pose + Twist with covariance).
   - **The QoS Compatibility Invariant (Request vs Offered):**
     $$\text{Offered QoS (Publisher)} \ge \text{Requested QoS (Subscriber)}$$
     A subscriber requesting `RELIABLE` will **never connect** to a `BEST_EFFORT` publisher!
2. **Slide 2 (`ordering`):** Provide 5 steps of ROS 2 topic implementation: (1) initialize ROS 2 communication middleware via `rclcpp::init()` / `rclpy.init()`, (2) instantiate custom node inheriting from base `Node` class, (3) create a publisher on topic `/cmd_vel` with specified message type and QoS profile depth, (4) create a timer callback running at target frequency $f$ to populate and publish velocity messages, (5) spin the node executor `rclcpp::spin(node)` to process background callback queues!
3. **Slide 3 (`matching`):** Pair 4 concepts (`ros2 topic echo`, `geometry_msgs/msg/Twist`, `rqt_graph`, `BEST_EFFORT` QoS) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Compatible (or Incompatible). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on communication primitive selection: A robot has a 6-axis IMU streaming linear accelerations and angular velocities at $100\text{ Hz}$ to a real-time Kalman Filter state estimator. Which ROS 2 communication primitive and Quality of Service (QoS) profile should be selected?
   - Communication requirement: Continuous, high-frequency, unidirectional sensor stream $\implies$ **Topic (Publish/Subscribe)**;
   - QoS profile requirement: Real-time sensor stream where low latency is critical and dropping a single stale packet is preferred over waiting for retransmissions $\implies$ **`BEST_EFFORT` Reliability with `VOLATILE` Durability**;
   - What is the optimal communication modality and QoS configuration? (**Topic with `BEST_EFFORT` Reliability**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "ros2_nodes_and_publish_subscribe_topics",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: ROS 2 Nodes \\& Publish-Subscribe Topics (YoonSeok Pyo)**\n• **ROS 2 Computational Graph Architecture:**\n$$\n\\mathbf{\\text{Publisher Node} \\xrightarrow{\\text{Publish } [/\\text{topic}]} \\text{DDS Middleware} \\xrightarrow{\\text{Subscribe}} \\text{Subscriber Node(s)}}\n$$\n  - **Asynchronous Data Streaming:** Unidirectional, many-to-many communication ideal for high-rate sensor streams (LiDAR `/scan`, Cameras, Teleop `/cmd_vel`);\n• **DDS Quality of Service (QoS) Compatibility Rule:**\n$$\n\\mathbf{\\text{Offered QoS (Publisher)} \\ge \\text{Requested QoS (Subscriber)}}\n$$\n  - **Reliability:** `RELIABLE` (guaranteed delivery) vs `BEST_EFFORT` (low-latency drop-tolerant);\n  - **Durability:** `TRANSIENT_LOCAL` (latches historical messages for late subscribers) vs `VOLATILE` (no caching);\n• **The Incompatibility Invariant:** If a publisher offers `BEST_EFFORT` while a subscriber demands `RELIABLE`, the DDS layer detects an **incompatible QoS mismatch and blocks communication completely**, causing silent data starvation without raising a compilation error!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to create and execute an asynchronous ROS 2 publisher node in Python (rclpy) or C++ (rclcpp).",
      "orderItems": [
        "Initialize the client library middleware by executing rclcpp::init() or rclpy.init()",
        "Instantiate a custom modular node class inheriting from the standard Node base class",
        "Create a publisher object specifying message type (e.g. geometry_msgs/msg/Twist) and QoS history depth",
        "Create a periodic wall timer callback running at target frequency (e.g. 20 Hz) to construct and publish messages",
        "Pass the node instance to the executor spin function: rclcpp::spin(node) to process incoming events and callback queues"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each ROS 2 Topic Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Publish-Subscribe Topic", "right": "Many-to-many asynchronous unidirectional data stream connecting sensors to processing nodes" },
        { "left": "geometry_msgs/msg/Twist", "right": "Standard 6-DOF velocity command message containing linear (vx, vy, vz) and angular (\u03c9x, \u03c9y, \u03c9z) vectors" },
        { "left": "rqt_graph", "right": "Graphical GUI introspection tool visualizing live nodes, topics, and connections in the computational graph" },
        { "left": "BEST_EFFORT QoS", "right": "Low-latency UDP-like transmission policy ideal for high-throughput video streams and high-frequency LiDAR scans" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In ROS 2 topic communication, if a publisher offers BEST_EFFORT reliability while a subscriber requests RELIABLE reliability, the DDS middleware considers the connection in-___ and no data will be received.",
      "blankAnswer": "compatible",
      "blankDistractors": ["valid", "active", "secure"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "A mobile robot integrates a 6-axis IMU streaming angular velocity and linear acceleration at 100 Hz to an Extended Kalman Filter (EKF) localization node. Which ROS 2 communication primitive and Quality of Service (QoS) profile must be selected for this real-time pipeline?",
      "options": [
        { "text": "Topic with BEST_EFFORT Reliability and VOLATILE Durability (Continuous streaming where immediate low latency is prioritized over retransmission delays)", "isCorrect": true, "explanation": "Correct! Let's review the architectural guidelines for ROS 2 sensor integration (YoonSeok Pyo et al. *ROS 2 Robot Programming*; Open Robotics Documentation). 1. **Communication Primitive Selection:** - An IMU streams continuous data at $100\\text{ Hz}$. This is a classic one-way, high-rate, time-series telemetry stream that requires **Topic (Publish/Subscribe)**. - Services (blocking request-response) and Actions (preemptible goal tasks) are inappropriate for continuous $100\\text{ Hz}$ data feeds. 2. **Quality of Service (QoS) Configuration:** - **Reliability (`BEST_EFFORT`):** For real-time estimation, receiving the most recent packet with minimum latency is paramount. If a single $100\\text{ Hz}$ IMU packet drops, waiting for a TCP-like retransmission is detrimental because a fresh packet arrives just $10\\text{ ms}$ later. - **Durability (`VOLATILE`):** The EKF state estimator does not need stale historical IMU readings that were generated before the node was launched. Flawless ROS 2 topic and QoS architecture selection!" },
        { "text": "Service with RELIABLE QoS (Services are synchronous and would block the 100 Hz loop)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Action with TRANSIENT_LOCAL Durability (Actions are for long-duration navigation goals)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Topic with TRANSIENT_LOCAL Durability (Latches stale initial measurements unnecessarily)", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
