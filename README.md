# AWS VPC peering Terraform module [![Build Status](https://travis-ci.org/full360/terraform-aws-vpc-peering.svg?branch=master)](https://travis-ci.org/full360/terraform-aws-vpc-peering)

Terraform module which creates VPC peering resources on AWS.

These types of resources are supported:

- [VPC peering connection][vpc-peering]
- [VPC peering connection options][vpc-peering-options]
- [VPC peering connection accepter][vpc-peering-accepter]
- [Route][aws-route]

## Description

This module can be used to setup VPC peering cross account, or within the same
account, you just need to call the module multiple times, at least 2, one for
the _requester_ side and one for the _accepter_ side.

Keep in mind that in order to accomplish this behaviour with the module we do
not have any mandatory/required variables.

## Usage

Requester side:

```hcl
module "vpc_peering_requester" {
  source = "github.com/full360/terraform-aws-vpc-peering"

  requester = true

  accepter_owner_id   = "1234567890"
  accepter_vpc_id     = "vpc-654321"
  accepter_region     = "us-east-1"
  accepter_cidr_block = "172.16.0.0/24"
  requester_vpc_id    = "vpc-123456"

  requester_private_route_table_ids = [
    "rtb-987656a1e6becddb4",
  ]

  requester_public_route_table_ids = [
    "rtb-123456a1e6becddb3",
  ]

  tags = "${merge(map("Name", "my-peering-connection"), var.tags)}"
}
```

Accepter side:

```hcl
module "vpc_peering_accepter" {
  source = "github.com/full360/terraform-aws-vpc-peering"

  accepter = true

  auto_accept               = true
  vpc_peering_connection_id = "pcx-1234567530b90e383"
  requester_cidr_block      = "172.32.0.0/24"

  accepter_private_route_table_ids = [
    "rtb-0987654321becddb2",
  ]

  accepter_public_route_table_ids = [
    "rtb-1234567890becddb1",
  ]

  tags = "${merge(map("Name", "my-peering-connection"), var.tags)}"
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| accepter | Flag to know the VPC peering side | string | `"false"` | no |
| accepter\_cidr\_block | CIDR block of the accepter side | string | `""` | no |
| accepter\_owner\_id | Account ID of the accepter side | string | `""` | no |
| accepter\_region | Region of the VPC where the accepter connection is | string | `""` | no |
| accepter\_route\_table\_ids | List of route table ids from the accepter side | list | `[]` | no |
| accepter\_tags | Additional tags for the accepter side | map | `{ "Side": "accepter" }` | no |
| accepter\_vpc\_id | VPC ID of the accepter side | string | `""` | no |
| allow\_classic\_link\_to\_remote\_vpc | Allow Classic Link to remote VPC | string | `"false"` | no |
| allow\_remote\_vpc\_dns\_resolution | Allow remote VPC DNS resolution | string | `"true"` | no |
| allow\_vpc\_to\_remote\_classic\_link | Allow VPC to remote Classic Link | string | `"false"` | no |
| auto\_accept | Auto accept the peering | string | `"false"` | no |
| requester | Flag to know the VPC peering side | string | `"false"` | no |
| requester\_cidr\_block | CIDR block of the requester side | string | `""` | no |
| requester\_options | Flag to enable the requester options | string | `"false"` | no |
| requester\_route\_table\_ids | List of route table ids from the requester side | list | `[]` | no |
| requester\_tags | Additional tags for the requester side | map | `{ "Side": "requester" }` | no |
| requester\_vpc\_id | VPC ID of the requester side | string | `""` | no |
| tags | Map of Tags of the peering connection | map | `{}` | no |
| vpc\_peering\_connection\_id | ID of the VPC peering connection when accepting the connection | string | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| connection\_id | ID of the VPC peering connection |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache License Version 2.0. See LICENSE for full details.

[vpc-peering]: https://www.terraform.io/docs/providers/aws/r/vpc_peering.html
[vpc-peering-options]: https://www.terraform.io/docs/providers/aws/r/vpc_peering_options.html
[vpc-peering-accepter]: https://www.terraform.io/docs/providers/aws/r/vpc_peering_accepter.html
[aws-route]: https://www.terraform.io/docs/providers/aws/r/route.html
