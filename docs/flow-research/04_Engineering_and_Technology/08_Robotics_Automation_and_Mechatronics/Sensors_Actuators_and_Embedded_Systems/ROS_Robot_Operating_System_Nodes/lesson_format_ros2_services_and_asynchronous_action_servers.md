# Duofy Reusable Lesson Format: ROS 2 RPCs (Services & Asynchronous Action Servers)

**Target Topic:** `04_Engineering_and_Technology / 08_Robotics_Automation_and_Mechatronics / Sensors_Actuators_and_Embedded_Systems / ROS_Robot_Operating_System_Nodes`  
**Lesson Format Type:** `ros2_services_and_asynchronous_action_servers`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through synchronous and asynchronous Remote Procedure Call (RPC) communication patterns in ROS 2, **Services** (one-to-one synchronous Request-Response pattern using `.srv` definitions), **Action Servers & Clients** (long-running, preemptible three-channel Goal-Feedback-Result communication using `.action` definitions), client-side goal cancellation, status transitions (Goal Accepted $\to$ Executing $\to$ Succeeded / Aborted / Canceled), and integration in navigation stacks (Nav2 `nav2_msgs/action/NavigateToPose`) and manipulation stacks (MoveIt `moveit_msgs/action/ExecuteTrajectory`) (YoonSeok Pyo et al. *ROS 2 Robot Programming*; Steven Macenski *Mastering ROS 2*; Open Robotics): formulate the **Action Server Three-Channel Architecture Master Formulation**:
$$\mathbf{\text{Action Client} \underset{\text{Channel 1: Send Goal / Cancel Request}}{\xrightarrow{\hspace{4cm}}} \text{Action Server}}$$
$$\mathbf{\text{Action Client} \underset{\text{Channel 2: Continuous Periodic Feedback (e.g. Distance Remaining)}}{\xleftarrow{\hspace{4cm}}} \text{Action Server}}$$
$$\mathbf{\text{Action Client} \underset{\text{Channel 3: Final Terminal Result (Success / Abort)}}{\xleftarrow{\hspace{4cm}}} \text{Action Server}}$$
master the **Services vs Actions Architectural Decision Matrix**:
$$\begin{array}{|l|l|l|l|l|}
\hline
\textbf{Primitive} & \textbf{Interface File} & \textbf{Duration} & \textbf{Preemptible?} & \textbf{Primary Robotics Use Case} \\
\hline
\mathbf{\text{Service}} & \mathbf{\text{.srv (Request --- Response)}} & \mathbf{< 50\text{ ms (Instant)}} & \mathbf{\text{No (Blocking)}} & \mathbf{\text{Reset encoder, trigger camera flash, read parameter}} \\
\mathbf{\text{Action}} & \mathbf{\text{.action (Goal --- Result --- Feedback)}} & \mathbf{\text{Seconds to Minutes}} & \mathbf{\text{Yes (Cancelable)}} & \mathbf{\text{Autonomous navigation (Nav2), robotic arm trajectory}} \\
\hline
\end{array}$$
(proving that using synchronous Services for long tasks blocks the executor thread and freezes the robot, whereas asynchronous Actions provide non-blocking goal tracking with real-time feedback and dynamic preemption).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Services (`.srv` Request/Response) vs Actions (`.action` Goal/Feedback/Result) Architecture Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Analytical Execution to Implement an Asynchronous Action Server with Periodic Feedback and Cancellation Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | ROS 2 RPC Construct / Communication Channel & Technical Robotics Role Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | In ROS 2, an Asynchronous Action Server Emits Continuous Progress Updates to the Client via the Periodic ___ Channel Before Returning the Final Terminal Result (Feedback / Feedback Channel) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | Robotics System Design Problem: Choosing Service vs Action for Autonomous Docking at a Battery Charging Station Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State ROS 2 RPCs & Action Server Mechanics (Pyo 2020; Macenski 2022):
   - **Interface Structure Formulations:**
     $$\mathbf{\text{Service (.srv): } [\text{Request}] \ --- \ [\text{Response}] \quad \Big| \quad \text{Action (.action): } [\text{Goal}] \ --- \ [\text{Result}] \ --- \ [\text{Feedback}]}$$
   - **Action State Transition Diagram:**
     $$\text{Goal Received} \to \text{Accepted} \to \text{Executing (Streaming Feedback)} \to \begin{cases} \text{Succeeded} & \text{Goal reached} \\ \text{Canceled} & \text{Client preemption} \\ \text{Aborted} & \text{Obstacle trapped} \end{cases}$$
   - **The Non-Blocking Invariant:** Because actions execute in separate worker threads, the **client main thread remains fully responsive**, capable of monitoring safety estops or aborting goals if a collision hazard appears!
