# Enterprise App – AWS Terraform Baseline

This directory contains Terraform configurations for deploying and managing the **Enterprise App** infrastructure on Amazon Web Services (AWS). It represents the **baseline / legacy infrastructure** used at the start of the migration journey before the application is re-platformed to a more secure and modern architecture on Google Cloud Platform (GCP).

The goal of this Terraform project is to codify a realistic AWS deployment of the Enterprise App using core AWS services, while serving as the "before" state that is later improved in the GCP Terraform configuration (private subnets only, Cloud NAT, service accounts, etc.).

For an overview of the Enterprise App on AWS, see the higher-level documentation in [`AWS/README.md`](../README.md).

## Project Overview

This Terraform project provisions the core AWS infrastructure for the Enterprise App baseline deployment. It includes:

- VPC configuration with public subnets for application instances
- EC2 instances for Enterprise App servers (behind a load balancer)
- DynamoDB table for application data
- S3 bucket for file/object storage
- IAM roles and policies for instance access to AWS services
- Load balancer for traffic distribution
- Auto Scaling group for high availability and horizontal scaling

This setup demonstrates a common, production-style AWS design, which is later re-architected on GCP to further harden security and perimeter controls.

![emp-app-diagram](https://github.com/user-attachments/assets/507ce275-51cc-4b47-b03d-6ed316cde05a)

## Key Features

- **Infrastructure as Code**: Entire AWS baseline infrastructure for the Enterprise App is defined and versioned in Terraform.
- **Modular Design**: Configuration is structured for clarity and reuse, making it easier to understand, extend, or migrate.
- **Realistic Legacy Baseline**: Uses public subnets and instance-attached IAM roles typical of many legacy AWS environments, which are explicitly improved upon in the GCP migration.
- **Cost-Optimized**: Utilizes AWS resources efficiently while still demonstrating high availability patterns (Auto Scaling, load balancing).

## Getting Started

To use this Terraform configuration from within this repository, follow these steps:

1. **Prerequisites**

   - Install [Terraform](https://www.terraform.io/downloads.html)
   - Set up the [AWS CLI](https://aws.amazon.com/cli/) and configure your AWS credentials

2. **Change to the Terraform directory**

   From the root of this repository:

   ```sh
   cd AWS/terraform
   ```

3. **Initialize Terraform**

   ```sh
   terraform init
   ```

   This command initializes Terraform, downloads the required providers, and sets up the backend.

4. **Review the Terraform plan**

   ```sh
   terraform plan
   ```

   This shows a preview of the changes Terraform will make to your AWS environment for the Enterprise App baseline.

5. **Apply the Terraform configuration**

   ```sh
   terraform apply
   ```

   Review the planned changes and type `yes` when prompted to create or modify the resources.

6. **Verify the deployment**

   After successful application, verify in the AWS Console that the VPC, EC2 instances, Auto Scaling Group, load balancer, DynamoDB table, S3 bucket, and IAM roles have been created as expected.

7. **Clean up resources** (when no longer needed)

   ```sh
   terraform destroy
   ```

   This command removes all resources created by this Terraform configuration.

> **Note**: Always review the planned changes before applying them, especially in shared or production AWS accounts. Use variables and `*.tfvars` files to manage environment-specific configurations (e.g., region, naming, scaling limits).

## Conclusion

This Terraform project provides a comprehensive example of how to manage the **Enterprise App** AWS infrastructure as code for a legacy-style deployment. It forms the **starting point** for the migration case study in this repository: the same Enterprise App is later re-platformed to GCP using Terraform with a stronger security perimeter, private networking, and cloud-native best practices.
