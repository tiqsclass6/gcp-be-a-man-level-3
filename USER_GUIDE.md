# 📦 Be A Man Level 3 – USER GUIDE

![Terraform](https://img.shields.io/badge/IaC-Terraform-blueviolet)
![GCP](https://img.shields.io/badge/Cloud-Google_Cloud_Platform-orange)
![Status](https://img.shields.io/badge/Deployment-Manual-brightgreen)

## 📆 User Guide: Manual GCP Deployment

This guide walks you through manually deploying the **Be A Man Level 3** Terraform infrastructure using the **Google Cloud Console**.

---

## ✅ Prerequisites

- Google Cloud project with billing enabled
- Admin privileges
- APIs enabled:
  - Compute Engine API
  - VPC Access API
  - IAM API
- External IP quota in:
  - `us-central1` (Iowa)
  - `southamerica-east1` (São Paulo)
  - `asia-northeast1` (Tokyo)

---

## 🛠️ Step-by-Step Manual Setup

### ◾️ 1. VPC and Subnet Configuration

Navigate to: **VPC Network > VPC Networks**

- Click **"Create VPC network"**
- Name: `vpc`
- Subnet mode: **Custom**
- Add the following subnets:
  
| Name           | Region              | CIDR Range       |
|----------------|---------------------|------------------|
| `subnet-iowa`  | `us-central1`       | `10.233.10.0/24` |
| `subnet-brazil`| `southamerica-east1`| `10.233.40.0/24` |
| `subnet-tokyo` | `asia-northeast1`   | `10.233.70.0/24` |

- Click **Create**

![VPC and Subnets](https://github.com/tiqsclass6/gcp-be-a-man-level-3/blob/main/Screenshots/BAM3-subnet.jpg)

---

### ◾️ 2. Reserve Static External IPs

Navigate to: **VPC Network > External IP addresses**

Reserve these IPs in the respective regions:

| Name            | Region              |
|-----------------|---------------------|
| `ip-iowa-rdp`   | `us-central1`       |
| `ip-brazil-web` | `southamerica-east1`|
| `ip-brazil-rdp` | `southamerica-east1`|
| `ip-tokyo-web`  | `asia-northeast1`   |

---

### ◾️ 3. VM Creation

Navigate to: **Compute Engine > VM Instances**

#### a) Iowa RDP VM

- Name: `iowa-rdp`
- Region: `us-central1`
- Subnet: `subnet-iowa`
- Image: **Windows Server 2025**
- External IP: `ip-iowa-rdp`
- Tag: `iowa-rdp`
- Enable RDP & HTTP

#### b) Brazil Web VM

- Name: `brazil-web`
- Region: `southamerica-east1`
- Subnet: `subnet-brazil`
- Image: **Debian 11**
- External IP: `ip-brazil-web`
- Tag: `brazil-web`
- Startup script: Paste contents of `brazil-startup.sh`

#### c) Brazil RDP VM

- Name: `brazil-rdp`
- Region: `southamerica-east1`
- Subnet: `subnet-brazil`
- Image: **Windows Server 2025**
- External IP: `ip-brazil-rdp`
- Tag: `brazil-rdp`
- Enable RDP

#### d) Tokyo Web VM

- Name: `tokyo-web`
- Region: `asia-northeast1`
- Subnet: `subnet-tokyo`
- Image: **Debian 11**
- External IP: `ip-tokyo-web`
- Tag: `tokyo-web`
- Startup script: Paste contents of `japan-startup.sh`

![VM Instances - Terraform](https://github.com/tiqsclass6/gcp-be-a-man-level-3/blob/main/Screenshots/BAM3-vms-terraform.jpg)
![All VM Instances](https://github.com/tiqsclass6/gcp-be-a-man-level-3/blob/main/Screenshots/BAM3-vms.jpg)

---

### ◾️ 4. Firewall Rules

Go to **VPC Network > Firewall** and create:

#### a) Allow HTTP from Iowa to Brazil

- Name: `http-iowa-to-brazil`
- Targets: `brazil-web`
- Source tags: `iowa-rdp`
- Protocol: TCP 80

#### b) Allow HTTP from Brazil to Tokyo

- Name: `http-brazil-to-tokyo`
- Targets: `tokyo-web`
- Source tags: `brazil-web`
- Protocol: TCP 80

#### c) RDP Rules Between Iowa & Brazil

- `rdp-iowa-to-brazil`: target `brazil-rdp`, source `iowa-rdp`, port TCP 3389
- `rdp-brazil-to-iowa`: target `iowa-rdp`, source `brazil-rdp`, port TCP 3389

#### d) SSH to Linux VMs (Optional)

- Name: `ssh-access`
- Targets: `brazil-web`, `tokyo-web`
- Source IPs: `0.0.0.0/0` or your IP
- Protocol: TCP 22

#### e) Public HTTP for Iowa RDP

- Name: `allow-http-public`
- Target: `iowa-rdp`
- Source range: `0.0.0.0/0`
- Protocol: TCP 80

![Firewall Rules](https://github.com/tiqsclass6/gcp-be-a-man-level-3/blob/main/Screenshots/BAM3-firewall.jpg)

---

## 🔒 Firewall Path Recap

| Source       | Target       | Port | Allowed |
|--------------|--------------|------|---------|
| `iowa-rdp`   | `brazil-web` | 80   | ✅      |
| `brazil-web` | `tokyo-web`  | 80   | ✅      |
| `iowa-rdp`   | `brazil-rdp` | 3389 | ✅      |
| `brazil-rdp` | `iowa-rdp`   | 3389 | ✅      |
| Public       | `iowa-rdp`   | 80   | ✅      |
| Public       | Brazil/Tokyo | 80   | ❌      |

---

## 🚪 Access Details

### Web Access

- Brazil Web: `http://<ip-brazil-web>`
- Tokyo Web: `http://<ip-tokyo-web>`

![WebServers Output](https://github.com/tiqsclass6/gcp-be-a-man-level-3/blob/main/Screenshots/BAM3-rdps.jpg)

### RDP Access

- Iowa RDP: `mstsc` to `ip-iowa-rdp`
- Brazil RDP: accessed via Iowa

---

## 🗑️ Cleanup

1. Delete VMs from Compute Engine
2. Release reserved static IPs
3. Delete firewall rules
4. Delete the VPC

---

## 🚀 Optional: Use Terraform

Use the included Terraform scripts to automate all of the above. See `README.md` for Terraform-based deployment steps.

---

Deployed by: **T.I.Q.S.** | Team Lead: **John Sweeney**
