# Practical_Lab9

## 🧠 Overview
This lab demonstrates the practical use of **Terraform functions** to enhance infrastructure-as-code (IaC) configurations. Specifically, this lab focuses on **Collection Functions** and **String Functions** to improve how data is managed, formatted, and presented within Terraform output blocks.

---

## 📚 Learning Objective
To apply built-in Terraform functions to a cloud infrastructure configuration in order to:
- Simplify outputs
- Add logical intelligence
- Increase readability
- Reduce repetition

---

## 🔧 Terraform Functions Used

### ✅ Collection Functions
- `length()` – Counts the number of subnets created
- `distinct()` – Removes duplicate subnet entries
- `slice()` – Selects a subset of subnets
- `contains()` – Checks if a key exists in a map

### ✅ String Functions
- `join()` – Converts a list of public IPs into a single comma-separated string

---

## 📁 Project Structure
```
.
├── main.tf                # Main Terraform configuration
├── variables.tf           # Input variables
├── outputs.tf             # Output values with Terraform functions
├── terraform.tfvars       # Environment-specific variables
├── modules/
│   ├── ec2/               # EC2 instance configuration
│   ├── vpc/               # VPC, subnets, and route tables
│   ├── alb/               # Application Load Balancer
│   ├── rds/               # PostgreSQL RDS instance
│   └── security/          # Security groups
```

---

## 🧪 Example Outputs
```hcl
output "joined_public_ips" {
  value = join(", ", module.ec2.public_ips)
}

output "number_of_public_subnets" {
  value = length(module.vpc.subnet_ids)
}

output "unique_subnets" {
  value = distinct(var.duplicate_subnets)
}

output "first_two_subnets" {
  value = slice(var.subnet_ids, 0, 2)
}

output "has_web_sg" {
  value = contains(keys(var.security_groups), "web-sg")
}
```

---

## 🚀 How to Use

1. Initialize:
```bash
terraform init
```

2. Plan:
```bash
terraform plan
```

3. Apply:
```bash
terraform apply
```

4. Destroy (optional):
```bash
terraform destroy
```

---

## 👩‍💻 Contributors
**Group 2 - Lab 9 PROG8830**
- Prem Jebastian
- Twinkle Mishra
- Rishi Patel

---

## 🔗 GitHub Repository
[https://github.com/TwinkleM97/Practical_Lab9](https://github.com/TwinkleM97/Practical_Lab9)

---

## 📌 Note
Ensure your AWS credentials are correctly configured in your environment before running Terraform commands.
