# 📦 Be A Man Level 3

![Terraform](https://img.shields.io/badge/IaC-Terraform-blueviolet)
![GCP](https://img.shields.io/badge/Cloud-Google_Cloud_Platform-orange)
![Status](https://img.shields.io/badge/Deployment-Ready-brightgreen)

This Terraform project provisions a multi-region GCP VPC with custom subnets, VM instances, and secure, **tag-based firewall pathing**. The deployment includes both Linux and Windows Server 2025 VMs across Iowa, São Paulo, and Tokyo. The Linux VMs serve custom HTML content via Apache using dynamic metadata, while Windows RDP VMs support desktop access.

## 🧱 Architecture Overview

| Location     | VM Name         | OS                       | Purpose               | Tag          |
|--------------|------------------|---------------------------|------------------------|---------------|
| Iowa         | `iowa-rdp`       | Windows Server 2025 RDP   | Primary Access Point   | `iowa-rdp`     |
| São Paulo    | `brazil-web`     | Debian 11                 | Web Server             | `brazil-web`   |
| São Paulo    | `brazil-rdp`     | Windows Server 2025 RDP   | Regional Desktop Relay | `brazil-rdp`   |
| Tokyo        | `tokyo-web`      | Debian 11                 | Web Server             | `tokyo-web`    |

## 🔥 Key Features

- ✅ **Static External IPs** for all VMs (no IAP)
- ✅ **Firewall Path Enforcement**: Iowa ➝ São Paulo ➝ Tokyo
- ✅ **Web Content via Apache** with embedded GCP metadata
- ✅ **Startup Scripts** generate full HTML pages with custom backgrounds, GIFs, and personalized messages

## 🧾 Files in This Project

| File                  | Description                                |
|-----------------------|--------------------------------------------|
| `1-variables.tf`      | All input variables (project ID, zones)    |
| `2-provider.tf`       | Google provider setup                      |
| `3-vpc.tf`            | VPC + subnet creation                      |
| `4-vm-instances.tf`   | Linux + Windows VM definitions             |
| `5-firewall.tf`       | Tag-based ingress firewall rules           |
| `6-service-account.tf`| Optional service account (Linux VMs)       |
| `7-outputs.tf`        | Outputs of all IPs (internal/external)     |
| `brazil-startup.sh`   | Brazil Script                              |
| `japan-startup.sh`    | Japanese Script                            |

## 🚀 Usage Instructions

### 1. Initialize Terraform

```bash
terraform init
```

### 2. Format Terraform

```bash
terraform fmt
```

### 3. Validate Terraform

```bash
terraform validate
```

### 4. Plan Terraform

```bash
terraform plan
```

### 5. Apply Infrastructure

```bash
terraform apply -auto-approve
```

## 🌐 Accessing the Web Pages

After applying, access each site in your browser:

### 🇧🇷 Brazil Web Server

```bash
http://<brazil_linux_vm_external_ip>
```

### 🇯🇵 Tokyo Web Server

```bash
http://<tokyo_vm_external_ip>
```

## 🖥️ RDP Access to Windows VMs

### Iowa RDP

Use `mstsc.exe` or Mac RDP with:

- IP: `iowa_vm_external_ip`
- Username: *(configured manually via serial console)*
- Password: *(set via console or metadata)*

### Brazil RDP

Use:

- IP: `brazil_windows_vm_external_ip`
- Login: *(admin user created via console or startup)*

## 🔐 Firewall Path Control (Tags)

| Source       | Target       | Port(s) | Rule Name                |
|--------------|--------------|---------|--------------------------|
| `iowa-rdp`   | `brazil-web` | 80      | `http-iowa-to-brazil`    |
| `brazil-web` | `tokyo-web`  | 80      | `http-brazil-to-tokyo`   |
| `iowa-rdp`   | `brazil-rdp` | 3389    | `rdp-iowa-to-brazil`     |
| `brazil-rdp` | `iowa-rdp`   | 3389    | `rdp-brazil-to-iowa`     |

Public access is only permitted for:

```hcl
source_ranges = ["0.0.0.0/0"]
target_tags   = ["iowa-rdp"]
```

## 📄 Startup Scripts

- **Brazil:** `brazil-startup.sh` creates an Apache-hosted HTML page themed with Brazil country background, a sexy Latina, and instance metadata.
- **Tokyo:** `japan-startup.sh` does the same for Tokyo, including a Japanese Dojo background, and a cute Japanese Lady.

## 🧼 Cleanup

```bash
terraform destroy -auto-approve
```

## 🛠️ Troubleshooting Techniques

### ✅ Web Servers Not Displaying in Browser

- SSH into the Linux VM and check the startup log:

  ```bash
  sudo cat /var/log/startup-script.log
  ```

- Ensure Apache is running:

  ```bash
  sudo systemctl status apache2
  sudo systemctl restart apache2
  ```

- Test locally:

  ```bash
  curl http://localhost
  ```

- Check that firewall rules for port 80 are in place and that tags are correct.

---

### ✅ Cannot SSH Into Linux Web VMs

- Confirm that the `tags` on each VM match the `target_tags` in your firewall rules.
- Ensure SSH (port 22) is allowed between `iowa-rdp` ➝ `brazil-web` and `brazil-web` ➝ `tokyo-web`.

---

### ✅ Apache Loads but Page is Missing Metadata

- Check that the metadata service is responding:

  ```bash
  curl -H "Metadata-Flavor: Google" http://metadata.google.internal/computeMetadata/v1/instance/zone
  ```

- Ensure your `cat <<EOF` block in the startup script isn’t overwritten by `cp $0`.

---

### ✅ Terraform Fails to Deploy or Update

- Reformat and validate:

  ```bash
  terraform fmt
  terraform validate
  ```

- Force re-creation of broken VM:

  ```bash
  terraform taint google_compute_instance.brazil_linux_vm
  terraform apply
  ```

## 🙌 Acknowledgment

- Scripts authored with inspiration from **Sensei Theo & Lord Beron**
- Deployed by **T.I.Q.S.**
- Team Lead: **John Sweeney**

---
