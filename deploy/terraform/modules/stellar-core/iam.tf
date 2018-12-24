resource "aws_iam_role_policy" "this" {
  name   = "${var.name}"
  role   = "${aws_iam_role.this.id}"
  policy = "${data.aws_iam_policy_document.ec2_s3_bucket_write_access.json}"
}

resource "aws_iam_instance_profile" "this" {
  name = "${var.name}"
  role = "${aws_iam_role.this.name}"
}

resource "aws_iam_role" "this" {
  name               = "${var.name}"
  description        = "Write access to a specific Stellar Core history archive S3 bucket"
  assume_role_policy = "${data.aws_iam_policy_document.assume_role_ec2_only.json}"
}

data "aws_iam_policy_document" "ec2_s3_bucket_write_access" {
  statement {
    effect    = "Allow"
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.this.id}/*"]
  }
}

data "aws_iam_policy_document" "assume_role_ec2_only" {
  statement {
    actions = ["sts:AssumeRole"]

    principals = {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}
