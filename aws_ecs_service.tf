
resource "aws_elasticsearch_domain" "default" {
  domain_name           = "ziqy-ecs"
  elasticsearch_version = "7.1"
  
  ebs_options {
    ebs_enabled = var.ebs_volume_size > 0 ? true : false
    volume_size = var.ebs_volume_size
    volume_type = var.ebs_volume_type
  }

  cluster_config {
    instance_count           = var.instance_count
    instance_type            = var.ecs_instance_type
  }
}

resource "aws_elasticsearch_domain_policy" "main" {
  domain_name = "${aws_elasticsearch_domain.default.domain_name}"

  access_policies = <<POLICIES
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "es:*",
      "Resource": "arn:aws:es:eu-central-1:878324441002:domain/ziqy-ecs/*",
      "Condition": {
        "IpAddress": {
          "aws:SourceIp": [
            "217.25.198.73/32",
            "18.185.234.201/32"
          ]
        }
      }
    }
  ]
}
POLICIES
}
