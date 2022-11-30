output "vpc_id" {
  value = aws_vpc.Prod-rock-VPC.id
}

output "vpc_cidr_block" {
  value = aws_vpc.Prod-rock-VPC.cidr_block
}

output "security_groups_ids" {
  value = [aws_security_group.Test-sec-group.id]
}

output "public_route_table" {
  value = aws_route_table.test-pub-route-table.id
}