2. **Slide 2 (`ordering`):** Provide 5 steps of action server implementation: (1) define the `.action` interface file specifying Goal, Result, and Feedback fields, (2) instantiate an `rclcpp_action::Server` / `ActionServer` instance inside the node, (3) register goal and cancel callback handlers to accept or reject incoming client requests, (4) spawn an execution thread that loops to perform task steps while publishing periodic feedback messages, (5) check for client cancellation requests and return final success or aborted result state!
3. **Slide 3 (`matching`):** Pair 4 concepts (Action Goal, Action Feedback, Action Result, Service Request-Response) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall of Feedback (or Feedback Channel). Plain text only.
5. **Slide 5 (`quiz`):** Quiz on selecting Service vs Action: An autonomous warehouse robot must navigate $45\text{ meters}$ down an aisle to a docking station, align with charging pins, and connect to power (taking approximately $30\text{ seconds}$). During transit, the operator dashboard must display current distance remaining, and if an emergency stop button is pressed, the robot must immediately halt and abort the mission. Which ROS 2 communication paradigm is architecturally required?
   - Task characteristics: Long-duration ($30\text{ s}$), requires periodic progress telemetry (distance remaining), and must support preemption (emergency cancellation) $\implies$ **Action Server / Client**;
   - Why not a Service? A Service is synchronous and blocking; it cannot provide intermediate progress feedback and cannot be canceled mid-execution;
   - What is the required communication architecture? (**Action Server / Client**).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "ros2_services_and_asynchronous_action_servers",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: ROS 2 RPCs \\& Action Servers (Steven Macenski)**\n• **Services vs Actions Architectural Comparison:**\n$$\n\\mathbf{\\text{Service (.srv): } \\begin{bmatrix} \\text{Request} \\\\ --- \\\\ \\text{Response} \\end{bmatrix} \\quad \\Big| \\quad \\text{Action (.action): } \\begin{bmatrix} \\text{Goal} \\\\ --- \\\\ \\text{Result} \\\\ --- \\\\ \\text{Feedback} \\end{bmatrix}}\n$$\n• **Action 3-Channel Communication Paradigm:**\n  - **Channel 1 (Goal/Cancel):** Client sends target destination; can transmit cancellation requests mid-transit;\n  - **Channel 2 (Feedback):** Server streams continuous periodic status telemetry (e.g. distance to target, current speed);\n  - **Channel 3 (Result):** Server returns final terminal outcome (`STATUS_SUCCEEDED`, `STATUS_CANCELED`, `STATUS_ABORTED`);\n• **The Non-Blocking Invariant:** Services block the calling thread and cannot be canceled; **Actions run asynchronously in dedicated worker threads**, allowing the main supervisory loop to monitor emergency stops and preempt long tasks dynamically!"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps to implement and execute a robust asynchronous ROS 2 Action Server.",
      "orderItems": [
        "Define the custom .action interface file specifying Goal definition, Result structure, and Feedback fields",
        "Instantiate an ActionServer object within the node specifying goal_callback, cancel_callback, and execute_callback",
        "Validate incoming client goal requests in goal_callback and accept or reject the goal handle",
        "Execute the long-running task in a separate worker thread while publishing periodic progress updates via publish_feedback()",
        "Check for client cancellation flags in each iteration and set terminal result status (succeed() or abort())"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each ROS 2 RPC Construct to its exact Technical Implementation.",
      "matchPairs": [
        { "left": "Service (Request-Response)", "right": "Synchronous short-duration call ideal for setting parameters or querying instantaneous robot states" },
        { "left": "Action Goal Channel", "right": "Client request initiating a long-running task with target parameters (e.g. Nav2 target waypoint pose)" },
        { "left": "Action Feedback Channel", "right": "Continuous intermediate progress stream published by server during active execution (e.g. remaining distance)" },
        { "left": "Action Result Channel", "right": "Final terminal message transmitted upon goal completion, cancellation, or error abortion" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "In ROS 2, an asynchronous action server emits continuous progress updates to the client via the periodic ___ channel before returning the final terminal result.",
      "blankAnswer": "feedback",
      "blankDistractors": ["request", "response", "parameter"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "An autonomous mobile robot must navigate across a warehouse to a charging dock over 30 seconds. The supervisory controller requires live updates of distance remaining every 500 ms, and must be able to cancel the motion immediately if an obstacle blocks the path. Which ROS 2 communication paradigm is architecturally required?",
      "options": [
        { "text": "Action Server/Client (Provides asynchronous execution, continuous periodic feedback, and client preemption/cancellation)", "isCorrect": true, "explanation": "Correct! Let's examine why an Action Server is the only architecturally correct choice (Steven Macenski *Mastering ROS 2*; Open Robotics Nav2 Architecture). 1. **Why Topics Are Insufficient:** A Topic is a simple one-way fire-and-forget stream without built-in goal acknowledgment or completion handshaking. 2. **Why Services Fail Here:** A Service is synchronous and blocking. If a node invokes a service that runs for $30\\text{ seconds}$, the calling thread freezes, unable to receive emergency stop commands or process intermediate progress updates. Furthermore, standard ROS 2 services cannot be preempted or canceled once called. 3. **Why Actions Are Mandatory:** - The **Goal Channel** initiates the docking navigation. - The **Feedback Channel** streams real-time distance remaining every $500\\text{ ms}$ to the operator UI. - The **Preemption/Cancel Channel** enables the safety system to abort the navigation goal immediately if an obstacle is detected. - The **Result Channel** confirms when physical contact with the charging pins has successfully occurred. Flawless ROS 2 Action Server architectural design!" },
        { "text": "Service (Request-Response) (Blocks client thread for 30s with zero feedback and no preemption)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Unidirectional Topic only (Lacks goal confirmation, completion status, and structured cancellation)", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "Parameter Event Subscriber", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
