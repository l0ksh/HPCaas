variable "instance_count" {
  description = "Value for number of compute nodes"
  type        = number
  default     = 2
}

variable "keypair" {
  description = "Value keypair for compute nodes"
  type        = string
  default     = "controller"
}

variable "security_groups" {
  description = "permit_all security group"
  type        = string
  default     = "permit_all"
}

variable "image" {
  description = "Image to be used"
  type        = string
  default     = "CentOS_SLURM"
}

variable "flavor" {
  description = "Flavor to be used"
  type        = string
  default     = "m1.mini"
}

variable "private" {
  description = "Network used"
  type        = string
  default     = "private"
}
