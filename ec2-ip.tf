# data "aws_caller_identity" "current" {}

# resource "aws_s3_bucket" "saa_bucket" {
#   bucket = "aws-saa-voidwalker"
#   acl    = "private"
#   tags = {
#     Name = "saa_bucket"
#   }
# }

# resource "aws_s3_bucket_policy" "saa_bucket_policy" {
#   bucket = aws_s3_bucket.saa_bucket.id
#   policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Sid": "demo01",
#       "Effect": "Allow",
#       "Principal": {
#         "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${aws_iam_role.saa_role.name}"
#       },
#       "Action": "s3:*",
#       "Resource": [
#         "arn:aws:s3:::aws-saa-voidwalker",
#         "arn:aws:s3:::aws-saa-voidwalker/*"
#       ]
#     }
#   ]
# }
# EOF
# }

# resource "aws_iam_role" "saa_role" {
#   name = "demo-role"
#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Sid": "demo01",
#       "Effect": "Allow",
#       "Principal": {
#         "Service": "ec2.amazonaws.com"
#       },
#       "Action": "sts:AssumeRole"
#     }
#   ]
# }
# EOF
# }

# resource "aws_iam_policy" "saa_s3_policy" {
#   name = "demo-policy"
#   policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Sid": "demo01",
#       "Effect": "Allow",
#       "Action": [
#         "s3:ListBucket",
#         "s3:GetObject",
#         "s3:PutObject"
#       ],
#       "Resource": [
#         "arn:aws:s3:::aws-saa-voidwalker",
#         "arn:aws:s3:::aws-saa-voidwalker/*"
#       ]
#     }
#   ]
# }
# EOF
# }

# resource "aws_iam_role_policy_attachment" "saa_policy_attachment" {
#   role       = aws_iam_role.saa_role.name
#   policy_arn = aws_iam_policy.saa_s3_policy.arn
# }

# resource "aws_iam_role_policy_attachment" "saa_role_policy_attachment" {
#   role       = aws_iam_role.saa_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
# }

# resource "aws_iam_role_policy_attachment" "saa_ssm_patch_association_attachment" {
#   role       = aws_iam_role.saa_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
# }

# resource "aws_iam_instance_profile" "saa_instance_profile" {
#   name = "demo-instance-profile"
#   role = aws_iam_role.saa_role.name
# }

# resource "aws_key_pair" "tf-key-pair" {
# key_name = "tf-key-pair"
# public_key = tls_private_key.rsa.public_key_openssh
# }
# resource "tls_private_key" "rsa" {
# algorithm = "RSA"
# rsa_bits  = 4096
# }
# resource "local_file" "tf-key" {
# content  = tls_private_key.rsa.private_key_pem
# filename = "tf-key-pair"
# }

# resource "aws_instance" "saa_instance" {
#   ami           = "ami-04823729c75214919"
#   instance_type = "t2.micro"
#   iam_instance_profile = aws_iam_instance_profile.saa_instance_profile.name
#   key_name = aws_key_pair.tf-key-pair.key_name

#   tags = {
#     Name = "saa_instance"
#   }

#   user_data = <<-EOF
#       #!/bin/bash
#       echo "Hello, World!" > hello.txt
#       aws s3 cp hello.txt s3://aws-saa-voidwalker/hello.txt
#       EOF
# }
