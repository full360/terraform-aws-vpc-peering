#--------------------------------------------------------------
# Variables
#--------------------------------------------------------------
variable "tags" {
  description = "Map of Tags of the peering connection"
  type        = "map"
  default     = {}
}

variable "requester_tags" {
  description = "Additional tags for the requester side"
  type        = "map"
  default     = {
    "Side" = "requester"
  }
}

variable "accepter_tags" {
  description = "Additional tags for the accepter side"
  type        = "map"
  default     = {
    "Side" = "accepter"
  }
}

variable "accepter_owner_id" {
  description = "Account ID of the accepter side"
  default     = ""
}

variable "accepter_vpc_id" {
  description = "VPC ID of the accepter side"
  default     = ""
}

variable "accepter_region" {
  description = "Region of the VPC where the accepter connection is"
  default     = ""
}

variable "requester_vpc_id" {
  description = "VPC ID of the requester side"
  default     = ""
}

variable "requester" {
  description = "Flag to know the VPC peering side"
  default     = false
}

variable "requester_options" {
  description = "Flag to enable the requester options"
  default     = false
}

variable "accepter" {
  description = "Flag to know the VPC peering side"
  default     = false
}

variable "auto_accept" {
  description = "Auto accept the peering"
  default     = false
}

variable "requester_private_route_table_ids" {
  description = "List of the private route table ids from the requester side"
  type        = "list"
  default     = []
}

variable "requester_public_route_table_ids" {
  description = "List of the public route table ids from the requester side"
  type        = "list"
  default     = []
}

variable "accepter_cidr_block" {
  description = "CIDR block of the accepter side"
  default     = ""
}

variable "vpc_peering_connection_id" {
  description = "ID of the VPC peering connection when accepting the connection"
  default     = ""
}

variable "accepter_private_route_table_ids" {
  description = "List of the private route table ids from the accepter side"
  type        = "list"
  default     = []
}

variable "accepter_public_route_table_ids" {
  description = "List of the public route table ids from the accepter side"
  type        = "list"
  default     = []
}

variable "requester_cidr_block" {
  description = "CIDR block of the requester side"
  default     = ""
}

variable "allow_remote_vpc_dns_resolution" {
  description = "Allow remote VPC DNS resolution"
  default     = true
}

variable "allow_classic_link_to_remote_vpc" {
  description = "Allow Classic Link to remote VPC"
  default     = false
}

variable "allow_vpc_to_remote_classic_link" {
  description = "Allow VPC to remote Classic Link"
  default     = false
}
