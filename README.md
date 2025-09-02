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


# Nginx Log Analyzer

This is a simple **Bash script** that analyzes Nginx access logs and outputs useful insights, such as:

- Top 5 IP addresses with the most requests  
- Top 5 most requested paths  
- Top response status codes  
- Top 5 User Agents  

It downloads the log file **once** from a provided source URL and then processes it locally for efficiency.

---

## Features

- **Efficient**: Downloads the log file only once and reuses it.  
- **Readable output**: Results are displayed in a human-friendly format.  
- **Customizable**: You can change the log file URL or adapt the parsing logic for your own Nginx logs.  

---

## Requirements

- A Unix-like system (Linux, macOS, WSL, etc.)
- `bash` shell  
- Standard CLI tools:
  - `curl`
  - `grep`
  - `sort`
  - `uniq`
  - `awk`

All of these are available by default on most Unix systems.

---

## Usage

1. Clone or download this repository.
```
git clone https://github.com/forte001/Automation.git
cd <your-repo>
```  
2. Make the script executable:

```bash
   chmod +x nginx-log-analyzer.sh
```
3. Run the script
```
./nginx-log-analyzer.sh
```

## Project URL
https://roadmap.sh/projects/nginx-log-analyser

---

# 🖥️ Simple System Monitor using Netdata

The scripts - setup.sh, test_dashboard.sh and cleanup.sh are the components of the simple system monitor that provide system information on CPU, Memory, I\O and Network on Linux

### setup.sh
This performs the function of updating system packages to ensure they are up-to-date and can work with the new tools to be installed. It also installs Netdata and setup alarm for CPU, Memory, I\O and Network which are triggered once the predefined limit of any of them is exceeded. They begin with warning at a certain threshold and when it has reached the critical threshold.

### test_dashboard.sh
This sets the test by stressing the system to trigger the alarm. It has test for CPU, memory, I\O and Network after which the output can viewed on the dashboard

### cleanup.sh
This cleans up the system after the setup and testing.

---
## Usage

### Clone the repository
```bash
git clone https://github.com/forte001/Automation.git
cd <your-repo> && cd <Simple_Monitoring>
```
---
### Make the script executable
```
chmod +x setup.sh test_dashboard.sh cleanup.sh
./setup.sh
```
---
### Install and configure Netdata
```
./setup.sh
```
### Visit http://<server-ip>:19999 browser for the dashboard
---

### Test the dashboard
```
./test_dashboard.sh
```
---
### Clean up when done
```
./cleanup.sh
```
---
### Project URL

https://roadmap.sh/projects/simple-monitoring-dashboard