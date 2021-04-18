
#### INSTANCE
variable "AWS_REGIONS" {
  description = "AWS region to launch servers."
  default = "us-east-1"
}


# Ubuntu Server 20.04 LTS (x64)
variable "AWS_AMIS" {
  description = "Image id used in different regions for Ubuntu Server 20.04 LTS (x64)"
  default = {
    us-east-1 = "ami-03d315ad33b9d49c4"
    us-east-2 = "ami-0996d3051b72b5b2c"
    us-west-1 = "ami-0ebef2838fb2605b7"
    us-west-2 = "ami-0928f4202481dfdf6"
  }
}

variable "instance_count" {
  default = "1"
  description = "Ammount of instances to be created"
  
}

# SECURITY GROUPS 
variable "MY_IP" {
  default = "45.174.239.204/32"
  description = "Current local IP for configuring access"
}
variable "ALL_IP" {
  default = "0.0.0.0/0"
  description = "All Sources"
}

variable "SG_APP_NAME" {
  description = "Security Group Name for Servers "
  default = "app"
}

variable "KEY_PUBLIC" {
  description = "Key Name to be used / asigned to ec2 instance"
  default = "ansible"
}

variable "INSTANCE_TYPE" {
  default = "t2.micro"
} 
