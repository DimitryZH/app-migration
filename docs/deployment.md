# Deployment Overview

This document explains the **deployment model** used across all environments (AWS baseline, GCP Compute Engine, and GCP Cloud Run) and points to the **platform-specific guides**.

---

## 1. Common Deployment Model

All deployments share a consistent approach:

1. **Infrastructure as Code (Terraform)**
   - Each platform has its own Terraform stack:
     - `AWS/terraform/` – EC2, ALB, DynamoDB, S3, IAM
     - `GCP/terraform/` – MIG, HTTPS Load Balancer, Firestore, Cloud Storage, IAM
     - `GCP-Cloud-Run/terraform/` – Cloud Run service, Artifact Registry, IAM, buckets
   - Typical workflow:
     1. `terraform init`
     2. `terraform plan`
     3. `terraform apply`
     4. (When finished) `terraform destroy`

2. **Application Artifacts**
   - AWS baseline: application code is pulled and bootstrapped on EC2 instances via user‑data / startup scripts.
   - GCP Compute Engine: instances fetch application artifacts (e.g., from Cloud Storage) during startup.
   - GCP Cloud Run: application is packaged as a Docker image and stored in Artifact Registry.

3. **Environments**
   - The patterns described in this repository can be used with:
     - A **single project/account** for demos and training
     - **Multiple projects/accounts** for dev / stage / prod isolation
   - Environment-specific values (project IDs, regions, bucket names, etc.) are managed via Terraform variables and `terraform.tfvars`.

4. **State Management**
   - Terraform state can be stored locally for demos, or in remote backends (e.g., GCS bucket) for shared environments.

5. **CI/CD (Cloud Run option)**
   - The Cloud Run deployment uses **GitHub Actions** and **Workload Identity Federation** to:
     - Build and test the container image
     - Push the image to Artifact Registry
     - Update the Cloud Run service via Terraform and/or `gcloud`

---

## 2. Platform-Specific Deployment Guides

Use these guides for step-by-step instructions on each platform.

### 2.1 AWS Baseline (EC2 + ALB + DynamoDB + S3)

- Guide: `AWS/deployment_aws.md`
- Covers:
  - AWS prerequisites and credentials
  - Terraform deployment of VPC, EC2, ALB, DynamoDB, S3, IAM
  - Verifying the Enterprise App via the ALB endpoint
  - Auto Scaling behavior and cleanup

### 2.2 GCP Compute Engine (Option 1)

- Guide: `GCP/deployment_gce.md`
- Covers:
  - GCP project setup and enabling APIs
  - Packaging and uploading the Flask app
  - Terraform deployment of VPC, MIG, HTTPS Load Balancer, Firestore, Storage
  - Validation of app functionality and scaling
  - Destroying the stack when finished

### 2.3 GCP Cloud Run (Option 2)

- Guide: `GCP-Cloud-Run/deployment_cloud_run.md`
- Covers:
  - Containerizing the Flask app under `GCP/app/`
  - Configuring Terraform variables for Cloud Run, Artifact Registry, and buckets
  - Running Terraform to provision Cloud Run infrastructure
  - Setting up GitHub Actions CI/CD (`.github/workflows/cloud-run-deploy.yml`)
  - Granting public access (optional) and validating the Cloud Run URL
  - Cleanup of all Cloud Run–related resources

---

## 3. Environments & Promotion

The repository is suitable both for **single-environment demos** and for **multi-environment production scenarios**.

- **Single environment (demo / training)**
  - Use one AWS account and/or one GCP project
  - Deploy and destroy stacks as needed with Terraform

- **Multiple environments (dev / stage / prod)**
  - Use separate projects/accounts or naming prefixes
  - Parameterize `project_id`, `region`, and `environment` in Terraform
  - Use GitHub Environments and secrets to guard production deployments (especially for Cloud Run CI/CD)

Promotion strategies (especially for Cloud Run) can include:

- Branch-based workflows (`feature/*` → dev, `main` → stage, `release/*` → prod)
- Manual approvals on protected environments
- Gradual cutover using DNS or Cloud Run traffic splitting

---

## 4. Related Documentation

- `docs/architecture.md` – full architecture description and diagrams for all three deployment options.
- `docs/troubleshooting.md` – common issues (permissions, API enablement, CI/CD failures) and how to resolve them.
- `docs/cost-optimization.md` – guidance on reducing cost in AWS and GCP (instance sizing, scaling policies, Cloud Run min/max instances, storage lifecycle rules, etc.).

For day-to-day usage, start with `docs/architecture.md` and `docs/deployment.md`, then follow the appropriate `deployment_*.md` guide for your chosen platform.

