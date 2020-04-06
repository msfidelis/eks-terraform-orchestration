data "aws_iam_policy_document" "eks_service_policy" {
  statement {
    sid = ""

    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:CreateNetworkInterfacePermission",
      "ec2:DeleteNetworkInterface",
      "ec2:DescribeInstances",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSubnets",
      "ec2:DescribeVpcs",
      "ec2:ModifyNetworkInterfaceAttribute",
      "iam:ListAttachedRolePolicies",
      "eks:UpdateClusterVersion"
    ]

    resources = [
      "*",
    ]
  }

  statement {
    sid = ""

    actions = [
      "ec2:CreateTags",
      "ec2:DeleteTags"
    ]

    resources = [
      "arn:aws:ec2:*:*:vpc/*",
      "arn:aws:ec2:*:*:subnet/*"
    ]
  }

  statement {
    sid = ""

    actions = [
      "route53:AssociateVPCWithHostedZones"
    ]

    resources = [
      "*"
    ]
  }

  statement {
    sid = ""

    actions = [
      "logs:CreateLogGroup"
    ]

    resources = [
      "*"
    ]
  }

  statement {
    sid = ""

    actions = [
      "logs:CreateLogStream",
      "logs:DescribeLogStreams",
      "logs:PutLogEvents"
    ]

    resources = [
      "arn:aws:logs:*:*:log-group:/aws/eks/*:*"
    ]
  }

  statement {
    actions = [
      "iam:CreateServiceLinkedRole",
    ]

    resources = [
      "*",
    ]

    condition {
      test     = "StringLike"
      variable = "iam:AWSServiceName"

      values = [
        "eks.amazonaws.com",
      ]
    }
  }

}

resource "aws_iam_policy" "eks_service_policy" {
  name   = format("%s-eks-service-policy", var.cluster_name)
  path   = "/"
  policy = data.aws_iam_policy_document.eks_service_policy.json
}
