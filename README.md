# 🖥️ Server Performance Monitoring Script

A simple **cross-platform (Linux + macOS)** Bash script for analyzing basic server performance statistics.  

This script helps system admins, developers, and DevOps engineers quickly check:
- ✅ CPU usage  
- ✅ Memory usage  
- ✅ Top processes by CPU  
- ✅ Top processes by Memory  

---

## 📌 Features
- Works on **Linux** and **macOS** (auto-detects OS with `uname`)
- Displays:
  - Overall **CPU usage**
  - Overall **Memory usage**
  - **Top 5 processes** sorted by CPU usage
  - **Top 5 processes** sorted by Memory usage

---

## 🚀 Usage

### 1. Clone the repository
```bash
git clone https://github.com/forte001/Automation.git
cd <your-repo>
```

### 2. Make the script executable
```bash
chmod +x server-stats.sh
```
### 3. Run the script
```bash
./server-stats.sh
```