variable "intance_type" {
  type        = string
  description = "Instance type EC2"
  default     = "t2.micro"

}

variable "key_file" {
  type = string
  description = "Key .pub for connecting to instance"
}


variable "key_name" {
  type = string
  description = "Key name"
}