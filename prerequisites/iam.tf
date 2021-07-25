resource "aws_iam_role" "import" {
  name               = var.import_role
  assume_role_policy = data.aws_iam_policy_document.trust.json
}

data "aws_iam_policy_document" "trust" {
  version = "2012-10-17"

  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    condition {
      test     = "StringEquals"
      values   = ["vmimport"]
      variable = "sts:ExternalId"
    }

    principals {
      identifiers = ["vmie.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_iam_role_policy" "import" {
  name   = "${var.import_role}_policy"
  role   = aws_iam_role.import.id
  policy = data.aws_iam_policy_document.access.json
}

data "aws_iam_policy_document" "access" {
  version = "2012-10-17"

  statement {
    effect = "Allow"
    actions = [
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:PutObject",
      "s3:GetBucketAcl"
    ]
    resources = [
      aws_s3_bucket.import.arn,
      "${aws_s3_bucket.import.arn}/*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "ec2:ModifySnapshotAttribute",
      "ec2:CopySnapshot",
      "ec2:RegisterImage",
      "ec2:Describe*"
    ]
    resources = ["*"]
  }
}
