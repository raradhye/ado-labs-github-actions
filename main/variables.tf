#############################################################################
# VARIABLES
#############################################################################

variable "location" {
  type    = string
  default = "eastus"
}

variable "naming_prefix" {
  type    = string
  default = "adolabs"
}
variable "os_type" {
  type    = string
  default = "Windows"
}
variable "sku_name" {
  type    = string
  default = "S1"
}
