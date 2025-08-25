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


---
## 🔍 Project URL

You can find this project here: https://roadmap.sh/projects/server-stats

https://roadmap.sh/projects/server-stats/solutions?u=6481e47b87dba40771228b9b




# Log Archiver Script

This Bash script automates log archiving on Unix-like systems (Linux, macOS).  
It compresses logs into a `.tar.gz` file, stores them in a dedicated archive directory, removes old archives, and can be scheduled to run daily at **2:00 A.M** using `cron`.

---

## ✨ Features
- Archives logs from a given directory (default: `/var/log`).
- Stores archives in a dedicated `archive/` subdirectory.
- Filenames are timestamped:  
  `logs_archive_YYYYMMDD_HHMMSS.tar.gz`
- Maintains an archive log file (`archive.log`) with timestamps of each run.
- Deletes archived files older than **30 days** automatically.
- Installs a cron job to run daily at **2 A.M**.
- Provides an option to uninstall the cron job.

---

## 📦 Requirements
- A Unix-like system (Linux, macOS).
- `bash`, `tar`, and `cron` installed (usually pre-installed).

---

## ⚙️ Usage

### Clone the repository
```bash
git clone https://github.com/forte001/Automation.git
cd <your-repo>
```

### Make the script executable
```bash
chmod +x log-archive.sh
```

### Run Once Manually
To archive logs from the default `/var/log`:
```bash
./log-archive.sh
```
To archive logs from custom directory:
```bash
./log-archive.sh /path/to/logs
```
### Uninstall Cron Job
To remove the scheduled cron job:
```
./log-archive.sh --uninstall-cron

```
### Permissions
On some systems, writing to /var/log or installing cron may require sudo:
```
sudo ./log-archive.sh
```

### Output

Archives are stored in:
```
<log-directory>/archive/logs_archive_YYYYMMDD_HHMMSS.tar.gz
```

Archive actions are logged in:
```
<log-directory>/archive/archive.log
```

---
## 🔍 Project URL
https://roadmap.sh/projects/log-archive-tool

