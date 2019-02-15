output "connection_id" {
  description = "ID of the VPC peering connection"
  value       = "${element(concat(aws_vpc_peering_connection.requester.*.id, list("")), 0)}"
}

output "requester_connection_id" {
  description = "Another name for the ID of the VPC peering connection requester side"
  value       = "${element(concat(aws_vpc_peering_connection.requester.*.id, list("")), 0)}"
}

output "accepter_connection_id" {
  description = "ID of the VPC peering connection accepter side"
  value       = "${element(concat(aws_vpc_peering_connection_accepter.side.*.id, list("")), 0)}"
}
