# 测试map取数，5种方法都可以日后回顾使用
# https://developer.hashicorp.com/terraform/language/expressions/for

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

# values takes a map and returns a list containing the values of the elements in that map.
# output "name2" {
#   value = [values(aws_iam_user.iam_users)[*].name]
# }

# output "name3" {
#   value = [for k,v in aws_iam_user.iam_users : aws_iam_user.iam_users[k].name]
# }

# output "name4" {
#   value = [for k,v in aws_iam_user.iam_users: v.name]
# }

# for v in var.map : v
# output "name5-1" {
#   value = [for user in aws_iam_user.iam_users : user]
# }
# output "name5-2" {
#   value = [for user in aws_iam_user.iam_users : user.name]
# }

# output "name6" {
#   value = [for k,v in aws_iam_user.iam_users: k]
# }
