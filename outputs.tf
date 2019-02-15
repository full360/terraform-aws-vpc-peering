output "connection_id" {
  description = "ID of the VPC peering connection"
  value       = "${element(concat(aws_vpc_peering_connection.requester.*.id, aws_vpc_peering_connection_accepter.side.*.id, list("")), 0)}"
}
