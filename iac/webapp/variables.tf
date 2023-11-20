variable "env" {
  description = "Environment to deploy"
  type = string
}

variable "rsg_name" {
  description = "Resource group to deploy"
  type = string
  default= "abb"
}