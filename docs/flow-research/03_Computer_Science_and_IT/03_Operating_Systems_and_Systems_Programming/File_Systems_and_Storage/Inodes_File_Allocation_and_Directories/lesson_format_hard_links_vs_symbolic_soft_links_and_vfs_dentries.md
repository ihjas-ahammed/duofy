# Duofy Reusable Lesson Format: Hard Links vs Symbolic (Soft) Links and VFS Dentries

**Target Topic:** `03_Computer_Science_and_IT / 03_Operating_Systems_and_Systems_Programming / File_Systems_and_Storage / Inodes_File_Allocation_and_Directories`  
**Lesson Format Type:** `hard_links_vs_symbolic_soft_links_and_vfs_dentries`  
**Architectural Rule:** EXACTLY 5 SLICES PER LESSON. Active Recall & Practice-First Pedagogy.

---

## 🎯 Pedagogical Blueprint & Objective
Guide students through the structural differences, inode allocation mechanics, directory reference counting (`nlink`), and Virtual File System (VFS) abstraction layers between Hard Links and Symbolic (Soft) Links (Dennis Ritchie 1979; Steve R. Kleiman VFS 1986; Remzi Arpaci-Dusseau OSTEP Chapter 39; Abraham Silberschatz et al.): master **Hard Links (`ln file link`)** (adding a new directory entry pointing to the **EXACT SAME INODE NUMBER**, incrementing `inode->i_nlink`, peer equality where deleting one file does not affect the other, and the inability to span across distinct file system partitions or link directories), master **Symbolic / Soft Links (`ln -s file link`)** (creating an **INDEPENDENT NEW INODE** with file type `S_IFLNK` containing the target pathname string as payload, cross-filesystem linking capability, and the risk of **Dangling / Broken Links** upon target removal), and formulate the **4 Core VFS Data Objects** (`super_block`, `inode`, `dentry`, `file`).

---

## 📐 5-Slide Sequential Flow Table

| Slide # | Slide Function | Duofy Slide Type | Target Cognitive State | Output Data Fields Required |
| :---: | :--- | :--- | :--- | :--- |
| **Slide 1** | Hard Link Inode Sharing, Soft Link Path Redirection, & VFS 4-Object Architecture Setup | `theory` | Encoding (Phase A) | `content` (Markdown + LaTeX) |
| **Slide 2** | Step-by-Step Kernel Path Resolution Using the VFS Dentry Cache Ordering | `ordering` | Discrimination (Phase B) | `content`, `orderItems` (3-6 sequential steps) |
| **Slide 3** | Link Type / VFS Core Object & Structural Invariant Matching | `matching` | Discrimination (Phase B) | `content`, `matchPairs` (3-6 pairs) |
| **Slide 4** | The Inode Metadata Field Tracking the Number of Hard Links Pointing to That Inode (nlink) Blank Fill | `fill_in_blank` | Recognition (Phase B) | `content`, `blankAnswer`, `blankDistractors` |
| **Slide 5** | What Happens to File Data When the Original File is Deleted After Creating a Hard Link vs a Soft Link Quiz | `quiz` | Production (Phase C) | `content`, `options` (4 options, 1 correct) |

---

## 🤖 LLM Prompt Generation Rules & Directives

1. **Slide 1 (`theory`):** State Hard Links vs Soft Links & VFS (Ritchie 1979; Kleiman 1986; OSTEP Chapter 39):
   - **Hard Link (`ln target link`):**
     - Inserts a new `(name, inode_num)` entry into the directory table with the **SAME inode number**.
     - Increments `inode->i_nlink` ($1 \to 2$).
     - Target and Link are identical equal peers!
     - Cannot cross filesystem boundaries (inode numbers are only unique within a single partition).
     - Data blocks are freed **ONLY when `nlink == 0` AND all open file descriptors close**!
   - **Symbolic / Soft Link (`ln -s target link`):**
     - Allocates a **BRAND NEW INODE** with type `symlink` (`S_IFLNK`).
     - File data block stores the target path string (e.g. `"/var/log/syslog"`).
     - Can span across different disks and network mounts!
     - Deleting target creates a **Dangling / Broken Symlink**!
   - **The 4 VFS (Virtual File System) Objects:**
     1. `struct super_block`: Represents an entire mounted filesystem.
     2. `struct inode`: Represents a specific file metadata object on disk.
     3. `struct dentry`: Represents a directory entry mapping name to inode (cached in RAM for fast path lookups).
     4. `struct file`: Represents an open file instance created by a process via `open()`.
