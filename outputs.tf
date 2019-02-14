output "id" {
  description = "ID of the VPC peering connection"
  value       = "${element(concat(aws_vpc_peering_connection.requester.*.id, list("")), 0)}"
}
