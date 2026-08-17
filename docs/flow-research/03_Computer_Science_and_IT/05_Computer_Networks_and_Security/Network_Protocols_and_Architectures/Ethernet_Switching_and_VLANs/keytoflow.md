# Key to Flow: Ethernet Switching, Spanning Tree (STP), and VLANs (802.1Q & Inter-VLAN Routing)

**Subject Area:** `03_Computer_Science_and_IT / 05_Computer_Networks_and_Security / Network_Protocols_and_Architectures / Ethernet_Switching_and_VLANs`

---

## 📌 Core Concept & Mental Model
**Layer 2 Transparent Bridging, Source MAC Address Auto-Learning (CAM Table Lookup), Loop-Free Topology Construction via Spanning Tree Protocol (STP IEEE 802.1D / 802.1w), Logical Broadcast Segmentation via 802.1Q VLAN Tagging, and Subinterface Inter-VLAN Routing** govern local area network switching and frame delivery (Robert Metcalfe Ethernet 1973; Radia Perlman 1985 Spanning Tree Algorithm; IEEE 802.1D / IEEE 802.1Q Standards; Kurose & Ross Chapter 6.4; Tanenbaum & Wetherall Chapter 4.8):
* **1. Layer 2 Switch Forwarding & CAM Table Operations:**
  - **The 4 Fundamental Switch Actions:**
    1. **Learning:** Switch inspects **Source MAC** of incoming frame on port $X$ $\implies$ writes `(Source MAC, Port X, Aging Timer)` into Content Addressable Memory (CAM) Table.
    2. **Forwarding:** If **Destination MAC** is found in CAM table on Port $Y$ ($Y \ne X$) $\implies$ transmit frame out Port $Y$ only.
    3. **Filtering:** If **Destination MAC** is on the *same* port $X$ $\implies$ silently drop/filter frame.
    4. **Flooding:** If **Destination MAC** is unknown unicast or broadcast (`FF:FF:FF:FF:FF:FF`) $\implies$ transmit out **ALL ports except incoming port $X$**!
  - **Domains:** Hubs share 1 Collision Domain & 1 Broadcast Domain; Switches create **Separate Collision Domains per port**, but share **1 Single Broadcast Domain**.
* **2. Spanning Tree Protocol (STP - IEEE 802.1D / Radia Perlman 1985):**
  - **The Problem:** Redundant physical Ethernet links cause catastrophic **Broadcast Storms, Multiple Frame Transmissions, and CAM Table Instability** (since Layer 2 frames have zero TTL!).
  - **The Algorithmic Solution (Bridge Protocol Data Units - BPDUs):**
    1. **Root Bridge Election:** The switch with the **Lowest Bridge ID (BID $= \text{Priority [default 32768]} + \text{MAC}$)** becomes the Root Bridge.
    2. **Root Port (RP) Selection:** On every non-root switch, the single port with the lowest Root Path Cost to the Root Bridge.
    3. **Designated Port (DP) Selection:** On each LAN segment, the single port providing the lowest cost path to the Root Bridge (Always Forwarding).
    4. **Blocking / Alternate Port (AP):** All remaining redundant ports are placed in **Blocking/Discarding state**, breaking physical loops!
* **3. Virtual LANs (VLANs) & IEEE 802.1Q Frame Tagging:**
  - **Broadcast Domain Isolation:** Segregates a physical switch into multiple isolated logical broadcast domains (e.g. Sales VLAN 10, Engineering VLAN 20).
  - **Port Roles:**
    - **Access Port:** Connects to end-hosts (PCs/printers); transmits untagged frames belonging to a single native VLAN.
    - **Trunk Port:** Interconnects switches; multiplexes frames across multiple VLANs using **IEEE 802.1Q 4-byte Tag Header** (**TPID `0x8100` + 12-bit VLAN ID `1 - 4094`**).
* **4. Inter-VLAN Routing:**
  - Frames cannot cross between different VLANs without a Layer 3 routing boundary!
  - **Architectural Approaches:**
    - **Router-on-a-Stick:** Single physical 802.1Q trunk link connected to a router with logical **subinterfaces** (`Gig0/0.10`, `Gig0/0.20`).
    - **Layer 3 Multilayer Switch:** Line-rate hardware routing via internal **Switch Virtual Interfaces (SVIs)** (`interface Vlan 10`).

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The L2 Switching Diagnostic Ladder
* Source MAC $\to$ Learn into CAM.
* Destination MAC $\to$ Lookup $\to$ Forward / Filter / Flood.
* Redundant Link $\to$ STP BPDU $\to$ Elect Root $\to$ Block Loop.
* VLAN Boundary $\to$ 802.1Q Trunk Tag $\to$ L3 Inter-VLAN Route.

### 2. Top Recommended Resources
* **The Definitive Textbook:** *Computer Networking: A Top-Down Approach* (Kurose & Ross 8th Ed.), Chapter 6.4 (Switched Local Area Networks).
* **Network Infrastructure Classic:** *Interconnections: Bridges, Routers, Switches, and Internetworking Protocols* (Radia Perlman, Addison-Wesley).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you trace how a switch populates its CAM table and when it floods frames?
- [ ] Can you elect the Root Bridge and identify Root Ports, Designated Ports, and Blocked Ports in an STP triangle?
- [ ] Can you parse the 4-byte IEEE 802.1Q VLAN header (TPID, Priority, VID)?
- [ ] Can you design a Router-on-a-Stick inter-VLAN configuration with subinterfaces?
