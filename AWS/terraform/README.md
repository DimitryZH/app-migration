# AWS Employee Application Terraform Project

This repository contains Terraform configurations for deploying and managing an employee management application infrastructure on Amazon Web Services (AWS). The project demonstrates best practices in Infrastructure as Code (IaC) and cloud resource management using Terraform. For more details on the AWS Employee Directory App, visit [AWS Employee Directory App](https://github.com/DimitryZH/aws-emp-app).

## Project Overview

This Terraform project sets up a scalable and secure infrastructure for an employee management application on AWS. It includes:

- VPC configuration with public and private subnets
- EC2 instances for application servers
- RDS instance for database management
- S3 bucket for file storage
- IAM roles and policies for secure access
- Load balancer for traffic distribution
- Auto Scaling group for high availability

![emp-app-diagram](https://github.com/user-attachments/assets/507ce275-51cc-4b47-b03d-6ed316cde05a)

## Key Features

- **Infrastructure as Code**: Entire AWS infrastructure defined and versioned in Terraform
- **Modular Design**: Reusable Terraform modules for easy maintenance and scalability
- **Security-Focused**: Implements AWS security best practices
- **Cost-Optimized**: Utilizes AWS resources efficiently to manage costs

## Getting Started

To use this Terraform configuration, follow these steps:

1. **Prerequisites**:

   - Install [Terraform](https://www.terraform.io/downloads.html)
   - Set up [AWS CLI](https://aws.amazon.com/cli/) and configure your AWS credentials

2. **Clone the repository**:

   ```sh
   git clone https://github.com/DimitryZH/aws-emp-app-tf
   cd aws-emp-app-tf
   ```

3. **Initialize Terraform**:

   ```sh
   terraform init
   ```

   This command initializes Terraform, downloads required providers, and sets up the backend.

4. **Review the Terraform plan**:

   ```sh
   terraform plan
   ```

   This command shows you a preview of the changes Terraform will make to your infrastructure.

5. **Apply the Terraform configuration**:

   ```sh
   terraform apply
   ```

   Review the planned changes again and type 'yes' when prompted to create/modify the resources.

6. **Verify the deployment**:
   After successful application,
   
![apply-result](https://github.com/user-attachments/assets/97d3c101-1b6a-4f84-a8de-63a429b9e082)

verify that your resources have been created in the AWS Console.
   
8. **Clean up resources** (when no longer needed):
   ```sh
   terraform destroy
   ```
   This command will remove all resources created by this Terraform configuration.

**Note**: Always review the changes before applying them, especially in production environments. Use variables and tfvars files to manage environment-specific configurations.

## Conclusion

This project provides a comprehensive example of how to use Terraform to manage AWS infrastructure for an employee management application. By following the steps, you can deploy a scalable, secure, and cost-effective infrastructure on AWS.
