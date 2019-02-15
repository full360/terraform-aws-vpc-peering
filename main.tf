#--------------------------------------------------------------
# VPC Peering Requester
#--------------------------------------------------------------
resource "aws_vpc_peering_connection" "requester" {
  count = "${var.requester ? 1 : 0}"

  peer_owner_id = "${var.accepter_owner_id}"
  peer_vpc_id   = "${var.accepter_vpc_id}"
  peer_region   = "${var.accepter_region}"
  vpc_id        = "${var.requester_vpc_id}"
  auto_accept   = "${var.auto_accept}"

  tags = "${merge(var.requester_tags, var.tags)}"
}

# Routes
resource "aws_route" "requester_table" {
  count = "${var.requester && length(var.requester_route_table_ids) > 0 ? length(var.requester_route_table_ids) : 0}"

  route_table_id            = "${var.requester_route_table_ids[count.index]}"
  destination_cidr_block    = "${var.accepter_cidr_block}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.requester.id}"
}

#--------------------------------------------------------------
# VPC Peering Requester Options
#--------------------------------------------------------------
resource "aws_vpc_peering_connection_options" "requester" {
  count = "${var.requester_options ? 1 : 0}"

  vpc_peering_connection_id = "${var.vpc_peering_connection_id}"

  requester {
    allow_remote_vpc_dns_resolution  = "${var.allow_remote_vpc_dns_resolution}"
    allow_classic_link_to_remote_vpc = "${var.allow_classic_link_to_remote_vpc}"
    allow_vpc_to_remote_classic_link = "${var.allow_vpc_to_remote_classic_link}"
  }
}

#--------------------------------------------------------------
# VPC Peering Accepter
#--------------------------------------------------------------
resource "aws_vpc_peering_connection_accepter" "side" {
  count = "${var.accepter ? 1 : 0}"

  vpc_peering_connection_id = "${var.vpc_peering_connection_id}"
  auto_accept               = "${var.auto_accept}"

  tags = "${merge(var.accepter_tags, var.tags)}"
}

resource "aws_vpc_peering_connection_options" "accepter" {
  count = "${var.accepter ? 1 : 0}"

  vpc_peering_connection_id = "${aws_vpc_peering_connection_accepter.side.id}"

  accepter {
    allow_remote_vpc_dns_resolution  = "${var.allow_remote_vpc_dns_resolution}"
    allow_classic_link_to_remote_vpc = "${var.allow_classic_link_to_remote_vpc}"
    allow_vpc_to_remote_classic_link = "${var.allow_vpc_to_remote_classic_link}"
  }
}

# Routes
resource "aws_route" "accepter_table" {
  count = "${var.accepter && length(var.accepter_route_table_ids) > 0 ? length(var.accepter_route_table_ids) : 0}"

  vpc_peering_connection_id = "${aws_vpc_peering_connection_accepter.side.id}"
  route_table_id            = "${var.accepter_route_table_ids[count.index]}"
  destination_cidr_block    = "${var.requester_cidr_block}"
}
