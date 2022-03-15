#  resource "null_resource" "ms-ad-blue-pam" {

#   provisioner "local-exec" {
#     command = "aws rds modify-db-instance --db-instance-identifier virsinpamdb-blue --apply-immediately --domain d-906726c844 --domain-iam-role-name rds-directoryservice-access-role  --region us-east-1"
# }
# }

# resource "null_resource" "ms-ad-green-pam" {

#   provisioner "local-exec" {
#     command = "aws rds modify-db-instance --db-instance-identifier virsinpamdb-green --apply-immediately --domain d-906726c844 --domain-iam-role-name rds-directoryservice-access-role  --region us-east-1"
# }
# }

# resource "null_resource" "stop-db-green-pam" {

# }

# resource "null_resource" "deletion-protection-green-pam" {

 #provisioner "local-exec" {
#    command = "aws rds modify-db-instance --db-instance-identifier virsinpamdb-green --apply-immediately --deletion-protection  --region us-east-1"
#  }
#  }

# resource "null_resource" "stop-db-green-pam" {
# provisioner "local-exec" {
#     command = "aws rds stop-db-instance --db-instance-identifier virsinpamdb-green   --region us-east-1"
# }
# }
