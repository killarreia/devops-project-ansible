variable "region" {
  description = "AWS Region in use"
  type = string
  default = "eu-west-1"
}

variable "public_key" {
  description = "SSH Public Key"
  type = string
}