2. **Slide 2 (`ordering`):** Provide 5 steps of the kernel resolving absolute path "/home/user/code.c" via VFS dentry cache: (1) start at root directory dentry (inode 2) stored in the VFS super_block, (2) check dentry cache for child "home"; if missing, read root directory blocks from disk to find inode number of "home", (3) lookup dentry "user" under "home" inode and load its inode metadata into memory, (4) lookup filename "code.c" inside the directory entries of "user", (5) instantiate a new 'struct file' object pointing to the resolved inode and return file descriptor integer to process!
3. **Slide 3 (`matching`):** Pair 4 link & VFS concepts (Hard Link, Symbolic Link, VFS dentry, VFS super_block) with their definitions.
4. **Slide 4 (`fill_in_blank`):** Single sentence blank testing recall that the inode reference count is stored in the field nlink. Plain text only.
5. **Slide 5 (`quiz`):** Quiz on the outcome of deleting original file under hard vs soft link: An engineer creates a hard link `file_hard` and a symbolic link `file_soft` pointing to original file `file.txt`. The engineer then deletes `file.txt` using `rm file.txt`. What happens when applications attempt to read `file_hard` and `file_soft`? (`file_hard` continues to read and write the **original file data completely normally with zero data loss** because its inode reference count decremented from 2 to 1 and disk blocks remain intact; `file_soft` becomes a **broken/dangling link returning `ENOENT` (No such file or directory)** because the path string it points to no longer exists).

---

## 📋 Reusable Master JSON Template

