# 🌍 terraform-course

Welcome to **terraform-course**!  
This repository is a hands-on guide to learning **Terraform**, covering core concepts, essential CLI commands, AWS credentials setup, and best practices for Infrastructure as Code (IaC).

---

## 📚 Table of Contents

- [💡 What is Terraform?](#-what-is-terraform)
- [🚀 Installing Terraform](#-installing-terraform)
- [🔐 Setting AWS Credentials](#-setting-aws-credentials)
- [🛠️ Basic Terraform Commands](#️-basic-terraform-commands)
- [📄 Documentation & Learning Resources](#-documentation--learning-resources)
- [📦 Application Code For Pratice](#-sample-terraform-projects)
- [📝 License](#-license)

---

## 💡 What is Terraform?

> Terraform is an open-source tool developed by HashiCorp for building, changing, and versioning infrastructure safely and efficiently.  
> It uses a human-readable configuration language called HCL (HashiCorp Configuration Language).

---

## 🚀 Installing Terraform

1. Download Terraform from [terraform.io](https://www.terraform.io/downloads.html)
2. Add the binary to your system's PATH
3. Verify the installation:
   ```bash
   terraform -v

## 🛠️ Basic Terraform Commands

| Command                                      | Description                              |
|---------------------------------------------|------------------------------------------|
| `terraform init`                            | Initialize the project                   |
| `terraform validate`                        | Validate configuration syntax            |
| `terraform fmt`                             | Format Terraform files                   |
| `terraform plan`                            | Preview infrastructure changes           |
| `terraform plan -target=RESOURCE`           | Preview changes for specific resource    |
| `terraform apply`                           | Apply infrastructure changes             |
| `terraform apply -auto-approve`             | Apply changes without confirmation       |
| `terraform destroy`                         | Destroy all managed infrastructure       |
| `terraform destroy -target=RESOURCE`        | Destroy a specific resource              |
| `terraform state list`                      | List all resources in the state          |
| `terraform output`                          | Show output values                       |
| `terraform show`                            | Show detailed state or plan              |


## 🔐 Setting AWS Credentials

1. Using a .env File (Recommended for Local Dev)
   ```bash
   AWS_ACCESS_KEY_ID=your_access_key
   AWS_SECRET_ACCESS_KEY=your_secret_key
   AWS_SESSION_TOKEN=your_session_token 
2. Use a script or terminal command to export them:
   You can see the command [here](https://github.com/jeremiahjirey/terraform-training/blob/main/credentials)



## 📄 Documentation & Learning Resources
🌐 Official Terraform Docs
https://developer.hashicorp.com/terraform/docs

🔍 Terraform Registry (Modules & Providers)
https://registry.terraform.io

🧱 AWS Terraform Provider Docs
https://registry.terraform.io/providers/hashicorp/aws/latest

📘 Learn Terraform by HashiCorp (Tutorials)
https://developer.hashicorp.com/terraform/tutorials

🎯 Terraform Best Practices
https://www.terraform-best-practices.com/

🧪 Playground (Try Terraform in Browser)
https://learn.hashicorp.com/collections/terraform/aws-get-started

## 📦 Application Code For Pratice
The official owner of the app I use for training:

- 🔗 [handipradana/apigatewayv2](https://github.com/handipradana)  
  Jury of Banyumas Regency LKS 2025.

## 📝 License
© 2025 Imannuel Jeremi

