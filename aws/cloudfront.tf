# Create an identity for the cloudfront distribution - this lets us not open the S3 bucket to the world

resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "access-identity-devopsrick-com.s3.amazonaws.com"
}

resource "aws_cloudfront_distribution" "distribution" {
  origin {
    domain_name = aws_s3_bucket.devopsrick_com.bucket_domain_name
    origin_id   = "devopsrick_com"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  aliases = ["www.devopsrick.com"]

  # Simple cache config, and toss all methods but GET and HEAD since we're just reading
  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "devopsrick_com"

    # Throw these away since they are not needed

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 300
    max_ttl                = 86400
  }

  # US, CA, EU edges only because I'm cheap like that

  price_class = "PriceClass_100"
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  # Use the certificate we imported earlier, and use SNI so that we don't pay for dedicated IPs

  viewer_certificate {
    acm_certificate_arn = data.aws_acm_certificate.cert.arn
    ssl_support_method  = "sni-only"
  }
}

