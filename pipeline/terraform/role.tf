resource "aws_iam_role" "codepipeline_role" {
  name = "codepipeline-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": [
            "codepipeline.amazonaws.com",
            "codebuild.amazonaws.com"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  inline_policy {
    name = "codepipeline-policies"
    policy = jsonencode({
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "Stmt1624743429276",
          "Action" : "codestar-connections:*",
          "Effect" : "Allow",
          "Resource" : "*"
        },
        {
          "Sid" : "Stmt1624743453790",
          "Action" : "codecommit:*",
          "Effect" : "Allow",
          "Resource" : "*"
        },
        {
          "Sid" : "Stmt1624743459135",
          "Action" : "codedeploy:*",
          "Effect" : "Allow",
          "Resource" : "*"
        },
        {
          "Sid" : "Stmt1624743464417",
          "Action" : "codepipeline:*",
          "Effect" : "Allow",
          "Resource" : "*"
        },
        {
          "Sid" : "Stmt1624744591712",
          "Action" : "s3:*",
          "Effect" : "Allow",
          "Resource" : "*"
        },
        {
          "Sid" : "Stmt1624745010573",
          "Action" : "codebuild:*",
          "Effect" : "Allow",
          "Resource" : "*"
        },
        {
          "Sid" : "Stmt1624751878368",
          "Action" : "ec2:*",
          "Effect" : "Allow",
          "Resource" : "*"
        },
        {
          "Sid" : "Stmt1624754937261",
          "Action" : "logs:*",
          "Effect" : "Allow",
          "Resource" : "*"
        },
        {
          "Sid" : "Stmt1624831630447",
          "Action" : "*",
          "Effect" : "Allow",
          "Resource" : "*"
        }
      ]
    })
  }
}
