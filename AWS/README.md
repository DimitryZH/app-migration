# Enterprise App – AWS Baseline Deployment

## Overview

The AWS deployment of the **Enterprise App** represents the **initial legacy setup** used as the starting point for this migration project. It showcases how the Enterprise App can run on core AWS services such as Amazon EC2, Amazon S3, Amazon DynamoDB, and AWS IAM.

This baseline is intentionally closer to a traditional lift-and-shift design. It is functional and scalable, but it relies on patterns such as public subnets and instance-attached IAM roles that are later improved and hardened in the **GCP migration**, where the same Enterprise App is re-platformed onto a more secure architecture (private subnets, Cloud NAT, service accounts, etc.).

## Features

- **Enterprise Data Management**: Add, update, and delete enterprise employee records.
- **Scalability**: Utilizes Amazon EC2 and an AWS load balancer for horizontal scaling.
- **Storage**: Stores enterprise data in Amazon DynamoDB.
- **Security**: Uses AWS IAM roles and policies for access control.
- **File Storage**: Uses Amazon S3 for storing enterprise-related files such as employee photos.

## Architecture (Legacy Baseline)

The Enterprise App on AWS is built using a classic multi-tier architecture:

1. **Frontend**: A web interface for interacting with the Enterprise App UI.
2. **Backend**: A Python/Flask application running on EC2 instances behind a load balancer.
3. **Database**: Amazon DynamoDB for storing enterprise data.
4. **File Storage**: Amazon S3 for storing files such as employee photos.

This design forms the **before** state of the migration story. In the GCP Compute Engine deployment, the same Enterprise App is moved to a more secure perimeter with private subnets, Cloud NAT, and fine-grained service accounts, while preserving the application's core functionality.

![Architecture](./assets/aws-diagram.png)

## Prerequisites

- AWS Account
- AWS CLI configured
- Terraform installed

## Setup Instructions

1. **Deploy the infrastructure**:

   - Use the Terraform configuration under [`AWS/terraform`](./terraform/README.md) to provision the AWS infrastructure for the Enterprise App.

2. **Configure the application**:
   - Update the configuration files with your AWS resource details (DynamoDB table, S3 bucket, etc.).

## Usage

- Access the Enterprise App web interface via the URL of the AWS Load Balancer.

![add-employee-resized](https://github.com/user-attachments/assets/b16beb77-cd2d-495c-afbd-d73a30091ec3)

- Use the web interface to manage enterprise employee records (create, update, delete, and view entries).

![emp-app-loadbalancer-resized](https://github.com/user-attachments/assets/9bcb02ef-c711-41c7-a3d1-438b0789e924)

- Use the `/info` tab in the web UI to view instance information and trigger the CPU stress feature. Clicking **"stress cpu 10 min"** generates load to exercise Auto Scaling (scaling the app from 2 to 4 EC2 instances across Availability Zones).

![info_resized](https://github.com/user-attachments/assets/4d0176af-60bd-4871-bdfb-b8e22567ffb4)

## Conclusion

The AWS baseline deployment of the **Enterprise App** demonstrates how a production-style web application can be implemented using foundational AWS services. In the broader context of this project, this environment serves as the **legacy starting point** that is later migrated to Google Cloud Platform, where the same Enterprise App benefits from a more secure and modernized architecture.
