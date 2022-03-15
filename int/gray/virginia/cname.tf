
terraform {
  backend "artifactory" {}
}

resource "null_resource" "start-db-green-pref-clust" {
provisioner "local-exec" {
    command = "aws rds start-db-cluster --db-cluster-identifier pref-blue-int-db-cluster --region us-east-1"
	#command = "aws --version "
}
}
