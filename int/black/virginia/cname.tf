provider "aws" {
  region  = var.aws_region
}

terraform {  
  required_version = "~> 1.0"  
  backend "artifactory" {}
}

resource "random_uuid" "tf-upgraded2" {
}
data "aws_route53_zone" "selected" {
  name = "usr.int.pib.dowjones.io"
  private_zone = false
}

## PAM  RDS blue
## Blue is not ready
resource "aws_route53_record" "www1" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name = "pamrds-db-blue"
  type = "CNAME"
  ttl = "300"
  records = ["pamrds-db.usr.int.pib.dowjones.io"]
}

# PAM  RDS Green 
#virqinpamsdb02.cbj11lr1pldv.us-east-1.rds.amazonaws.com
resource "aws_route53_record" "www2" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name = "pamrds-db-green"
  type = "CNAME"
  ttl = "300"
  records = ["pamrds-db.usr.int.pib.dowjones.io"]
}
# PAM  RDS non-Live
resource "aws_route53_record" "www3" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name = "pamrds-db-non-live"
  type = "CNAME"
  ttl = "300"
  records = ["awsifpamdb-green.cbj11lr1pldv.us-east-1.rds.amazonaws.com"]
}


# PAM  RDS Live
resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name = "pamrds-db"
  type = "CNAME"
  ttl = "300"
  records = ["awsifpamdb-blue.cbj11lr1pldv.us-east-1.rds.amazonaws.com"]
}