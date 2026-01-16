# Infrastructure as Code: Two-Tier Web Architecture on AWS

## Project Overview

This project demonstrates the transition from manual "ClickOps" configuration to automated **Infrastructure as Code (IaC)**. Using **Terraform**, we define, provision, and manage a resilient Two-Tier architecture on Amazon Web Services (AWS).

The goal is to eliminate "Configuration Drift" by ensuring that the entire infrastructure is version-controlled, repeatable, and transparent.

## Architecture

The project deploys a secure network topology consisting of:

* **VPC**: A custom Virtual Private Cloud acting as the isolated network.
* **Public Subnet**: Hosts the **Web Server** (EC2 with Apache), accessible via the Internet Gateway.
* **Private Subnet**: Hosts the **Database Server** (EC2), isolated from the internet for security.
* **Security Groups**: Declarative firewall rules ensuring the Database only accepts traffic from the Web Server.

## Prerequisites

Before running this project, ensure you have the following installed:

1. **Terraform CLI**:([https://www.terraform.io/downloads](https://www.terraform.io/downloads))
2. **AWS CLI**:([https://aws.amazon.com/cli/](https://aws.amazon.com/cli/))
3. **VS Code**: Recommended editor with the *HashiCorp Terraform* extension.
4. **AWS Account**: An active account with Free Tier eligibility.

*Note: Run `aws configure` in your terminal to set up your credentials before starting.*

## Repository Structure

* `main.tf`: The primary logic file defining the Provider, VPC, Subnets, and Instances.
* `variables.tf`: Definitions for region, CIDR blocks, and instance types to ensure modularity.
* `outputs.tf`: Configured to display the Web Server's Public IP and URL after deployment.
* `.gitignore`: **Critical** configuration to exclude sensitive state files (`*.tfstate`) from version control.

## Usage Guide

### 1. Initialize

Prepare your directory and download the necessary AWS provider plugins.bash
terraform init

```

### 2. Plan
Generate an execution plan to preview the changes. Always review this output to ensure only the intended resources are being created.
```bash
terraform plan

```

### 3. Apply

Provision the infrastructure. Terraform will build the dependency graph and create resources in the correct order (VPC -> Network -> Security -> Compute).

```bash
terraform apply

```

*Type `yes` when prompted to confirm.*

### 4. Verify

* **Output Check**: Look for the `web_server_url` in the terminal output.
* **Browser Test**: Paste the IP into your browser to see the "Deployed via Terraform" index page.
* **Console Check**: Verify resources in the AWS VPC and EC2 dashboards.

### 5. Destroy

Clean up all resources to prevent unwanted billing charges.

```bash
terraform destroy

```

## Deliverables & Proofs

To mark this project as complete, the following proofs are required:

1. **GitHub Repository URL**: Must contain the `.tf` files and the `.gitignore`.
2. **Screenshot 1**: The terminal output of `terraform plan` showing the resource summary (e.g., "7 to add").
3. **Screenshot 2**: The AWS Management Console showing the tagged `Two-Tier-VPC` and EC2 instances.
