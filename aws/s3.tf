resource "aws_s3_bucket" "devopsrick_com" {
  bucket = "devopsrick.com"
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  versioning {
    enabled = "true"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_object" "index_html" {
  bucket       = aws_s3_bucket.devopsrick_com.id
  key          = "index.html"
  source       = "files/index.html"
  acl          = "public-read"
  content_type = "text/html"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("files/index.html")
}

resource "aws_s3_bucket_object" "error_html" {
  bucket       = aws_s3_bucket.devopsrick_com.id
  key          = "error.html"
  source       = "files/error.html"
  acl          = "public-read"
  content_type = "text/html"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("files/error.html")
}

resource "aws_s3_bucket" "files_devopsrick_com" {
  bucket = "files.devopsrick.com"
  acl    = "private"

  versioning {
    enabled = "true"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

