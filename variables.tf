variable "private_subnet_count" {
  type    = number
  default = 6

}

variable "public_subnet_count" {
  type    = number
  default = 6

}

variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]

}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default = [
    "10.123.10.0/24",
    "10.123.15.0/24",
    "10.123.20.0/24",
    "10.123.25.0/24",
    "10.123.30.0/24",
    "10.123.35.0/24"
  ]
}

variable "aws_region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-east-1"
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default = [
    "10.123.100.0/24",
    "10.123.105.0/24",
    "10.123.110.0/24",
    "10.123.115.0/24",
    "10.123.120.0/24",
    "10.123.125.0/24"
  ]
}


variable "dynamodb_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default = [
    "10.123.200.0/24",
    "10.123.210.0/24",
    "10.123.220.0/24",
    "10.123.230.0/24",
    "10.123.240.0/24",
    "10.123.250.0/24"
  ]
}

variable "dynamodb_table_name" {
  description = "Realtime website monitoring"
  type        = string
  default     = "Dynamodb"
}

variable "dynamodb_billing_mode" {
  description = "DynamoDB billing mode (PROVISIONED or PAY_PER_REQUEST)"
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "dynamodb_hash_key" {
  description = "Hash key for DynamoDB table"
  type        = string
  default     = "id"
}

variable "dynamodb_range_key" {
  description = "Range key for DynamoDB table (optional)"
  type        = string
  default     = null
}

variable "dynamodb_attributes" {
  description = "List of DynamoDB table attributes"
  type = list(object({
    name = string
    type = string
  }))
  default = [
    {
      name = "id"
      type = "S"
    }
  ]
}

variable "enable_dynamodb_pitr" {
  description = "Enable point-in-time recovery for DynamoDB table"
  type        = bool
  default     = true
}

variable "enable_dynamodb_server_side_encryption" {
  description = "Enable server-side encryption for DynamoDB table"
  type        = bool
  default     = true
}


   