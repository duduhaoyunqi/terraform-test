# 测试map取数，5种方法都可以日后回顾使用

variable "user_names" {
  description = "IAM usernames"
  type        = list(string)
  default     = ["annie", "amy", "alain", "viviane"]
}

resource "aws_iam_user" "iam_users" {
  for_each = { for idx, users in var.user_names : idx => users }

  name = each.value

  tags = {
    "Environment" = "Production"
    "Owner"       = "Terraform"
  }
}

# output "name" {
#   value = { for idx, users in var.user_names : idx => users }
# }

# output "name2" {
#   value = [values(aws_iam_user.iam_users)[*].name]
# }

# output "name3" {
#   value = [for k,v in aws_iam_user.iam_users : aws_iam_user.iam_users[k].name]
# }

# output "name4" {
#   value = [for k,v in aws_iam_user.iam_users: v.name]
# }

# output "name5" {
#   value = [for k,v in aws_iam_user.iam_users: k]
# }
