output "devopsrick_com_bucket" {
  value = aws_s3_bucket.devopsrick_com.website_endpoint
}

output "devopsrick_com_cloudfront" {
  value = aws_cloudfront_distribution.distribution.domain_name
}

