# Azure Hub-and-Spoke Mini Landing Zone

## Project Overview
This project provisions a mini Azure Landing Zone using a Hub-and-Spoke network topology. The infrastructure is defined as code using Terraform and deployed automatically via a CI/CD pipeline in GitHub Actions.

## Design Decisions (The "Why")
* **Hub-and-Spoke Network:** We use this topology to isolate application workloads (in the Spoke) while centralizing shared services like monitoring and secrets management (in the Hub). This improves security and reduces costs.
* **Traffic Flow:** The Spoke VNet and Hub VNet are connected via VNet Peering. By default, traffic routes through the Hub, allowing for centralized inspection and management.
* **Terraform Remote State:** Storing the `terraform.tfstate` file in an Azure Blob Storage container ensures the state is safely backed up, supports state locking to prevent concurrent deployment conflicts, and allows the GitHub Actions pipeline to access the true state of the infrastructure.
* **Security & Monitoring:** 
  * **NSGs** (Network Security Groups) protect subnets by restricting inbound and outbound traffic.
  * **Azure Key Vault** securely stores secrets and certificates.
  * **Log Analytics Workspace** provides centralized logging and monitoring for both network telemetry and application diagnostics.
* **CI/CD Automation:** GitHub Actions removes manual human error. Every push runs `terraform plan` for review, and merges run `terraform apply` using securely stored Azure credentials.

---

## Step-by-Step Implementation Guide

### Phase 1: Terraform Remote State Bootstrap
*This phase ensures our infrastructure state is stored securely in the cloud before we build the main resources.*
1. **Create Storage:** Create a dedicated Resource Group, Storage Account, and Blob Container in Azure for storing the state file.
2. **Configure Provider:** Specify the `azurerm` provider block with the required versions to interact with Azure APIs.
3. **Configure Backend:** Create the `backend "azurerm"` configuration block to tell Terraform to save the remote state in the newly created Blob container.

### Phase 2: Core Networking (Hub & Spoke)
1. **Deploy Hub VNet:** Create the Hub Virtual Network and a subnet for shared services.
2. **Deploy Spoke VNet:** Create the Spoke Virtual Network and a subnet for the application.
3. **Configure Peering:** Establish bidirectional VNet Peering between the Hub and the Spoke to allow network traffic to flow between them.

### Phase 3: Security and Observability
1. **Log Analytics:** Deploy a Log Analytics Workspace in the Hub for centralized monitoring.
2. **Key Vault:** Deploy an Azure Key Vault in the Hub for secret management.
3. **Network Security Groups (NSG):** Deploy an NSG, attach it to the Spoke subnet, and create rules (e.g., allow HTTP/HTTPS, block all other inbound traffic).

### Phase 4: Application Deployment
1. **Sample App:** Deploy a basic sample application (e.g., a Linux VM or Azure Container Instance) into the Spoke subnet.
2. **Validation:** Ensure the application can start and is governed by the NSG rules.

### Phase 5: CI/CD Pipeline (GitHub Actions)
1. **Authentication:** Set up Azure credentials (using OIDC or Service Principal) and store them in GitHub Secrets.
2. **Workflow YAML:** Create `.github/workflows/terraform.yml`.
3. **Pipeline Steps:** Define steps for `terraform fmt`, `terraform init`, `terraform plan` (on Pull Request), and `terraform apply` (on merge to main).


