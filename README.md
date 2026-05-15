# aws_terraform

A production-style AWS infrastructure project built with Terraform and deployed automatically via GitHub Actions CI/CD pipeline.

What this project builds
VPC with 2 public subnets across 2 availability zones
Application Load Balancer (internet-facing)
Auto Scaling Group with rolling instance refresh
EC2 t3.micro instances running nginx
Security groups with least-privilege rules
Remote Terraform state in S3 with DynamoDB locking
CI/CD pipeline run through jenkins

Project structure:-

├── Infra
│   ├── Aws-Design.png
│   ├── main.tf
│   ├── output.tf
│   ├── user-data.sh
│   └── variable.tf
├── Jenkinsfile
├── README.md
└── app
    └── index.html


Technologies used
AWS — EC2, ALB, ASG, VPC, IAM, S3, DynamoDB
Terraform — infrastructure as code
Jenkins — CI/CD pipeline
OIDC — keyless AWS authentication
nginx — web server
Amazon Linux 2023 — EC2 OS