# infrastructure-

Terraform configuration for importing and managing existing cloud infrastructure (AWS).

## Prerequisites

- [Terraform](https://www.terraform.io/downloads) **1.5 or newer** (for `import` blocks and config generation)
- AWS credentials configured (`aws configure`, env vars, or IAM role)

## Import workflow: pull existing infrastructure into code

### 1. List resources you want to import

Identify resource IDs in the AWS console or CLI, for example:

- **VPC**: `vpc-0123456789abcdef0`
- **S3 bucket**: bucket name (e.g. `my-bucket`)
- **Security group**: `sg-0123456789abcdef0`
- **EC2 instance**: `i-0123456789abcdef0`
- **IAM role**: role name

### 2. Add import blocks

Edit `imports.tf` and add an `import` block for each resource:

```hcl
import {
  to = aws_vpc.main
  id = "vpc-0123456789abcdef0"
}
```

Use the correct [resource type and ID format](https://registry.terraform.io/providers/hashicorp/aws/latest/docs) for each resource.

### 3. Generate Terraform config from existing resources

```bash
terraform init
terraform plan -generate-config-out=generated.tf
```

Terraform will create `generated.tf` with resource blocks that match the current state of the imported resources.

### 4. Move generated config into your codebase

1. Open `generated.tf` and copy the resource blocks into the appropriate service file (e.g. `vpc.tf`, `s3.tf`) or into modules.
2. Adjust names, add variables, and remove any attributes you don’t want to manage.
3. Delete the corresponding `import` blocks from `imports.tf`.
4. Remove or trim `generated.tf` (it’s only for one-time generation).

### 5. Verify and apply

```bash
terraform plan   # Should show no changes if config matches reality
terraform apply  # Only if you need to apply other changes
```

## Alternative: CLI import (any Terraform version)

For older Terraform or one-off imports:

```bash
terraform import aws_vpc.main vpc-0123456789abcdef0
```

You must then write the matching `resource` block in `.tf` by hand. The import-block + config-generation flow above is easier for many resources.

## Backend (optional)

For remote state (e.g. S3 + DynamoDB for locking), uncomment and fill the `backend "s3"` block in `versions.tf`, then run:

```bash
terraform init -migrate-state
```

## File layout

| File              | Purpose                                          |
|-------------------|--------------------------------------------------|
| `versions.tf`     | Terraform/provider versions, optional backend   |
| `provider.tf`     | AWS provider configuration                      |
| `locals.tf`       | Local values (e.g. region)                       |
| `variables.tf`    | Input variables                                 |
| `outputs.tf`      | Output values                                   |
| `main.tf`         | Root module pointer (resources in split files)  |
| `vpc.tf`          | VPC, subnets, internet gateway, security groups |
| `ec2.tf`          | EC2 instance, EBS volume, key pairs             |
| `s3.tf`           | S3 buckets                                      |
| `dynamodb.tf`     | DynamoDB tables                                 |
| `cloudfront.tf`   | CloudFront distribution                         |
| `iam.tf`          | IAM role and instance profile                   |
| `acm.tf`          | ACM certificates                                |

## Troubleshooting: AccessDenied / permissions boundary

If `terraform plan -generate-config-out=generated.tf` fails with errors like:

- `User ... is not authorized to perform ... because no permissions boundary allows the ... action`

Terraform is running with an IAM identity (e.g. `backend-dev`) whose **permissions boundary** blocks the read actions the AWS provider needs.

**If the error says "no permissions boundary allows"**: the **boundary** (the IAM policy set as the user’s permissions boundary) must explicitly allow that action. Attaching a normal IAM policy to the user is not enough—the boundary policy itself must include the action (e.g. `cloudfront:GetDistribution`). Ask your AWS admin to add the required read actions (EC2, S3, DynamoDB, CloudFront, IAM describe/list) to the **permissions boundary** used by the identity running Terraform.

Fix it in one of these ways:

1. **Use credentials with enough read access**  
   Run Terraform with an IAM user/role that has (or whose permissions boundary allows) read access to EC2, S3, DynamoDB, CloudFront, and IAM for the resources you import. Example: a different AWS profile or SSO role:
   ```bash
   AWS_PROFILE=admin terraform plan -generate-config-out=generated.tf
   ```

2. **Update the IAM user/role used by Terraform**  
   Ask your AWS admin to update the **permissions boundary** (and attach policies) so the identity can perform the read actions Terraform needs for import/plan (e.g. `ec2:Describe*`, `s3:Get*`, `dynamodb:Describe*`, `cloudfront:GetDistribution`, `iam:GetRole`).

## Other clouds

To target **GCP** or **Azure**, add the provider in `versions.tf`, configure it in `provider.tf`, and use the same pattern: add `import` blocks with the correct resource addresses and IDs for that provider, then run `terraform plan -generate-config-out=generated.tf`.