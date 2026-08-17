# Key to Flow: TCP and UDP Socket Programming (Handshakes, AIMD Congestion Control, & Berkeley Sockets)

**Subject Area:** `03_Computer_Science_and_IT / 05_Computer_Networks_and_Security / Network_Protocols_and_Architectures / TCP_UDP_Socket_Programming`

---

## 📌 Core Concept & Mental Model
**Connection-Oriented Byte Streams vs Unreliable Datagrams, The 3-Way Handshake & 4-Way Teardown State Machines, The AIMD Congestion Control Sawtooth (`cwnd`), and The Berkeley POSIX Sockets Syscall Pipeline** govern transport-layer protocols and network programming (Vint Cerf & Robert Kahn 1974 RFC 675 / RFC 793 TCP; David P. Reed 1980 RFC 768 UDP; Van Jacobson 1988 Congestion Avoidance; W. Richard Stevens *UNIX Network Programming Volume 1*; Kurose & Ross Chapter 3):
* **1. TCP vs UDP Protocol Fundamentals:**
  - **TCP (Transmission Control Protocol, RFC 793):**
    - Connection-Oriented, Full-Duplex, Byte-Stream abstraction.
    - Reliable Delivery (Sequence Numbers, ACKs, Retransmissions), In-Order Delivery, Flow Control (`rwnd`), Congestion Control (`cwnd`).
    - 20-byte minimum header ($60\text{ bytes max with options}$).
  - **UDP (User Datagram Protocol, RFC 768):**
    - Connectionless, Unreliable, Message-Boundary Datagrams.
    - Zero handshake latency, zero head-of-line blocking, zero congestion throttling.
    - Compact 8-byte fixed header (Source Port, Dest Port, Length, Checksum).
* **2. TCP Connection Lifecycle State Machine:**
  - **3-Way Handshake (Establishment):**
    $$\mathbf{\text{Client} \xrightarrow{\mathbf{\text{SYN (seq}=x)}} \text{Server} \xrightarrow{\mathbf{\text{SYN-ACK (seq}=y, \ \text{ack}=x+1)}} \text{Client} \xrightarrow{\mathbf{\text{ACK (seq}=x+1, \ \text{ack}=y+1)}} \text{Server}}$$
  - **4-Way Teardown (Graceful Half-Close):**
    $$\mathbf{\text{Client} \xrightarrow{\mathbf{\text{FIN}}}} \text{Server} \xrightarrow{\mathbf{\text{ACK}}} \text{Client} \quad ; \quad \text{Server} \xrightarrow{\mathbf{\text{FIN}}} \text{Client} \xrightarrow{\mathbf{\text{ACK}}} \text{Server}}$$
  - **The `TIME_WAIT` State Invariant (2MSL = Maximum Segment Lifetime):**
    - Active closer waits **$2\text{MSL}$ (typically 60-120 seconds)** to: (1) allow final ACK to reach server if lost, (2) drain old wandering duplicate packets from the network!
* **3. TCP Flow & Congestion Control (Van Jacobson 1988):**
  - **Flow Control (End-Host Receiver Protection):** Advertised window ($\text{rwnd}$) prevents sender from overflowing receiver's socket buffer.
  - **Congestion Control (Network Core Protection):**
    - **Slow Start:** Exponential growth ($\text{cwnd} \leftarrow \text{cwnd} + 1\text{ MSS}$ per ACK; doubles every RTT) until `ssthresh`.
    - **Congestion Avoidance (AIMD):** Linear growth ($\text{cwnd} \leftarrow \text{cwnd} + \frac{1}{\text{cwnd}}$ per RTT).
    - **Fast Retransmit:** Receiving **3 Duplicate ACKs** triggers immediate retransmission of missing packet *without waiting for RTO timeout*!
    - **Fast Recovery (TCP Reno):** $\text{ssthresh} \leftarrow \frac{\text{cwnd}}{2}, \ \text{cwnd} \leftarrow \text{ssthresh} + 3\text{ MSS}$ (avoids dropping back to 1 MSS!).
* **4. Berkeley POSIX Sockets Programming API:**
  - **TCP Server Lifecycle:** `socket() \to bind() \to listen() \to accept() \to read()/write() \to close()`.
  - **TCP Client Lifecycle:** `socket() \to connect() \to write()/read() \to close()`.
  - **UDP Peer Lifecycle:** `socket() \to bind() \to sendto() / recvfrom() \to close()`.

---

## 🔑 Best Known Study Methodologies & Learning Framework

### 1. The Socket Syscall Flow Matrix
* Server: `socket -> bind -> listen -> accept -> rw`
* Client: `socket -> connect -> rw`
* UDP: `socket -> bind -> sendto/recvfrom`

### 2. Top Recommended Resources
* **The Network Bible:** *Computer Networking: A Top-Down Approach* (Kurose & Ross), Chapter 3 (Transport Layer).
* **The Systems Standard:** *UNIX Network Programming Volume 1: The Sockets Networking API* (W. Richard Stevens, Bill Fenner, Andrew M. Rudoff).

---

## 🎯 Problem-Solving Checklist
- [ ] Can you diagram the TCP 3-Way Handshake and calculate sequence/ack numbers?
- [ ] Can you explain why the `TIME_WAIT` state lasts for 2MSL?
- [ ] Can you trace the AIMD congestion window sawtooth curve through Slow Start and Fast Recovery?
- [ ] Can you write a minimal Berkeley Sockets TCP echo server in C/Python?
