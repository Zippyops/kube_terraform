##MASTER

resource "aws_iam_role" "kube_master" {
  name = "${var.lab_name}-${var.Application_Name}_master_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
      {
      "Effect": "Allow",
      "Action":  "sts:AssumeRole",
      "Principal": {
        "Service": ["ec2.amazonaws.com"]
      }
    }
  ]
}
EOF
}

resource "aws_iam_policy" "kube_master" {
  name = "${var.lab_name}-${var.Application_Name}_master_policy"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "autoscaling:DescribeAutoScalingGroups",
        "autoscaling:DescribeLaunchConfigurations",
        "autoscaling:DescribeTags",
        "ec2:DescribeInstances",
        "ec2:*",
        "ec2:DescribeRegions",
        "ec2:DescribeRouteTables",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeSubnets",
        "ec2:DescribeVolumes",
        "ec2:CreateSecurityGroup",
        "ec2:CreateTags",
        "ec2:CreateVolume",
        "ec2:ModifyInstanceAttribute",
        "ec2:ModifyVolume",
        "ec2:AttachVolume",
        "ec2:AuthorizeSecurityGroupIngress",
        "ec2:CreateRoute",
        "ec2:DeleteRoute",
        "ec2:DeleteSecurityGroup",
        "ec2:DeleteVolume",
        "ec2:DetachVolume",
        "ec2:RevokeSecurityGroupIngress",
        "ec2:DescribeVpcs",
        "elasticloadbalancing:AddTags",
        "elasticloadbalancing:AttachLoadBalancerToSubnets",
        "elasticloadbalancing:ApplySecurityGroupsToLoadBalancer",
        "elasticloadbalancing:CreateLoadBalancer",
        "elasticloadbalancing:CreateLoadBalancerPolicy",
        "elasticloadbalancing:CreateLoadBalancerListeners",
        "elasticloadbalancing:ConfigureHealthCheck",
        "elasticloadbalancing:DeleteLoadBalancer",
        "elasticloadbalancing:DeleteLoadBalancerListeners",
        "elasticloadbalancing:DescribeLoadBalancers",
        "elasticloadbalancing:DescribeLoadBalancerAttributes",
        "elasticloadbalancing:DetachLoadBalancerFromSubnets",
        "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
        "elasticloadbalancing:ModifyLoadBalancerAttributes",
        "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
        "elasticloadbalancing:SetLoadBalancerPoliciesForBackendServer",
        "elasticloadbalancing:AddTags",
        "elasticloadbalancing:CreateListener",
        "elasticloadbalancing:CreateTargetGroup",
        "elasticloadbalancing:DeleteListener",
        "elasticloadbalancing:DeleteTargetGroup",
        "elasticloadbalancing:DescribeListeners",
        "elasticloadbalancing:DescribeLoadBalancerPolicies",
        "elasticloadbalancing:DescribeTargetGroups",
        "elasticloadbalancing:DescribeTargetHealth",
        "elasticloadbalancing:ModifyListener",
        "elasticloadbalancing:ModifyTargetGroup",
        "elasticloadbalancing:RegisterTargets",
        "elasticloadbalancing:DeregisterTargets",
        "elasticloadbalancing:SetLoadBalancerPoliciesOfListener",
        "iam:CreateServiceLinkedRole",
        "kms:DescribeKey",
        "ssm:*"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "kube_master" {
  policy_arn = aws_iam_policy.kube_master.arn
  role = aws_iam_role.kube_master.id
}

resource "aws_iam_instance_profile" "kube_master" {
  name = "${var.lab_name}-${var.Application_Name}_master_profile"
  role = aws_iam_role.kube_master.name
}

##NODE

resource "aws_iam_role" "kube_nodes" {
  name = "${var.lab_name}-${var.Application_Name}_nodes_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
      {
      "Effect": "Allow",
      "Action":  "sts:AssumeRole",
      "Principal": {
        "Service": ["ec2.amazonaws.com"]
      }
    }
  ]
}
EOF
}

resource "aws_iam_policy" "kube_nodes" {
  name = "${var.lab_name}-${var.Application_Name}_nodes_policy"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeInstances",
                "ec2:DescribeRegions",
                "ec2:*",
                "ecr:GetAuthorizationToken",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetDownloadUrlForLayer",
                "ecr:GetRepositoryPolicy",
                "ecr:DescribeRepositories",
                "ecr:ListImages",
                "ecr:BatchGetImage",
                "ssm:*"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "kube_nodes" {
  policy_arn = aws_iam_policy.kube_nodes.arn
  role = aws_iam_role.kube_nodes.id
}

resource "aws_iam_instance_profile" "kube_nodes" {
  name = "${var.lab_name}-${var.Application_Name}_nodes_profile"
  role = aws_iam_role.kube_nodes.name
}