```json
{
  "lessonType": "hard_links_vs_symbolic_soft_links_and_vfs_dentries",
  "slides": [
    {
      "slideIndex": 1,
      "type": "theory",
      "content": "**Theorem: Hard Links, Soft Links, & VFS (1986)**\n• **Hard Link (`ln A B`):**\n$$\n\\mathbf{\\text{Directory entry points to the SAME Inode Number} \\implies \\mathbf{\\text{nlink}++}}\n$$\n  - Target and link are equal peers! Data blocks deleted **ONLY when $\\mathbf{\\text{nlink} == 0}$**.\n  - Cannot span across different filesystem partitions!\n• **Symbolic / Soft Link (`ln -s A B`):**\n  - Allocates an **INDEPENDENT NEW INODE** containing the target path string as data.\n  - Can cross file systems and mount points; deleting target causes a **Dangling Link**!\n• **The 4 VFS (Virtual File System) Objects:**\n$$\n\\begin{array}{|l|l|}\n\\hline\n\\textbf{VFS Object} & \\textbf{Kernel Functionality} \\\\\n\\hline\n\\mathbf{\\text{super\\_block}} & \\text{Overall filesystem metadata, block size, and root pointer} \\\\\n\\mathbf{\\text{inode}} & \\text{File metadata and physical block pointer map} \\\\\n\\mathbf{\\text{dentry}} & \\text{In-memory cached mapping of (directory + name } \\to \\text{ inode)} \\\\\n\\mathbf{\\text{file}} & \\text{Per-process open file state (current seek offset, access mode)} \\\\\n\\hline\n\\end{array}\n$$"
    },
    {
      "slideIndex": 2,
      "type": "ordering",
      "content": "Order the sequential steps of the Linux kernel resolving path '/home/user/doc.txt' using the VFS Dentry Cache.",
      "orderItems": [
        "Initialize path lookup at the root directory '/' dentry referenced in the root filesystem super_block",
        "Check the dentry hash table for entry 'home'; if cached, retrieve its Inode; else load directory block from disk",
        "Search the 'home' directory entries to locate child name 'user' and instantiate its corresponding dentry and Inode",
        "Lookup the target filename 'doc.txt' inside the 'user' directory Inode to find its unique inode number",
        "Allocate a new VFS 'struct file' object associated with the resolved Inode and return the file descriptor integer to user space"
      ]
    },
    {
      "slideIndex": 3,
      "type": "matching",
      "content": "Match each File System Link / VFS component to its exact structural property.",
      "matchPairs": [
        { "left": "Hard Link (ln)", "right": "Shares the identical Inode number and physical data blocks; increments the inode's nlink reference counter" },
        { "left": "Symbolic Link (ln -s)", "right": "Creates a distinct new Inode storing the target text path; breaks if the target file is renamed or removed" },
        { "left": "VFS Dentry Object", "right": "In-memory directory cache structure accelerating path-to-inode resolution without constant disk I/O" },
        { "left": "VFS Superblock", "right": "Kernel structure representing an entire mounted filesystem, its block geometry, and global status" }
      ]
    },
    {
      "slideIndex": 4,
      "type": "fill_in_blank",
      "content": "The integer field in a Unix Inode that counts how many hard directory links point to it is called ___.",
      "blankAnswer": "nlink",
      "blankDistractors": ["refcount", "linkid", "dentry_count"]
    },
    {
      "slideIndex": 5,
      "type": "quiz",
      "content": "An engineer creates a hard link 'file_hard' and a symbolic link 'file_soft' pointing to 'data.txt'. The engineer then deletes 'data.txt' with 'rm data.txt'. What happens when programs attempt to read 'file_hard' and 'file_soft'?",
      "options": [
        { "text": "file_hard reads and writes the original file data with 100% normal integrity because its inode link counter (nlink) simply decremented from 2 to 1 and the disk blocks remain allocated; file_soft becomes a broken/dangling link that fails with error ENOENT (No such file or directory) because the pathname string it references no longer exists in the directory tree", "isCorrect": true, "explanation": "Correct! This illustrates the fundamental architectural distinction between hard links and symbolic links (OSTEP Chapter 39). 1. When `data.txt` is initially created, an inode (e.g. Inode 54321) is allocated with `nlink = 1`, and the directory receives the entry `('data.txt', 54321)`. 2. When `ln data.txt file_hard` is run, a second directory entry `('file_hard', 54321)` is created pointing to the EXACT SAME inode 54321, and `nlink` increments to 2. 3. When `ln -s data.txt file_soft` is run, a BRAND NEW inode (e.g. Inode 99999) is allocated with type `symlink`, containing the ASCII text payload `'data.txt'`. 4. When `rm data.txt` is executed, the `unlink()` system call removes the directory entry `('data.txt', 54321)` and decrements `nlink` from 2 to 1 on Inode 54321. Because `nlink > 0`, the inode and its underlying disk data blocks are NOT freed! When an app opens `file_hard`, the kernel finds `('file_hard', 54321)`, opens Inode 54321, and reads the original data perfectly! 5. However, when an app opens `file_soft`, the kernel reads Inode 99999, discovers the path `'data.txt'`, and attempts to resolve `'data.txt'`. Because `'data.txt'` was unlinked from the directory, path resolution fails with `ENOENT` (Dangling Symbolic Link)." },
        { "text": "Both file_hard and file_soft are immediately destroyed and lose all data", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "file_soft reads the data normally while file_hard is corrupted", "isCorrect": false, "explanation": "Incorrect." },
        { "text": "The operating system crashes due to a null pointer exception in the file system driver", "isCorrect": false, "explanation": "Incorrect." }
      ]
    }
  ]
}
```
