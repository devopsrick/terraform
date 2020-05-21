data "aws_caller_identity" "current" {
}

data "aws_region" "current" {
}

# You need to create the ACM certificate outside of TF since it require manual intervention
data "aws_acm_certificate" "cert" {
  provider    = aws.virginia
  domain      = "devopsrick.com"
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}

